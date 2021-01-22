//
//  LicensePlateController.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-22.
//

import Foundation
import CoreData
import UIKit
//import SwiftUI
//import FirebaseFirestore

class LicensePlateController {
    
    private var moc:NSManagedObjectContext
    let fetchRequest = NSFetchRequest<LicensePlate>(entityName: "LicensePlate")
    
    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func insertLicensePlate(email:String, plateNumber:String) -> InsertStatus {
        do {
            let newLicensePlate = NSEntityDescription.insertNewObject(forEntityName: "LicensePlate", into: moc) as! LicensePlate
            
            newLicensePlate.email = email
            newLicensePlate.plateNumber = plateNumber
            
            try moc.save()
            
            return InsertStatus.success
            
        } catch let error as NSError {
            print(#function, "Error occured during insert")
            return InsertStatus.failed
        }
    }
    
    func getAllLicensePlate() {
        do {
            let result = try moc.fetch(fetchRequest)
            let licensePlates = result as [LicensePlate]
            
            for plate in licensePlates {
                print("Email: \(plate.email) Plate: \(plate.plateNumber)")
            }
            
        } catch let error {
            print(#function, "Couldn't fetch records", error.localizedDescription)
        }
    }
    
    func searchLicensePlate(email:String) -> LicensePlate? {
        let fetchRequest = NSFetchRequest<LicensePlate>(entityName: "LicensePlate")
        
        //equivalent to a WHERE statement
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate
        
        do {
            let result = try moc.fetch(fetchRequest).first
            if result != nil {
                print(#function, "Matching account found wwith email \(email)")
                
                let licensePlate = result as! LicensePlate
                return licensePlate
                
            }
        } catch let error {
            print(#function, error.localizedDescription)
        }
        
        print(#function, "No account found with \(email)")
        return nil
    }
    
    //TODO
    //MARK: This is from my experiment to get firebase to work.
//    @Published var profileList = [Profile]
//    private let
//
//    let store:Firestore
//
//    init(database:Firestore) {
//        self.store = database
//    }
//
//    func insertProfile(profile:Profile) {
//        do {
//            _ = try self.store.collection
//        } catch error as NSError {
//            print(#function, "Error inserting new profile")
//        }
//    }
    
}

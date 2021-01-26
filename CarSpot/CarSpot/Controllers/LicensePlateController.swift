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

class LicensePlateController
{

    private var moc: NSManagedObjectContext
    let fetchRequest = NSFetchRequest<LicensePlate>(entityName: "LicensePlate")

    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func insertLicensePlate(email: String, plateNumber: String) -> InsertStatus
    {
        do {
            let newLicensePlate = NSEntityDescription.insertNewObject(forEntityName: "LicensePlate", into: moc) as! LicensePlate

            newLicensePlate.email = email
            newLicensePlate.plateNumber = plateNumber

            try moc.save()

            return InsertStatus.success

        }
        catch let error as NSError
        {
            print(#function, "Error occured during insert")
            return InsertStatus.failed
        }
    }
    
    

    // get a list of all license plates for a specific user
    func getAllLicensePlatesForUser(email: String) -> [String]
    {
        do {
            let result = try moc.fetch(fetchRequest)
            let licensePlates = result as [LicensePlate]

            var licensePlatesToReturn: [String] = [String]()

            for plate in licensePlates
            {
                if(plate.email == email)
                {
                    licensePlatesToReturn.append(plate.plateNumber!)
                }
//                print("Email: \(plate.email) Plate: \(plate.plateNumber)")
            }
            return licensePlatesToReturn

        } catch let error {
            print(#function, "Couldn't fetch records", error.localizedDescription)
        }
        return [String]()
    }
    
    func getAllPlateNumbersForUser(email: String) -> [PlateNumber]
    {
        do {
            let result = try moc.fetch(fetchRequest)
            let licensePlates = result as [LicensePlate]

            var licensePlatesToReturn:[PlateNumber] = []

            for plate in licensePlates
            {
                if(plate.email == email)
                {
                    licensePlatesToReturn.append(PlateNumber(plateNumber: plate.plateNumber!, email: plate.email!))
                }
//                print("Email: \(plate.email) Plate: \(plate.plateNumber)")
            }
            return licensePlatesToReturn

        } catch let error {
            print(#function, "Couldn't fetch records", error.localizedDescription)
        }
        return [PlateNumber]()
    }
    
    func removeLicensePlate(plateNumber: String) -> Bool {
        // Initialize Fetch Request
        

        // Configure Fetch Request
        //fetchRequest.includesPropertyValues = false

        do {
            let result = try moc.fetch(fetchRequest)
            let licensePlates = result as [LicensePlate]
            
            for item in licensePlates {
                if(item.plateNumber == plateNumber) {
                    moc.delete(item)
                }
            }

            // Save Changes
            try moc.save()
            
            return true

        } catch let error {
            print(#function, "Could not delete license plate", error.localizedDescription)
        }
        return false
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

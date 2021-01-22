//
//  ParkingTicketController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import Foundation
import UIKit
import CoreData

struct ParkingTicketController {
    
    private var moc:NSManagedObjectContext
//    let fetchRequest = NSFetchRequest<ParkingTicket>(entityName: "ParkingTicket")
//
//    init() {
//        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    }
    
//    func insertTicket(email:String, password:String, firstName:String, lastName:String, phoneNumber:Int) -> InsertStatus {
//        do {
//            let newAccount = NSEntityDescription.insertNewObject(forEntityName: "ParkingTicket", into: moc) as! ParkingTicket
//
//            newAccount.email = email
//            newAccount.password = password
//            newAccount.firstName = firstName
//            newAccount.lastName = lastName
//            newAccount.phoneNumber = Int64(phoneNumber)
//
//            try moc.save()
//
//            return InsertStatus.success
//
//        } catch let error as NSError {
//            print(#function, "Error occured during insert")
//            return InsertStatus.failed
//        }
//    }
//
//    func getAllAccounts() {
//        do {
//            let result = try moc.fetch(fetchRequest)
//            let profiles = result as [Profile]
//
//            for profile in profiles {
//                print("Email: \(profile.email) Passord: \(profile.password) Name: \(profile.firstName) \(profile.lastName)")
//            }
//
//        } catch let error {
//            print(#function, "Couldn't fetch records", error.localizedDescription)
//        }
//    }
//
//    func searchAccount(email:String) -> Profile? {
//        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
//
//        //equivalent to a WHERE statement
//        let predicate = NSPredicate(format: "email == %@", email)
//        fetchRequest.predicate = predicate
//
//        do {
//            let result = try moc.fetch(fetchRequest).first
//            if result != nil {
//                print(#function, "Matching account found wwith email \(email)")
//
//                let account = result as! Profile
//                return account
//
//            }
//        } catch let error {
//            print(#function, error.localizedDescription)
//        }
//
//        print(#function, "No account found with \(email)")
//        return nil
//    }

    
}

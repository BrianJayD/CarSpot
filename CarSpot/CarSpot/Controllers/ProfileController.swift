//
//  ProfileController.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-22.
//

import Foundation
import CoreData
import UIKit
//import SwiftUI
//import FirebaseFirestore

class ProfileController {
    
    private var moc:NSManagedObjectContext
    let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
    
    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func insertAccount(email:String, password:String, firstName:String, lastName:String, phoneNumber:Int) -> InsertStatus {
        do {
            let newAccount = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: moc) as! Profile
            
            newAccount.email = email
            newAccount.password = password
            newAccount.firstName = firstName
            newAccount.lastName = lastName
            newAccount.phoneNumber = Int64(phoneNumber)
            
            try moc.save()
            
            return InsertStatus.success
            
        } catch let error as NSError {
            print(#function, error.localizedDescription)
            return InsertStatus.failed
        }
    }
    
    func getAllAccounts() {
        do {
            let result = try moc.fetch(fetchRequest)
            let profiles = result as [Profile]
            
            for profile in profiles {
                print("Email: \(profile.email) Passord: \(profile.password) Name: \(profile.firstName) \(profile.lastName)")
            }
            
        } catch let error {
            print(#function, "Couldn't fetch records", error.localizedDescription)
        }
    }
    
    func checkCredentials(email:String, password:String) -> Bool {
        //search for record
        //check if the account is active
        let accountToValidate = self.searchAccount(email: email)
        
        if accountToValidate != nil {
            if(accountToValidate?.password == password) {
                return true
            }
        }
        return false
    }
    
    func searchAccount(email:String) -> Profile? {
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
        
        //equivalent to a WHERE statement
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate
        
        do {
            let result = try moc.fetch(fetchRequest).first
            if result != nil {
                print(#function, "Matching account found wwith email \(email)")
                
                let account = result as! Profile
                return account
                
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

enum InsertStatus {
    case success
    case exists
    case failed
}

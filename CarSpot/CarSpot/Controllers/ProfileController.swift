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

    private var moc: NSManagedObjectContext
    let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")

    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func insertAccount(email: String, password: String, firstName: String, lastName: String, phoneNumber: Int, licensePlates: [String]) -> InsertStatus {
        do {
            let newAccount = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: moc) as! Profile

            newAccount.email = email.lowercased()
            newAccount.password = password
            newAccount.firstName = firstName
            newAccount.lastName = lastName
            newAccount.phoneNumber = Int64(phoneNumber)
            try moc.save()
            
            for lPlate in licensePlates {
                let licensePlateController = LicensePlateController()
                licensePlateController.insertLicensePlate(email: email.lowercased(), plateNumber: lPlate)
            }

            

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

    func checkCredentials(email: String, password: String) -> Bool {
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

    func searchAccount(email: String) -> Profile?
    {
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")

        //equivalent to a WHERE statement
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate

        do {
            let result = try moc.fetch(fetchRequest).first
            if result != nil {
                print(#function, "Matching account found with email \(email)")

                let account = result as! Profile
                return account

            }
        } catch let error {
            print(#function, error.localizedDescription)
        }

        print(#function, "No account found with \(email)")
        return nil
    }

    func getUser(email: String) -> User
    {
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")

        //equivalent to a WHERE statement
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate

        do {
            let result = try moc.fetch(fetchRequest).first
            if result != nil
            {
                print(#function, "Matching account found wwith email \(email)")

                let licensePlateController = LicensePlateController()
                let licensePlates = licensePlateController.getAllLicensePlatesForUser(email: email)

                let ticketController = TicketController()
                let tickets = ticketController.getAllTicketsForUser(email: email)


                let account = result! as Profile

                let user: User = User(email: account.email!,
                                      password: account.password!,
                                      phone: Int(account.phoneNumber),
                                      firstName: account.firstName!,
                                      lastName: account.lastName!,
                                      licensePlates: licensePlates,
                                      parkingTickets: tickets)

                return user
            }
        }
        catch let error {
            print(#function, error.localizedDescription)
        }

        print(#function, "No account found with \(email)")
        return User()
    }

}

enum InsertStatus {
    case success
    case exists
    case failed
}

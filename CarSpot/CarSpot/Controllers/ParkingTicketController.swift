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
    let fetchRequest = NSFetchRequest<Ticket>(entityName: "Ticket")

    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func insertTicket(email: String, buildingCode: String, noOfHours: Int, licensePlate: String, hostSuite: String, location: String) -> InsertStatus {
        do {
            let newTicket = NSEntityDescription.insertNewObject(forEntityName: "Ticket", into: moc) as! Ticket

            newTicket.email = email
            newTicket.buildingCode = buildingCode
            newTicket.noOfHours = Int64(noOfHours)
            newTicket.licensePlate = licensePlate
            newTicket.hostSuite = hostSuite
            newTicket.location = location

            try moc.save()

            return InsertStatus.success

        } catch let error as NSError {
            print(#function, "Error occured during insert")
            return InsertStatus.failed
        }
    }

    func getAllTicket() {
        do {
            let result = try moc.fetch(fetchRequest)
            let tickets = result as [Ticket]

            for ticket in tickets {
                print(#function, "Email: \(ticket.email) License Plate: \(ticket.licensePlate) location: \(ticket.location)")
            }

        } catch let error {
            print(#function, "Couldn't fetch records", error.localizedDescription)
        }
    }

    func searchTicket(email:String) -> Ticket? {
        let fetchRequest = NSFetchRequest<Ticket>(entityName: "Ticket")

        //equivalent to a WHERE statement
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate

        do {
            let result = try moc.fetch(fetchRequest).first
            if result != nil {
                print(#function, "Matching account found wwith email \(email)")

                let ticket = result as! Ticket
                return ticket

            }
        } catch let error {
            print(#function, error.localizedDescription)
        }

        print(#function, "No account found with \(email)")
        return nil
    }

    
}

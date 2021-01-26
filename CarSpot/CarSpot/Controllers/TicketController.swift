//
//  ParkingTicketController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import Foundation
import UIKit
import CoreData

struct TicketController
{

    private var moc: NSManagedObjectContext
    let fetchRequest = NSFetchRequest<Ticket>(entityName: "Ticket")

    init() {
        self.moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func insertTicket(ticket: ParkingTicket) -> InsertStatus
    {
        do {
            let newTicket = NSEntityDescription.insertNewObject(forEntityName: "Ticket", into: moc) as! Ticket

            newTicket.id = ticket.id
            newTicket.email = ticket.email
            newTicket.buildingCode = ticket.buildingCode
            newTicket.noOfHours = Int64(ticket.noOfHours)
            newTicket.licensePlate = ticket.licensePlate
            newTicket.hostSuite = ticket.hostSuite
            newTicket.date = ticket.date

            let newAddress = NSEntityDescription.insertNewObject(forEntityName: "Address", into: moc) as! Address

            newAddress.id = ticket.id
            newAddress.lat = ticket.location.lat
            newAddress.lon = ticket.location.lon
            newAddress.streetAddress = ticket.location.streetAddress
            newAddress.city = ticket.location.city
            newAddress.country = ticket.location.country
            newAddress.isCurrentLocation = ticket.location.isCurrentLocation

            try moc.save()

            print(#function, "Ticket added!")
            return InsertStatus.success
        }
        catch let error as NSError
        {
            print(#function, "Error occured during insert", error.localizedDescription)
            return InsertStatus.failed
        }
    }

    func getAllTicketsForUser(email: String) -> [ParkingTicket]
    {
        do {
            // SORT
            let sort = NSSortDescriptor(key: "date", ascending: false)
            fetchRequest.sortDescriptors = [sort]
            
            let result = try moc.fetch(fetchRequest)
            let tickets = result as [Ticket]

            var parkingTickets = [ParkingTicket]()

            let addressController = AddressController()

            for ticket in tickets
            {
                if(ticket.email == email)
                {
                    let location: Location = addressController.getAddressForTicket(id: ticket.id!)

                    let ticketToAdd = ParkingTicket(id: ticket.id!,
                                                    email: ticket.email!,
                                                    buildingCode: ticket.buildingCode!,
                                                    noOfHours: Int(ticket.noOfHours),
                                                    licensePlate: ticket.licensePlate!,
                                                    hostSuite: ticket.hostSuite!,
                                                    location: location,
                                                    date: ticket.date!)

                    parkingTickets.append(ticketToAdd)
                }
            }
           // print(#function, "Tickets: \(parkingTickets.count)")
            return parkingTickets
        }
        catch let error
        {
            print(#function, "Couldn't fetch records", error.localizedDescription)
        }
        return [ParkingTicket]()
    }
}

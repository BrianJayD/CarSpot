//
//  User.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import Foundation

struct User
{
    var email: String = ""
    var password: String = ""
    var phone: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var licensPlates: [String] = [String()]
    var parkingTickets: [ParkingTicket] = [ParkingTicket]()

    init()
    {

    }

    init(email: String, password: String, phone: Int, firstName: String, lastName: String, licensPlates: [String], parkingTickets: [ParkingTicket])
    {
        self.email = email
        self.password = password
        self.phone = phone
        self.firstName = firstName
        self.lastName = lastName
        self.licensPlates = licensPlates
        self.parkingTickets = parkingTickets
    }

}

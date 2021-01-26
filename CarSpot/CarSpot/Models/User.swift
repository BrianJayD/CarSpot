//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import Foundation

struct User {
    var email: String = ""
    var password: String = ""
    var phone: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var licensePlates: [String] = [String()]
    var parkingTickets: [ParkingTicket] = [ParkingTicket]()

    init(){}

    init(email: String, password: String, phone: Int, firstName: String, lastName: String, licensePlates: [String], parkingTickets: [ParkingTicket]) {
        self.email = email
        self.password = password
        self.phone = phone
        self.firstName = firstName
        self.lastName = lastName
        self.licensePlates = licensePlates
        self.parkingTickets = parkingTickets
    }

}

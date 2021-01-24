//
//  ParkingTicket.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import Foundation

class ParkingTicket: Codable, Identifiable {
    var id = UUID()
    var email: String
    var buildingCode: String  // exactly 5 alphanumeric
    var noOfHours: Int        // 1-hour or less, 4-hour, 12-hour, 24-hour
    var licensePlate: String  // min 2, max 8 alphanumeric
    var hostSuite: String     // min 2, max 5 alphanumeric
    var location: Location    // street address, lat and lng
    var date: Date            // system date

    init(id: UUID, email: String, buildingCode: String, noOfHours: Int, licensePlate: String, hostSuite: String, location: Location, date: Date) {
        self.email = email
        self.buildingCode = buildingCode
        self.noOfHours = noOfHours
        self.licensePlate = licensePlate
        self.hostSuite = hostSuite
        self.location = location
        self.date = date
    }
    
    var dateString: String
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter.string(from: date)
    }


}

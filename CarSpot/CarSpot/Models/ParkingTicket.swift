//
//  ParkingTicket.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import Foundation

class ParkingTicket: Codable, Identifiable
{
    var id = UUID()
    var buildingCode: String = ""          // exactly 5 alphanumeric
    var noOfHours: Int = 0                 // 1-hour or less, 4-hour, 12-hour, 24-hour
    var licensePlate: String = ""          // min 2, max 8 alphanumeric
    var hostSuite: String = ""             // min 2, max 5 alphanumeric
    var location: Location = Location()   // street address, lat and lng
    var date: Date = Date()                // system date
    
}

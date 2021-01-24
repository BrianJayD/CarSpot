//
//  PlateNumber.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-24.
//

import Foundation

class PlateNumber: Codable, Identifiable {
    let plateNumber:String
    let email:String
    
    init(plateNumber:String, email:String) {
        self.plateNumber = plateNumber
        self.email = email
    }
    
    init(plateNumber:String) {
        self.plateNumber = plateNumber
        self.email = ""
    }
}

//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
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

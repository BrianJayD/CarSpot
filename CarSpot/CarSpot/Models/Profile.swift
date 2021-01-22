////
////  Profile.swift
////  CarSpot
////
////  Created by Brian Domingo on 2021-01-22.
////
//
//import Foundation
//import FirebaseFirestoreSwift
//
//struct Profile: Codable, Identifiable {
//    var id: ObjectIdentifier
//
//    @DocumentID var email:String? = UUID().uuidString
//    var phone:Int = 0
//    var firstName:String = ""
//    var lastName:String = ""
//    var licensePlates:String
//
//    init(){}
//
//    init(email:String, phone:Int, firstName:String, lastName:String, licensePlates:String) {
//        self.email = email
//        self.phone = phone
//        self.firstName = firstName
//        self.lastName = lastName
//        self.licensePlates = licensePlates
//    }
//}
//
//extension Profile {
//    init?(dictionary:[String:Any]) {
//        guard let email = dictionary["email"] as? String else {
//            return nil
//        }
//
//        guard let phone = dictionary["phone"] as? String else {
//            return nil
//        }
//
//        guard let firstName = dictionary["firstName"] as? String else {
//            return nil
//        }
//
//        guard let lastName = dictionary["lastName"] as? String else {
//            return nil
//        }
//
//        guard let licensePlates = dictionary["lisencePlates"] as? String else {
//            return nil
//        }
//
//        self.init(email: email, phone: phone, firstName: firstName, lastName: lastName, licensePlates: licensePlates)
//
//
//    }
//}

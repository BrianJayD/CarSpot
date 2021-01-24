//
//  MainViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController
{
    let licensePlateController = LicensePlateController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
            
        for plate in licensePlateController.getAllLicensePlatesForUser(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)!) {
            print(plate)
        }
        
        
        UserDefaults.standard.set(true, forKey: Login.LOGGED_IN.rawValue)
        
        addSubSwiftUIView(swiftUIView: MainSwiftUIView())
    }

}

//
//  LoginViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    let profileController = ProfileController()
    let licensePlateController = LicensePlateController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.addSubSwiftUIView(swiftUIView: LoginSwiftUIView())
        profileController.getAllAccounts()
        
        //removes navigation back button to entry point
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        profileController.getAllAccounts()
        licensePlateController.getAllLicensePlate()
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        
//        print(profileController.checkCredentials(email: tfEmail.text
//                                                ?? "", password: tfPassword.text ?? ""))
        
        if(profileController.checkCredentials(email: tfEmail.text ?? "", password: tfPassword.text ?? "")) {
            print("Log In Successful")

            performSegue(withIdentifier: "mainPageSeguaTemp", sender: nil)
        } else {
            print("Log In Failed")
        }
    }
    
}

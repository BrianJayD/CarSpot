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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.addSubSwiftUIView(swiftUIView: LoginSwiftUIView())
        profileController.getAllAccounts()
        
        
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        
        if(profileController.checkCredentials(email: tfEmail.text ?? "", password: tfPassword.text ?? "")) {
            print("Log In Successful")
            //self.performSegue(withIdentifier: "ToMain", sender: self)
        } else {
            print("Log In Failed")
        }
    }
    
}

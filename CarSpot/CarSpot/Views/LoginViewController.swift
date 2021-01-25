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
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var switchRememberMe: UISwitch!
    
    let profileController = ProfileController()
    let licensePlateController = LicensePlateController()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.addSubSwiftUIView(swiftUIView: LoginSwiftUIView())
        //profileController.getAllAccounts()

        // if you want to completely remove the nav bar in the login screen
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //removes navigation back button to entry point
        self.navigationItem.setHidesBackButton(true, animated: true)

        //profileController.getAllAccounts()
        //CHANGE email depending which user you are checking 
        for plate in licensePlateController.getAllLicensePlatesForUser(email: "b@b.com") {
            print(plate)
        }

    }

    // if you want to completely remove the nav bar in the login screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    @IBAction func logIn(_ sender: Any) {

//        print(profileController.checkCredentials(email: tfEmail.text
//                                                ?? "", password: tfPassword.text ?? ""))
        if(checkTextFields()) {
            if(profileController.checkCredentials(email: tfEmail.text?.lowercased() ?? "", password: tfPassword.text ?? "")) {
                print("Log In Successful")
                
                // set user defaults for current verified user
                UserDefaults.standard.setValue(tfEmail.text!, forKey: Login.CURRENT_USER.rawValue)
                UserDefaults.standard.setValue(true, forKey: Login.LOGGED_IN.rawValue)
                
                //check remember me switch
                if(switchRememberMe.isOn) {
                    UserDefaults.standard.setValue(true, forKey: Login.REMEMBER_ME.rawValue)
                    print(#function, UserDefaults.standard.string(forKey: Login.REMEMBER_ME.rawValue))
                }

                //reset error message
                if(!lblErrorMessage.isHidden) {
                    lblErrorMessage.text = "Error label"
                    lblErrorMessage.isHidden = true
                }
                
                performSegue(withIdentifier: "mainPageSeguaTemp", sender: nil)
                
            } else {
                lblErrorMessage.text = "Incorrect Username/Password"
                lblErrorMessage.isHidden = false
                print("Log In Failed")
            }
        } else {
            lblErrorMessage.isHidden = false
            lblErrorMessage.text = "Username/Password can not be empty"
        }
    }
    
    func checkTextFields() -> Bool {
        if (tfEmail.text == nil || tfPassword == nil) {
            return false
        }
        return true
    }

}

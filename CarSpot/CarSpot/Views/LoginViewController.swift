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

        // if you want to completely remove the nav bar in the login screen
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //removes navigation back button to entry point
        self.navigationItem.setHidesBackButton(true, animated: true)

        profileController.getAllAccounts()
        //  licensePlateController.getAllLicensePlate()

    }

    // if you want to completely remove the nav bar in the login screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    @IBAction func logIn(_ sender: Any) {

//        print(profileController.checkCredentials(email: tfEmail.text
//                                                ?? "", password: tfPassword.text ?? ""))

        if(profileController.checkCredentials(email: tfEmail.text ?? "", password: tfPassword.text ?? "")) {
            print("Log In Successful")

            // set user defaults for current verified user
            UserDefaults.standard.setValue(tfEmail.text!, forKey: Login.CURRENT_USER.rawValue)
            UserDefaults.standard.setValue(true, forKey: Login.LOGGED_IN.rawValue)

            performSegue(withIdentifier: "mainPageSeguaTemp", sender: nil)
        } else {
            print("Log In Failed")
        }
    }

}

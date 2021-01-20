//
//  LoginViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubSwiftUIView(swiftUIView: LoginSwiftUIView())
        
    }
    
}

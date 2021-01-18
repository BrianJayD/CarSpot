//
//  LoginViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {

    let hostController = UIHostingController(rootView: LoginSwiftUIView())

    override func viewDidLoad() {
        super.viewDidLoad()

//        addChild(hostController)
//        hostController.view.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(hostController.view)
//
//        hostController.view.centerXAnchor.constraint(
//            equalTo: view.centerXAnchor).isActive = true
//        hostController.view.centerYAnchor.constraint(
//            equalTo: view.centerYAnchor).isActive = true
//
//        hostController.didMove(toParent: self)
    }
    
}

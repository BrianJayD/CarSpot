//
//  ViewController.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-17.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    let hostController = UIHostingController(rootView: HostUIView())

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(hostController)
        hostController.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(hostController.view)

        hostController.view.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        hostController.view.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true

        hostController.didMove(toParent: self)
    }


}


//
//  HistoryViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit
import SwiftUI

class HistoryViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setupView()
    }
    

    func setupView()
    {
        let hostController = UIHostingController(rootView: HistorySwiftUIView())
        hostController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(hostController)
        self.view.addSubview(hostController.view)
        hostController.view.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        hostController.view.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        hostController.didMove(toParent: self)
    }

}

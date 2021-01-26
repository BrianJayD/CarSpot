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
    }

    // when view loads - putting here so when user comes back to this page, it re-loads
    override func viewDidAppear(_ animated: Bool)
    {
        print("MainViewController - viewDidAppear")
        addSubSwiftUIView(swiftUIView: MainSwiftUIView())
    }

}

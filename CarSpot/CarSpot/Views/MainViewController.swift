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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        UserDefaults.standard.set(true, forKey: Login.LOGGED_IN.rawValue)
        
        addSubSwiftUIView(swiftUIView: MainSwiftUIView())
    }

}

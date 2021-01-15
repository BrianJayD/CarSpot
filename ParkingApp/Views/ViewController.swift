//
//  ViewController.swift
//  ParkingApp
//
//  Created by Brian Domingo on 2021-01-15.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    //pass in swiftUI view into Hosting Controller
    let contentView = UIHostingController(rootView: HostUIView())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupHC()
        setupContraints()
    }
    
    func setupHC() {
        self.addChild(contentView)
        //add host controller as the subview
        self.view.addSubview(contentView.view)
        
        contentView.didMove(toParent: self)
    }
    
    func setupContraints() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    }


}


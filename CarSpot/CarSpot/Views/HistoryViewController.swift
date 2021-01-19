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

        setupSwiftUIView()
    }


    func setupSwiftUIView()
    {
        let hostController = UIHostingController(rootView: HistorySwiftUIView())
        self.addChild(hostController)
        hostController.view.frame = self.view.frame
        self.view.addSubview(hostController.view)
        hostController.didMove(toParent: self)
    }

}

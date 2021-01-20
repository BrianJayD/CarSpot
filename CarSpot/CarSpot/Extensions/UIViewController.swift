//
//  UIViewController.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-20.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController {

    func addSubSwiftUIView<Content>(swiftUIView: Content) where Content:View {
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)

        self.view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        hostingController.didMove(toParent: self)
    }
}

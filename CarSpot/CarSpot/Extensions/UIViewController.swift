//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
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

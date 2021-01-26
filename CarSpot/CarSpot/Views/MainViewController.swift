//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
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
        if(!UserDefaults.standard.bool(forKey: Login.LOGGED_IN.rawValue)) {
            _ = navigationController?.popViewController(animated: true)
        }
        addSubSwiftUIView(swiftUIView: MainSwiftUIView())
    }

}

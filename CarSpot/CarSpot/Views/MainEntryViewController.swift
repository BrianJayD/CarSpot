//
//  MainEntryViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-22.
//

import UIKit

class MainEntryViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()


        UserDefaults.standard.setValue(true, forKey: Login.LOGGED_IN.rawValue)

        loadStartingPage()
    }


    func loadStartingPage()
    {
        if (UserDefaults.standard.bool(forKey: Login.LOGGED_IN.rawValue))
        {
            performSegue(withIdentifier: "mainPageSegua", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "loginSegua", sender: nil)
        }
    }


}

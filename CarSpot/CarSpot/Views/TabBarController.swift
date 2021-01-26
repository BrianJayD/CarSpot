//
//  TabBarController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import UIKit

class TabBarController: UITabBarController
{
    let defaults = UserDefaults.standard

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    // setup nav buttons and logo title view
    func setup()
    {
        let titleImage = UIImageView(image: UIImage(named: "CarSpotLogo2")?.resizableImage(withCapInsets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6), resizingMode: .stretch))
        titleImage.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImage

        // display overflow menu
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "ic_about"), style: .plain, target: self, action: #selector(menu(sender:)))

        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "ic_logout"), style: .plain, target: self, action: #selector(logout(sender:)))

    }

    // about alert dialog
    @objc func menu(sender: AnyObject)
    {
        let aboutDialog = UIAlertController(title: "About", message: "CarSpot: by Brian Domingo and Daryl Dyck", preferredStyle: .alert)
        aboutDialog.addAction((UIAlertAction(title: "Close", style: .default, handler: nil)))
        present(aboutDialog, animated: true, completion: nil)
    }

    // logout of app
    @objc func logout(sender: AnyObject)
    {
        // reset userDefaults
        defaults.set(nil, forKey: Login.CURRENT_USER.rawValue)
        defaults.set(false, forKey: Login.LOGGED_IN.rawValue)
        defaults.set(false, forKey: Login.REMEMBER_ME.rawValue)
        // prepare segua
        _ = navigationController?.popToRootViewController(animated: true)
    }
}

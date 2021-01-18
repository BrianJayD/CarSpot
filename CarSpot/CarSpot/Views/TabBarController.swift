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
    
    
    // setup nav buttons and other values
    func setup()
    {
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_header"))
        
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "ic_logout"), style: .plain, target: self, action: #selector(logout(sender:)))
        
    }
    
    // logout of app
    @objc func logout(sender: AnyObject)
    {
        defaults.set(nil, forKey: Login.CURRENT_USER.rawValue)
        _ = navigationController?.popToRootViewController(animated: true)
    }
}

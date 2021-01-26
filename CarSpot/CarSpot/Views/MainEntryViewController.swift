//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import UIKit

class MainEntryViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadStartingPage()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        loadStartingPage()
    }


    // decide which page to load
    func loadStartingPage()
    {
        if (UserDefaults.standard.bool(forKey: Login.REMEMBER_ME.rawValue))
        {
            performSegue(withIdentifier: "mainPageSegua", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "loginSeguaTemp", sender: nil)
        }
    }
}

//
//  SignUpViewController.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubSwiftUIView(swiftUIView: SignUpSwiftUIView())
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func goBack(){
        _ = navigationController?.popViewController(animated: true)
    }

}

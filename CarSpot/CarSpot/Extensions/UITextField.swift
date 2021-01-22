//
//  UITextField.swift
//  WhatTOdo
//
//  Created by Daryl Dyck on 2020-12-01.
//

import UIKit
import Foundation

extension UITextField
{
    // check for valid input
    func checkForValidInput() -> Bool
    {
        var valid = true

        if (self.text == nil || self.text == "" || self.text!.count <= 1)
        {
            valid = false
            setTextFieldError()
        }

        return valid
    }

    func checkLicensePlate(min: Int, max: Int) -> Bool
    {
        var valid = true

        if (self.text == "" || self.text!.count < min || self.text!.count > max)
        {
            valid = false
            setTextFieldError()
        }

        return valid
    }

    // set error on current textField
    func setTextFieldError()
    {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        self.placeholder = "Please enter valid input."
    }
}

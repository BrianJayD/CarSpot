//
//  String.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-21.
//

import Foundation

extension String
{
    
    // check for valid input
    func checkForValidInput(min: Int, max: Int) -> Bool
    {
        var valid = true
        
        if (self == "" || self.count < min || self.count > max)
        {
            valid = false
        }
        
        return valid
    }
    
    
}

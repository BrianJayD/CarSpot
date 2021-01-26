//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
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

    func checkBuildingCode() -> Bool
    {
        var valid = true

        if (self.count != 5)
        {
            valid = false
        }

        return valid
    }

    func checkSuiteNumber() -> Bool
    {
        var valid = true

        if (self == "" || self.count < 2 || self.count > 5)
        {
            valid = false
        }

        return valid
    }

    func checkStreetAddress() -> Bool
    {
        var valid = true

        if (self == "" || self.count < 3)
        {
            valid = false
        }

        return valid
    }


}

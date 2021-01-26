//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import Foundation

enum ParkingHours: String
{
    case one = "1 Hr."
    case four = "4 Hrs."
    case twelve = "12 Hrs."
    case twentyfour = "24 Hrs."

    static func getIntValue(selection: Int) -> Int
    {
        switch(selection)
        {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 12
        case 3:
            return 24
        default:
            return 1
        }
    }
}

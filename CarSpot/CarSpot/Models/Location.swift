//
//  Location.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-20.
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable
{
    var id = UUID()
    var lat: Double = 0
    var lon: Double = 0
    var streetAddress: String = ""
    var city: String = ""
    var country: String = ""
    var isCurrentLocation: Bool = false

    var coordinate: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(self.lat), longitude: CLLocationDegrees(self.lon))
    }
    
    init()
    {
        
    }
    
    init(lat: Double, lon: Double, isCurrentLocation: Bool)
    {
        self.lat = lat
        self.lon = lon
        self.isCurrentLocation = isCurrentLocation
    }
    
    
}

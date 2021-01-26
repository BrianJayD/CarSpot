//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable, Equatable
{
    var id = UUID()
    var lat: Double = 0
    var lon: Double = 0
    var streetAddress: String = ""
    var city: String = ""
    var country: String = ""
    var isCurrentLocation: Bool = false

    var coordinates: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(self.lat), longitude: CLLocationDegrees(self.lon))
    }

    init()
    {

    }

    init(lat: Double, lon: Double, streetAddress: String, isCurrentLocation: Bool)
    {
        self.lat = lat
        self.lon = lon
        self.isCurrentLocation = isCurrentLocation
        self.streetAddress = streetAddress
    }
    
    init(id: UUID, lat: Double, lon: Double, streetAddress: String, city: String, country: String)
    {
        self.lat = lat
        self.lon = lon
        self.streetAddress = streetAddress
        self.city = city
        self.country = country
        self.isCurrentLocation = false
    }


}

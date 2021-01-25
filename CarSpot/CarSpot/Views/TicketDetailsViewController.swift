//
//  TicketDetailsViewController.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-22.
//

import UIKit
import SwiftUI
import MapKit

class TicketDetailsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    var ticket: ParkingTicket?
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var buildingCodeLabel: UILabel!
    @IBOutlet weak var suiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setupFields()
        setupLocations()
    }

    // setup all label views
    func setupFields()
    {
        self.dateLabel.text = ticket!.dateString
        self.lengthLabel.text = "\(ticket!.noOfHours) hour(s)"
        self.startTimeLabel.text = ticket!.startTime
        self.endTimeLabel.text = ticket!.endTime
        self.buildingCodeLabel.text = ticket!.buildingCode
        self.suiteLabel.text = ticket!.hostSuite
        self.addressLabel.text = ticket!.location.streetAddress
        self.address2Label.text = "\(ticket!.location.city), \(ticket!.location.country)"
        self.licensePlateLabel.text = ticket!.licensePlate
    }

    // setup current location and ticket location
    func setupLocations()
    {
        print(#function)

        self.mapView.delegate = self

        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
}


extension TicketDetailsViewController
{
    // set current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(#function)

        guard let myLocation: CLLocationCoordinate2D = manager.location?.coordinate
            else { return }

        print("Latitude: \(myLocation.latitude) Longitide: \(myLocation.longitude)")

        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: myLocation, span: span)

        self.mapView.setRegion(region, animated: true)

        getAddress(lat: myLocation.latitude, lon: myLocation.longitude)

        var locationArray: [Location] = [Location]()

        locationArray.append(Location(id: UUID(),
                                      lat: myLocation.latitude,
                                      lon: myLocation.longitude,
                                      streetAddress: "Current Location",
                                      city: "Toronto",
                                      country: "Canada"))

        locationArray.append(self.ticket!.location)

        self.showRoute(start: locationArray[0].coordinates, end: locationArray[1].coordinates)
        self.displayMarker(locations: locationArray)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {

    }
}

extension TicketDetailsViewController
{
    // get ticket location from lat, lon
    func getAddress(lat: Double, lon: Double)
    {
        print(#function)

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)

        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if (error != nil)
            {
                print("Error")
            }
            else
            {
                if let placemarks = placemark, let placemark = placemarks.first
                {
                    var addressString: String = ""

                    if placemark.subLocality != nil
                    {
                        addressString = addressString + placemark.subLocality! + ", "
                    }
                    if placemark.thoroughfare != nil
                    {
                        addressString = addressString + placemark.thoroughfare! + ", "
                    }
                    if placemark.locality != nil
                    {
                        addressString = addressString + placemark.locality! + ", "
                    }
                    if placemark.country != nil
                    {
                        addressString = addressString + placemark.country! + ", "
                    }
                    if placemark.postalCode != nil
                    {
                        addressString = addressString + placemark.postalCode! + " "
                    }

                    print("Address String: \(addressString)")
                }
                else
                {
                    print("Error")
                }
            }
        }
    }

    // display a marker for locations on map
    func displayMarker(locations: [Location])
    {
        print(#function)

        for location in locations
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
            annotation.title = location.streetAddress
            self.mapView.addAnnotation(annotation)
        }
        print("Finished")
    }

    // display the route between current location and ticket location
    func showRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D)
    {
        print("showRoute")

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let response = response else { return }
            if let route = response.routes.first
            {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 100, left: 100, bottom: 300, right: 100), animated: true)
            }
        }
        print("finished route")
    }

    // callback for setting route 
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        print(#function)
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(named: "accent")
        renderer.lineWidth = 5.0
        return renderer
    }

}

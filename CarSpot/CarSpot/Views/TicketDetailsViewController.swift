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
    @IBOutlet weak var buildingCodeLabel: UILabel!
    @IBOutlet weak var suiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        //  setupSwiftUIView()

        setupFields()
        setupLocations()
    }

    func setupFields()
    {
        self.dateLabel.text = ticket!.dateString
        self.lengthLabel.text = "\(ticket!.noOfHours) hour(s)"
        self.buildingCodeLabel.text = ticket!.buildingCode
        self.suiteLabel.text = ticket!.hostSuite
        self.addressLabel.text = ticket!.location.streetAddress
        self.address2Label.text = "\(ticket!.location.city) \(ticket!.location.country)"
        self.licensePlateLabel.text = ticket!.licensePlate
    }

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

//        let locationArray = [
//            Location(name: "Toronto", coordinates: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832)),
//            Location(name: "Waterloo", coordinates: CLLocationCoordinate2D(latitude: 43.4643, longitude: -80.3832))]

        //  self.displayMarker(locations: locationArray)

//        self.showRoute(start: locationArray[0].coordinates, end: locationArray[1].coordinates)
    }


    func setupSwiftUIView()
    {
        let hostController = UIHostingController(rootView: TicketDetails(ticket: ticket!))
        self.addChild(hostController)
        hostController.view.frame = self.view.frame
        self.view.addSubview(hostController.view)
        hostController.didMove(toParent: self)
    }


}


//MARK: Display the current location
extension TicketDetailsViewController
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print(#function)

        guard let myLocation: CLLocationCoordinate2D = manager.location?.coordinate
            else { return }

        print("Latitude: \(myLocation.latitude) Longitide: \(myLocation.longitude)")

        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: myLocation, span: span)

        self.mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation
        annotation.title = "Current Location"


//        let locationArray = [
//            Location(name: "Toronto", coordinates: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832)),
//            Location(name: "Waterloo", coordinates: CLLocationCoordinate2D(latitude: 43.4643, longitude: -80.3832))]

        getAddress(lat: myLocation.latitude, lon: myLocation.longitude)

        var locationArray: [Location] = [Location]()

        locationArray.append(Location(id: UUID(),
                                      lat: myLocation.latitude,
                                      lon: myLocation.longitude,
                                      streetAddress: "Street",
                                      city: "Toronto",
                                      country: "Canada"))

        locationArray.append(self.ticket!.location)

        //  self.displayMarker(locations: locationArray)

        self.showRoute(start: locationArray[0].coordinates, end: locationArray[1].coordinates)

        self.mapView.addAnnotation(annotation)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {

    }
}

extension TicketDetailsViewController
{
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


//                    let address = (placemark.areasOfInterest! + ", " + placemark.locality! + ", " + placemark.administrativeArea! + ", " + placemark.country!)
//                    print("\(address)")
                }
                else
                {
                    print("Error")
                }
            }
        }
    }

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

    func showRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D)
    {
        print("showRoute")

        //        let span = MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)
        //        let region = MKCoordinateRegion(center: start, span: span)
        //        self.mapView.setRegion(region, animated: true)

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

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        print(#function)
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(named: "accent")
        renderer.lineWidth = 5.0
        return renderer
    }

}

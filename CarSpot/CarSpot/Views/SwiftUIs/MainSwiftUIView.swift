//
//  MainSwiftUIView.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import SwiftUI
import MapKit
import Combine

struct MainSwiftUIView: View
{
    @ObservedObject private var locationManager = LocationManager()
    @State private var cancellable: AnyCancellable?
    @State private var region = MKCoordinateRegion()
    @State var tracking: MapUserTrackingMode = .follow
    @State private var currentLocation: [Location] = [Location]()

    private func setCurrentLocation()
    {
        cancellable = locationManager.$location.sink { (location) in

            self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(),
                                             latitudinalMeters: 500, longitudinalMeters: 500)

            if(self.currentLocation.count == 0)
            {
                self.currentLocation.append(Location(coordinate: location?.coordinate ?? CLLocationCoordinate2D()))
            }
        }
    }

    var body: some View
    {
        if (locationManager.location != nil)
        {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: $tracking, annotationItems: currentLocation, annotationContent: { place in
                MapAnnotation(coordinate: place.coordinate) {
                    VStack {
                        Text("Current Location")
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .font(.system(size: 16.0))
                            .foregroundColor(Color("textOnBackground"))
                            .border(Color("cardOutline"), width: 1)
                            .background(Color("cardBackground"))
                            .cornerRadius(5)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)

                        Spacer(minLength: 5)

                        Image("ic_nav_map")
                            .colorMultiply(Color("secondaryLight"))
                            .shadow(color: .black, radius: 2, x: 1, y: 1)

                        Spacer(minLength: 30)
                    }
                }
            })
                .onAppear {
                    setCurrentLocation()
                }
                .ignoresSafeArea()
        }
        else
        {
            Text("Location user location...")
        }
    }
}

struct Location: Identifiable
{
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MainSwiftUIView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MainSwiftUIView()
    }
}

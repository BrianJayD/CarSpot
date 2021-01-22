//
//  TicketDetails.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-21.
//

import SwiftUI
import MapKit
import Combine

struct TicketDetails: View
{
    var parkingTicket: ParkingTicket

    @ObservedObject private var locationManager = LocationManager()
    @State private var cancellable: AnyCancellable?
    @State private var region = MKCoordinateRegion()
    @State var tracking: MapUserTrackingMode = MapUserTrackingMode.none
    @State private var locationList: [Location] = [Location]()

    init(ticket: ParkingTicket)
    {
        self.parkingTicket = ticket
        print("Ticket: \(parkingTicket.location.streetAddress)")
    }

    private func setCurrentLocation()
    {
        cancellable = locationManager.$location.sink { (location) in

            self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(),
                                             latitudinalMeters: 1000, longitudinalMeters: 1000)

            if(self.locationList.count == 0)
            {
                self.locationList.append(
                    Location(lat: Double(location?.coordinate.latitude ?? 0),
                             lon: Double(location?.coordinate.longitude ?? 0),
                             isCurrentLocation: true))

                self.locationList.append(
                    Location(lat: Double(parkingTicket.location.lat),
                             lon: Double(parkingTicket.location.lon),
                             isCurrentLocation: false))
            }
        }
    }

    var body: some View
    {
        ZStack
        {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: $tracking, annotationItems: locationList, annotationContent: { place in
                MapAnnotation(coordinate: place.coordinate) {
                    if (place.isCurrentLocation)
                    {
                        VStack {
                            VStack
                            {
                                Text("Current Location")
                            }
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color("cardOutline"), lineWidth: 1)
                                        .background(Color("cardBackground"))
                                        .shadow(color: Color("shadow"), radius: 3, x: 1, y: 1))

                            Spacer(minLength: 5)

                            Image("ic_nav_map")
                                .colorMultiply(Color("youAreHerePin"))
                                .shadow(color: Color("shadow"), radius: 2, x: 1, y: 1)

                            Spacer(minLength: 30)
                        }
                    }
                    else
                    {
                        Image(systemName: "mappin")
                            .foregroundColor(Color("parkingPin"))
                    }
                }
            })
                .onAppear {
                    setCurrentLocation()
                }
                .ignoresSafeArea()

            VStack
            {

                Spacer()

                VStack(alignment: .leading, spacing: 4)
                {
                    HStack
                    {
                        Text("Date:")
                            .font(.headline)
                            .foregroundColor(Color("secondary"))
                        Text("\(self.parkingTicket.dateString)")
                            .foregroundColor(Color("textOnBackgroundSecondary"))

                        Spacer()

                        Text("Length:")
                            .font(.headline)
                            .foregroundColor(Color("secondary"))
                        Text("\(self.parkingTicket.noOfHours) hour(s)")
                            .foregroundColor(Color("textOnBackgroundSecondary"))
                    }

                    HStack
                    {
                        Text("Building Code:")
                            .font(.headline)
                            .foregroundColor(Color("secondary"))
                        Text("\(self.parkingTicket.buildingCode)")
                            .foregroundColor(Color("textOnBackgroundSecondary"))

                        Spacer()

                        Text("Suit Number:")
                            .font(.headline)
                            .foregroundColor(Color("secondary"))
                        Text("\(self.parkingTicket.hostSuite)")
                            .foregroundColor(Color("textOnBackgroundSecondary"))
                    }

                    HStack
                    {
                        Text("Address:")
                            .font(.headline)
                            .foregroundColor(Color("secondary"))
                        Text("\(self.parkingTicket.location.streetAddress)")
                            .foregroundColor(Color("textOnBackgroundSecondary"))
                    }

                    HStack
                    {
                        Text("\(self.parkingTicket.location.city), \(self.parkingTicket.location.country)")
                            .foregroundColor(Color("textOnBackgroundSecondary"))

                        Spacer()
                    }

                    HStack
                    {
                        Text("License Plate:")
                            .font(.headline)
                            .foregroundColor(Color("secondary"))
                        Text("\(self.parkingTicket.licensePlate)")
                            .font(.headline)
                            .foregroundColor(Color("primary"))
                    }
                }
                    .padding(7)
                    .background(Color("cardBackground"))
                    .cornerRadius(10)
                    .shadow(color: Color("shadow"), radius: 4, x: 1, y: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color("cardOutline"))
                            .shadow(color: Color("shadow"), radius: 4, x: 1, y: 1))
                    .padding(10)
            }
                .padding(.top, 10)
                .padding(.bottom, 30)
                .background(Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("transparent"), Color("mainBackground")]),
                                               startPoint: UnitPoint(x: 0.5, y: 0.25),
                                               endPoint: UnitPoint(x: 0.5, y: 0.75))))
                .ignoresSafeArea()
        }
    }

}

struct TicketDetails_Previews: PreviewProvider
{
    static var previews: some View
    {
        let parkingTicket: ParkingTicket =
            ParkingTicket(email: "user@emailaddress.com",
                          buildingCode: "12345",
                          noOfHours: 12,
                          licensePlate: "12AD78",
                          hostSuite: "1305",
                          location:
                              Location(lat: 43.6532,
                                       lon: -79.3832,
                                       streetAddress: "123 Carlton Street",
                                       city: "Toronto",
                                       country: "Canada")
            )

        TicketDetails(ticket: parkingTicket)

    }
}

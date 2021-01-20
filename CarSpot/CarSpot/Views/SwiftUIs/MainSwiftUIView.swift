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
    @State var tracking: MapUserTrackingMode = MapUserTrackingMode.none
    @State private var currentLocation: [Location] = [Location]()

    @State var buildingCode: String = ""
    @State var suitNumber: String = ""
    @State var streetAddress: String = ""
    @State var noOfHoursSelection = 0
    let noOfHoursList: [String] = ["1 Hr", "4 Hrs", "12 Hrs", "24 Hrs"]
    @State var licensePlateSelection = 0
    let licensePlateList: [String] = ["V7T00M", "V6C9VM", "Al86HO"]

    init()
    {
        UITableView.appearance().backgroundColor = .clear
    }

    private func setCurrentLocation()
    {
        cancellable = locationManager.$location.sink { (location) in

            self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(),
                                             latitudinalMeters: 1000, longitudinalMeters: 1000)

            if(self.currentLocation.count == 0)
            {
                self.currentLocation.append(
                    Location(lat: Double(location?.coordinate.latitude ?? 0) + 0.002,
                             lon: Double(location?.coordinate.longitude ?? 0) + 0.002,
                             isCurrentLocation: false))

                self.currentLocation.append(
                    Location(lat: Double(location?.coordinate.latitude ?? 0),
                             lon: Double(location?.coordinate.longitude ?? 0),
                             isCurrentLocation: true))
            }
        }
    }

    var body: some View
    {
        ZStack
        {
            if (locationManager.location != nil)
            {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: $tracking, annotationItems: currentLocation, annotationContent: { place in
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
                                    .colorMultiply(Color("secondary"))
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
            }
            else
            {
                VStack
                {
                    Text("Locating your location...")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 20.0))
                    Image(systemName: "timer")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 30.0))
                }
            }

            VStack
            {
                Spacer()

                VStack
                {
                    Form
                    {
                        Section//(header: Text("Ticket Details"))
                        {
                            HStack
                            {
                                TextField("Building Code", text: $buildingCode)
                                    .keyboardType(.default)

                                TextField("Suit Number", text: $suitNumber)
                                    .keyboardType(.default)
                            }

                            TextField("Street Address", text: $streetAddress)
                                .keyboardType(.default)

                            VStack
                            {
                                Text("How long would you like to park?")
                                    .foregroundColor(Color("textOnBackgroundSecondary"))
                                    .font(.system(size: 16.0))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, -5)
                                    .padding(.bottom, -5)

                                Picker("noOfHours", selection: $noOfHoursSelection)
                                {
                                    ForEach(0 ..< self.noOfHoursList.count)
                                    {
                                        Text("\(self.noOfHoursList[$0])")
                                    }
                                } .pickerStyle(SegmentedPickerStyle())
                            }

                            VStack
                            {
                                Text("License Plate Number")
                                    .foregroundColor(Color("textOnBackgroundSecondary"))
                                    .font(.system(size: 16.0))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, -5)
                                    .padding(.bottom, -5)

                                HStack
                                {
                                    Picker("licensePlate", selection: $licensePlateSelection)
                                    {
                                        ForEach(0 ..< self.licensePlateList.count)
                                        {
                                            Text("\(self.licensePlateList[$0])")
                                        }
                                    }
                                        .pickerStyle(SegmentedPickerStyle())

                                    Button(action:
                                            {
                                            //behavior

                                    })
                                    {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(Color("textOnBackgroundSecondary"))
                                    }
                                }
                            }

                            Button(action:
                                    {
                                    //behavior

                            })
                            {
                                HStack
                                {
                                    Spacer()
                                    Text("Purchase Parking Ticket")
                                        .foregroundColor(Color("secondaryLight"))
                                    Spacer()
                                }
                            }
                                .padding(.top, 7)
                                .padding(.bottom, 7)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("primaryLight"), lineWidth: 1))
                                .padding(.top, 7)
                                .padding(.bottom, 7)
                        }
                    }
                        .background(Color("transparent"))
                        .padding(.top, -18)
                        .frame(height: 285)
                }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("transparent"), Color("mainBackground")]),
                                                   startPoint: UnitPoint(x: 0.5, y: 0.25),
                                                   endPoint: UnitPoint(x: 0.5, y: 0.75))))
                    .shadow(color: Color("shadow"), radius: 4, x: 0.5, y: 0.5)
            }
        }

    }
}

struct MainSwiftUIView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MainSwiftUIView()
    }
}

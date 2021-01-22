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
    @State private var locationList: [Location] = [Location]()

    @State var buildingCode: String = ""
    @State var suitNumber: String = ""
    @State var streetAddress: String = ""
    @State var noOfHoursSelection = 0
    let noOfHoursList: [String] = [ParkingHours.one.rawValue, ParkingHours.four.rawValue, ParkingHours.twelve.rawValue, ParkingHours.twentyfour.rawValue]
    @State var licensePlateSelection = 0
    let licensePlateList: [String] = ["V7T00M", "V6C9VM", "Al86HO"]
    var licensePlate: String
    {
        return self.licensePlateList[self.licensePlateSelection]
    }
    @State var alertAddLicensePlate: Bool = false
    @State var addLicensePlate: String = ""

    init()
    {
        UITableView.appearance().backgroundColor = .clear
    }

    private func setCurrentLocation()
    {
        cancellable = locationManager.$location.sink { (location) in

            self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(),
                                             latitudinalMeters: 1000, longitudinalMeters: 1000)

            if(self.locationList.count == 0)
            {
                self.locationList.append(
                    Location(lat: Double(location?.coordinate.latitude ?? 0) + 0.002,
                             lon: Double(location?.coordinate.longitude ?? 0) + 0.002,
                             isCurrentLocation: false))

                self.locationList.append(
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
                                    Picker(self.licensePlate, selection: self.$licensePlateSelection)
                                    {
                                        ForEach(0 ..< self.licensePlateList.count)
                                        {
                                            Text("\(self.licensePlateList[$0])")
                                        }
                                    }
                                        .pickerStyle(MenuPickerStyle())

                                    Spacer()

                                    // add license plate
//                                    Button(action:
//                                            {
//                                            let alert = UIAlertController(title: "Add License Plate", message: "Enter the license plate you would like to add.", preferredStyle: .alert)
//                                            alert.addTextField ()
//
//                                            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
//
//                                                if(alert!.textFields![0].checkLicensePlate(min: 2, max: 8))
//                                                {
//                                                    addLicensePlate = alert!.textFields![0].text!
//                                                    self.licensePlateList.append(addLicensePlate)
//                                                    print("License Plates: \(licensePlateList.count)")
//                                                }
//                                                else
//                                                {
//                                                    print("Invalid")
//                                                    alert!.actions[1].isEnabled = false
//                                                }
//
//
//
//                                            }))
//
//                                            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
//                                    })
//                                    {
//                                        Image(systemName: "plus.circle.fill")
//                                            .foregroundColor(Color("textOnBackgroundSecondary"))
//                                    }
                                }
                            }

                            Button(action:
                                    {
                                    let ticket: ParkingTicket = ParkingTicket(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue) ?? "",
                                                                              buildingCode: self.buildingCode,
                                                                              noOfHours: ParkingHours.getIntValue(selection: self.noOfHoursSelection),
                                                                              licensePlate: self.licensePlate,
                                                                              hostSuite: self.suitNumber,
                                                                              location: Location())

                                    // add ticket to user

                                    // save ticket to firestore

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

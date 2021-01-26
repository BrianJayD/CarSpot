//
//  Advanced iOS - MADS4005
//  CarSpot
//
//  Group 7
//  Brian Domingo - 101330689
//  Daryl Dyck - 101338429
//

import SwiftUI
import MapKit
import Combine

struct MainSwiftUIView: View
{
    let profileController = ProfileController()
    let ticketController = TicketController()

    var currentUser: User?
    let geoCoder = CLGeocoder()
    @State var currentLocation = Location()
    @State var newLocation: Location = Location()
    @State var newLocationAdded = false
    @State var currentLocationAdded = false

    @ObservedObject private var locationManager = LocationManager()
    @State private var cancellable: AnyCancellable?
    @State private var region = MKCoordinateRegion()
    @State var tracking: MapUserTrackingMode = MapUserTrackingMode.none
    @State private var locationList: [Location] = [Location]()

    @State var buildingCode: String = ""
    @State var suitNumber: String = ""
    @State var streetAddress: String = ""
    @State private var addressChanged = false
    @State var noOfHoursSelection = 0
    let noOfHoursList: [String] = [ParkingHours.one.rawValue, ParkingHours.four.rawValue, ParkingHours.twelve.rawValue, ParkingHours.twentyfour.rawValue]
    @State var licensePlateSelection = 0
    let licensePlateList: [String]
    var licensePlate: String
    {
        if(licensePlateList.count >= self.licensePlateSelection + 1)
        {
            return self.licensePlateList[self.licensePlateSelection]
        }
        else
        {
            return ""
        }
    }
    @State var alertAddLicensePlate: Bool = false
    @State var addLicensePlate: String = ""
    @State var displayTicketAlert = false
    @State var ticketAlertTitle: String = ""
    @State var ticketAlertMessage: String = ""

    // check if button is disabled
    var buttonOutlineColor: Color
    {
        return self.addressChanged ? Color("textOnBackgroundSecondary") : Color("buttonOutline")
    }

    init()
    {
        currentUser = profileController.getUser(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)!)
        licensePlateList = profileController.getUser(email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue)!).licensePlates

        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().isScrollEnabled = false
    }

    // get current location
    private func setCurrentLocation()
    {
        cancellable = locationManager.$location.sink { (location) in

            // only add locations on the map on initial load
            if(!self.currentLocationAdded)
            {
                // get address info for current location
                getNewLocation(lat: Double(location!.coordinate.latitude), lon: Double(location!.coordinate.longitude))

                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

                let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude - 0.02, longitude: location!.coordinate.longitude)

                self.region = MKCoordinateRegion(center: center, span: span)

                // add locations to pin on map (initial)
                if (self.locationList.count == 0)
                {
                    for location in currentUser!.parkingTickets
                    {
                        self.locationList.append(location.location)
                    }
                }
            }
        }
    }

    var body: some View
    {
        ZStack
        {
            if (locationManager.location != nil)
            {
                VStack
                {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: $tracking, annotationItems: locationList, annotationContent: { place in
                        MapAnnotation(coordinate: place.coordinates) {
                            if (place.isCurrentLocation)
                            {
                                // mark pin for current location
                                VStack {
                                    VStack
                                    {
                                        Text(place.streetAddress)
                                            .scaledToFill()
                                            .minimumScaleFactor(0.5)
                                            .lineLimit(1)
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
                                // mark pins for all previous tickets
                                Image(systemName: "car.circle")
                                    .foregroundColor(Color("parkingPin"))
                            }
                        }
                    })
                        .onAppear {
                            setCurrentLocation()
                    }
                }
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
                        Section
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
                                .onChange(of: streetAddress, perform: { value in
                                    // chack if streetAddress
                                    if (self.streetAddress.lowercased() != self.currentLocation.streetAddress.lowercased())
                                    {
                                        DispatchQueue.main.async { self.addressChanged = true }
                                    }
                                })

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
                                }
                            }
                        }
                    }
                        .background(Color("transparent"))
                        .padding(.top, -18)
                        .frame(height: 220)

                    HStack
                    {
                        Spacer(minLength: 20)

                        // get new location
                        Button(action:
                                {
                                self.getLocation(address: "\(self.currentLocation.country), \(self.currentLocation.city), \(self.streetAddress)")
                        })
                        {
                            HStack
                            {
                                Spacer()
                                Text("Update Map")
                                    .foregroundColor(Color("buttonText"))
                                Spacer()
                            }
                        }
                            .padding(.top, 7)
                            .padding(.bottom, 7)
                            .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("buttonOutline"), lineWidth: 1))
                            .padding(.top, 7)
                            .padding(.bottom, 7)

                        Spacer()

                        // purchase ticket
                        Button(action:
                                {
                                let id = UUID()
                                let location = Location(id: id,
                                                        lat: self.locationList.last!.lat,
                                                        lon: self.locationList.last!.lon,
                                                        streetAddress: self.streetAddress,
                                                        city: self.currentLocation.city,
                                                        country: self.currentLocation.country)

                                let ticket: ParkingTicket =
                                    ParkingTicket(id: id,
                                                  email: UserDefaults.standard.string(forKey: Login.CURRENT_USER.rawValue) ?? "",
                                                  buildingCode: self.buildingCode,
                                                  noOfHours: ParkingHours.getIntValue(selection: self.noOfHoursSelection),
                                                  licensePlate: self.licensePlate,
                                                  hostSuite: self.suitNumber,
                                                  location: location,
                                                  date: Date())

                                // verify all fields
                                if (!buildingCode.checkBuildingCode())
                                {
                                    self.ticketAlertTitle = "Error!"
                                    self.ticketAlertMessage = "Please verify you have the correct building code."
                                    self.displayTicketAlert = true
                                }
                                else if (!suitNumber.checkSuiteNumber())
                                {
                                    self.ticketAlertTitle = "Error!"
                                    self.ticketAlertMessage = "Please verify you have the correct suite number."
                                    self.displayTicketAlert = true
                                }
                                else if (!streetAddress.checkStreetAddress())
                                {
                                    self.ticketAlertTitle = "Error!"
                                    self.ticketAlertMessage = "Please enter a valid street address."
                                    self.displayTicketAlert = true
                                }
                                else
                                {
                                    // save Ticket to coreData
                                    if(ticketController.insertTicket(ticket: ticket) == InsertStatus.success)
                                    {
                                        self.ticketAlertTitle = "Success!"
                                        self.ticketAlertMessage = "You have successfully purchased a parking ticket."
                                        self.displayTicketAlert = true
                                    }
                                    else
                                    {
                                        self.ticketAlertTitle = "Error!"
                                        self.ticketAlertMessage = "There was an error purchasing this parking ticket."
                                        self.displayTicketAlert = true
                                    }
                                }
                        })
                        {
                            HStack
                            {
                                Spacer()
                                Text("Purchase Ticket")
                                    .foregroundColor(Color("buttonText"))
                                Spacer()
                            }
                        }
                            .disabled(addressChanged)
                            .padding(.top, 7)
                            .padding(.bottom, 7)
                            .background(RoundedRectangle(cornerRadius: 5)
                                .stroke(self.buttonOutlineColor, lineWidth: 1))
                            .padding(.top, 7)
                            .padding(.bottom, 7)

                        Spacer(minLength: 20)
                    }
                        .alert(isPresented: self.$displayTicketAlert)
                    {
                        Alert(title: Text(self.ticketAlertTitle),
                              message: Text(self.ticketAlertMessage),
                              dismissButton: .default(Text("OK")))
                    }

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

extension MainSwiftUIView
{
    // get location from lat and lon
    func getNewLocation(lat: Double, lon: Double)
    {
        self.currentLocation.isCurrentLocation = true
        self.currentLocation.lat = lat
        self.currentLocation.lon = lon

        let location: CLLocation = CLLocation(latitude: lat, longitude: lon)

        self.geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            self.setCurrentLocation(placemarks: placemark, error: error)
        }
    }

    // get address from location
    func setCurrentLocation(placemarks: [CLPlacemark]?, error: Error?)
    {
        if (error != nil)
        {
            print("error")
        }
        else
        {
            if let placemarks = placemarks, let placemark = placemarks.first
            {
                var addressString: String = ""

                if placemark.subThoroughfare != nil
                {
                    self.streetAddress = placemark.subThoroughfare! + " "
                }
                if placemark.thoroughfare != nil
                {
                    self.streetAddress = self.streetAddress + placemark.thoroughfare!
                    self.currentLocation.streetAddress = self.streetAddress
                }
                if placemark.locality != nil
                {
                    addressString = addressString + placemark.locality! + ", "
                    self.currentLocation.city = placemark.locality!
                }
                if placemark.country != nil
                {
                    addressString = addressString + placemark.country!
                    self.currentLocation.country = placemark.country!
                }

//                print("Current Location: \(currentLocation.streetAddress)")

                // add current location
                self.locationList.append(currentLocation)
                self.currentLocationAdded = true
//                print("Address: \(addressString)")

            }
            else
            {
                print("error")
            }
        }
    }

    // get location from street Address
    func getLocation(address: String)
    {
        self.geoCoder.geocodeAddressString(address) { (placemark, error) in
            self.processGeoResponse(withPlacemarks: placemark, error: error)
        }
    }

    // process response from street address request
    func processGeoResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?)
    {
        if (error != nil)
        {
            let alert = UIAlertController(title: "Location Error", message: "There was an error getting this location.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "CLOSE", style: .cancel, handler: nil))

            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            print(#function, "Error getting location")
        }
        else
        {
            var myLocation: CLLocation?

            if let placemark = placemarks, placemarks!.count > 0
            {
                myLocation = placemark.first?.location
            }

            if let myLocation = myLocation
            {
                self.locationList.removeLast()

                // set new location on map
                var newLocation = Location(id: UUID(),
                                           lat: myLocation.coordinate.latitude,
                                           lon: myLocation.coordinate.longitude,
                                           streetAddress: self.streetAddress,
                                           city: self.currentLocation.city,
                                           country: self.currentLocation.country)

                newLocation.isCurrentLocation = true

                self.locationList.append(newLocation)

                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

                let center = CLLocationCoordinate2D(latitude: newLocation.coordinates.latitude - 0.02,
                                                    longitude: newLocation.coordinates.longitude)

                self.region = MKCoordinateRegion(center: center, span: span)
                DispatchQueue.main.async { self.addressChanged = false }
            }
            else
            {
                print(#function, "Error getting location")
            }
        }
    }
}

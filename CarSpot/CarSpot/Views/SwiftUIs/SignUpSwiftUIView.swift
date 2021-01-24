//
//  SignUpSwiftUIView.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-21.
//

import SwiftUI

struct SignUpSwiftUIView: View {
    @State private var tfEmail: String = ""
    @State private var tfPassword: String = ""
    @State private var tfPhone: String = ""
    @State private var tfFirstName: String = ""
    @State private var tfLastName: String = ""
    @State private var tfConfirmation: String = ""
    @State private var tfNewPlate: String = ""

    let profileController = ProfileController()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        var ownedLicensePlates: [PlateNumber] = []

        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Account Information")) {

                        VStack {
                            Text("Enter Name:")
                            HStack {
                                TextField("First Name", text: $tfFirstName)
                                TextField("Last Name", text: $tfLastName)
                            }
                        }

                        VStack {
                            Text("Enter your phone number:")
                            TextField("Phone Number", text: $tfPhone)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("Enter your e-mail:")
                            TextField("E-mail address", text: $tfEmail)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("Choose new password:")
                            TextField("New Password", text: $tfPassword)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            Text("Confirm new password:")
                            TextField("Confirm Password", text: $tfConfirmation)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Section(header: Text("License Plates")) {
                        Text("Enter license plate:")
                        HStack {
                            
                            
                            TextField("License Plate", text: $tfNewPlate)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                guard tfNewPlate != nil else {
                                    print(#function, "Invalid plates, please try again.")
                                    return
                                }
                                
                                //TODO
                                let plateNumber = PlateNumber(plateNumber: tfNewPlate)
                                ownedLicensePlates.append(plateNumber)
                                
                                tfNewPlate = ""
                                print("NEW PLATE \(plateNumber.plateNumber)")
                                print("All plates \(ownedLicensePlates)")
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color("textOnBackgroundSecondary"))
                            }).padding()
                        }
                    }
                    
                }
                //TODO: Error msg display
                Text("")
                
                //TODO: FIX LISTS
//                List {
//                    ForEach(ownedLicensePlates) { plate in
//
//                        LicensePlateSwiftUIView(plateNumber: plate.plateNumber)
//                            .listRowBackground(Color.blue)
//                            .listRowInsets(EdgeInsets())
//                    }
//                }
                
                

                Button(action: {
                    print("\(tfEmail), \(tfPassword)")
                    
                    var addedPlates:[String] = []
                    
                    for plateNumber in ownedLicensePlates {
                        addedPlates.append(plateNumber.plateNumber)
                    }
                    
                    let status = profileController.insertAccount(email: tfEmail, password: tfPassword, firstName: tfFirstName, lastName: tfLastName, phoneNumber: Int(tfPhone)!, licensePlates: addedPlates)
                    
                    print(status)
                    self.presentationMode.wrappedValue.dismiss()

                }, label: {
                    Text("Create Account")
                }).padding()

            }.navigationBarTitle("New Account")
        }
    }
}

struct SignUpSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSwiftUIView()
    }
}

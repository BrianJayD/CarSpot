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
    
    @State var plateNumbers:[PlateNumber] = []
    
    //Error messages
    @State var errorCode:Int = 0
    @State var showAlert = false
    
    let errorTitles:[String] = [
        "Invalid first name/last name",
        "Invalid phone number",
        "Invalid e-mail",
        "Invalid password",
        "Passwords do not match"
    ]
    
    let errorMessages:[String] = [
        "First name/last name can not be empty.",
        "Phone number must be 10 digits long.",
        "Check e-mail format.",
        "Password must be atleast 8 characters long.",
        "Ensure both password fields match."
    ]

    let profileController = ProfileController()

    @Environment(\.presentationMode) var presentationMode
    
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach { plateNumbers.remove(at: $0) }
    }
    
    private func validateEmail(email:String) -> Bool {
        let regex = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: email)
    }

    var body: some View {
        var ownedLicensePlates:[PlateNumber] = []
        
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
                            guard tfNewPlate != "" else {
                                print(#function, "Invalid plates, please try again.")
                                return
                            }
                        
                            let plateNumber = PlateNumber(plateNumber: tfNewPlate.uppercased())
                            ownedLicensePlates.append(plateNumber)
                            plateNumbers.append(PlateNumber(plateNumber: plateNumber.plateNumber))
                            
                            tfNewPlate = ""
                            print("NEW PLATE \(plateNumber.plateNumber)")
                            print("All plates \(ownedLicensePlates)")
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("textOnBackgroundSecondary"))
                        })
                        .padding()
                    }
                }
                
                //LicensePlateList(plateNumbers: [PlateNumber(plateNumber: "SICKVET", email: "vet@vet.com")])
                    
                HStack{
                    Spacer()
                    Text("Your License Plates")
                        .font(.headline)
                    Spacer()
                }
                
                
                List {
                    ForEach(plateNumbers) { plateNumber in
                        HStack {
                            Spacer()
                            LicensePlateRow(plateNumber: plateNumber.plateNumber)
                            Spacer()
                        }
                    }.onDelete(perform: delete)
                }
            }
            
            
            Button(action: {
                print("\(tfEmail), \(tfPassword)")
                
                var addedPlates:[String] = []
                
                for plateNumber in plateNumbers {
                    addedPlates.append(plateNumber.plateNumber)
                }
                
                if(tfFirstName == "" || tfLastName == "") {
                    self.errorCode = 0
                    self.showAlert = true
                    return
                } else if(tfPhone == "" || tfPhone.count < 10 || tfPhone.count > 10) {
                    self.errorCode = 1
                    self.showAlert = true
                    return
                } else if(!validateEmail(email: tfEmail) || tfEmail == "") {
                    self.errorCode = 2
                    self.showAlert = true
                    return
                } else if(tfPassword.count < 8) {
                    self.errorCode = 3
                    self.showAlert = true
                    return
                } else if(tfConfirmation != tfPassword) {
                    self.errorCode = 4
                    self.showAlert = true
                    return
                }
                
                let status = profileController.insertAccount(email: tfEmail.lowercased(), password: tfPassword, firstName: tfFirstName, lastName: tfLastName, phoneNumber: Int(tfPhone)!, licensePlates: addedPlates)
                
                print(status)
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Create Account")
            })
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text(self.errorTitles[self.errorCode]), message: Text(self.errorMessages[self.errorCode]), dismissButton: .default(Text("Dismiss")))
            }
            
        }
    }
}

struct SignUpSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSwiftUIView()
    }
}

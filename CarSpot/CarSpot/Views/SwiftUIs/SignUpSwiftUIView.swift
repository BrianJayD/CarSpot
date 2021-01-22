//
//  SignUpSwiftUIView.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-21.
//

import SwiftUI

struct SignUpSwiftUIView: View {
    @State private var tfEmail:String = ""
    @State private var tfPassword:String = ""
    @State private var tfPhone:String = ""
    @State private var tfFirstName:String = ""
    @State private var tfLastName:String = ""
    @State private var tfConfirmation:String = ""
    @State private var tfPlates:String = ""
    
    let profileController = ProfileController()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Account Information")) {
                        
                        VStack {
                            Text("Enter Name:")
                            HStack{
                                TextField("First Name", text: $tfFirstName)
                                TextField("Last Name", text: $tfLastName)
                            }
                        }
    
                        VStack{
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
                        TextField("License Plate", text: $tfPlates)
                            .multilineTextAlignment(.center)
                    }
                }
                //TODO: Error msg display
                Text("")
                
//                Button(action: {
//                    print("Adding new License Plate")
//                }, label: {
//                    Text("Add another license plate")
//                    Image(systemName: "plus.circle.fill")
//                        .foregroundColor(Color("textOnBackgroundSecondary"))
//                }).padding()
                
                Button(action: {
                    print("\(tfEmail), \(tfPassword)")
                    let status = profileController.insertAccount(email: tfEmail, password: tfPassword, firstName: tfFirstName, lastName: tfLastName, phoneNumber: Int(tfPhone)!)
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

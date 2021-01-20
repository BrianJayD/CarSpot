//
//  LoginSwiftUIView.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import SwiftUI

struct LoginSwiftUIView: View {
    @State private var username:String = ""
    @State private var password:String = ""
    
    var body: some View {
        Image(systemName: "car.fill")
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
    
        Form {
            TextField("Username", text: $username)
            TextField("Password", text: $password)
        }.padding()
        
        HStack {
            Button(action: {print("createAccount()")}, label: {
                Text("Create New Account")
            })
            .background(Color.blue)
            .padding()
            .background(Color.green)
            .foregroundColor(Color.red)
            
            Button(action: {print("signIn()")}, label: {
                Text("Sign In")
            }).padding()
        }
        
    }
}

struct LoginSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSwiftUIView()
    }
}

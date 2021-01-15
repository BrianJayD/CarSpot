//
//  HostUIView.swift
//  ParkingApp
//
//  Created by Brian Domingo on 2021-01-15.
//

import SwiftUI

struct HostUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .foregroundColor(.red)
            .frame(width: 200, height: 200, alignment: .center)
            .background(Color.blue)
    }
}

struct HostUIView_Previews: PreviewProvider {
    static var previews: some View {
        HostUIView()
    }
}

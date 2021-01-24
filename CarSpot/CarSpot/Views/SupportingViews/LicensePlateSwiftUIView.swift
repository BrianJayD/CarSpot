//
//  LicensePlateSwiftUIView.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-24.
//

import SwiftUI

struct LicensePlateSwiftUIView: View {
    var plateNumber:String
    
    init(plateNumber:String) {
        self.plateNumber = plateNumber
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct LicensePlateSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LicensePlateSwiftUIView(plateNumber: "1GS9K1L")
    }
}

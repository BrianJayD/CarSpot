//
//  LicensePlateRow.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-25.
//

import SwiftUI

struct LicensePlateRow: View {
    var plateNumber:String

    var body: some View
    {
        VStack
        {
            Text("License Plate:")
                .font(.headline)
                .foregroundColor(Color("secondary"))
            
            
            Text("\(self.plateNumber)")
                .font(.largeTitle)
                .foregroundColor(Color("primary"))

        }
            .padding(7)
            .background(Color("cardBackground"))
            .cornerRadius(10)
            .shadow(color: Color("shadow"), radius: 4, x: 1, y: 1)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color("cardOutline"))
                    .shadow(color: Color("shadow"), radius: 4, x: 1, y: 1))
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }


}

struct LicensePlateRow_Previews: PreviewProvider {
    static var previews: some View {
        LicensePlateRow(plateNumber: "BBBCCC")
    }
}


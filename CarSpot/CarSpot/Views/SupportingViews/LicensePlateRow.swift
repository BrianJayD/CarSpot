//
// Advanced iOS - MADS4005
// CarSpot
//
// Group 7
// Brian Domingo - 101330689
// Daryl Dyck - 101338429
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
            .frame(minWidth: 200, maxWidth: 200)
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
        LicensePlateRow(plateNumber: "MADS4001")
    }
}


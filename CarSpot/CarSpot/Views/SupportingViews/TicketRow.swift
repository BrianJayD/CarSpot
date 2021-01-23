//
//  TicketItemSwiftUIView.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import SwiftUI

struct TicketRow: View
{
    var parkingTicket: ParkingTicket

    var body: some View
    {
        VStack(alignment: .leading, spacing: 4)
        {
            HStack
            {
                Text("Date:")
                    .font(.headline)
                    .foregroundColor(Color("secondary"))
                Text("\(self.parkingTicket.dateString)")
                    .foregroundColor(Color("textOnBackgroundSecondary"))

                Spacer()

                Text("Length:")
                    .font(.headline)
                    .foregroundColor(Color("secondary"))
                Text("\(self.parkingTicket.noOfHours) hour(s)")
                    .foregroundColor(Color("textOnBackgroundSecondary"))
            }

            HStack
            {
                Text("Address:")
                    .font(.headline)
                    .foregroundColor(Color("secondary"))
                Text("\(self.parkingTicket.location.streetAddress)")
                    .foregroundColor(Color("textOnBackgroundSecondary"))
            }

            HStack
            {
                Text("License Plate:")
                    .font(.headline)
                    .foregroundColor(Color("secondary"))
                Text("\(self.parkingTicket.licensePlate)")
                    .font(.headline)
                    .foregroundColor(Color("primary"))
            }
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

struct TicketItemSwiftUIView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let parkingTicket: ParkingTicket =
            ParkingTicket(id: UUID(),
                          email: "user@emailaddress.com",
                          buildingCode: "12345",
                          noOfHours: 12,
                          licensePlate: "12AD78",
                          hostSuite: "1305",
                          location:
                              Location(id: UUID(),
                                       lat: 43.6532,
                                       lon: -79.3832,
                                       streetAddress: "123 Carlton Street",
                                       city: "Toronto",
                                       country: "Canada"),
                          date: Date())

        TicketRow(parkingTicket: parkingTicket)
    }
}

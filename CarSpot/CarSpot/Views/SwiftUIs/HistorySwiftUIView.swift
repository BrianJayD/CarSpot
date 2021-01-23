//
//  HistorySwiftUIView.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-18.
//

import SwiftUI

struct HistorySwiftUIView: View
{
    let ticketList: [ParkingTicket]
    @State private var isPresented: Bool = false
    @State var ticketToDisplay: ParkingTicket?

    init(ticketList: [ParkingTicket])
    {
        self.ticketList = ticketList
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View
    {
        VStack
        {
//            Text("Previous Parking Tickets")
//                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                .bold()
//                .foregroundColor(Color("primary"))

            List
            {
                ForEach(ticketList) { ticket in

                    TicketRow(parkingTicket: ticket)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .onTapGesture {
                            self.ticketToDisplay = ticket
                            self.isPresented.toggle()
                        }
                        .sheet(isPresented: self.$isPresented) { TicketDetails(ticket: ticket) }
                }
            }

        }
            .onAppear()
        {
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().separatorColor = .clear

        }


            .background(Color("mainBackground"))
            .navigationTitle("Previous Parking Tickets")
    }

}

struct HistorySwiftUIView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let ticketList: [ParkingTicket] = [ParkingTicket(id: UUID(),
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
                                                         date: Date()),

                                           ParkingTicket(id: UUID(),
                                                         email: "user2@emailaddress.com",
                                                         buildingCode: "12345",
                                                         noOfHours: 12,
                                                         licensePlate: "12AD78",
                                                         hostSuite: "1305",
                                                         location:
                                                             Location(id: UUID(), lat: 43.653,
                                                                      lon: -79.383,
                                                                      streetAddress: "98 Carlton Street",
                                                                      city: "Toronto",
                                                                      country: "Canada"),
                                                         date: Date())]

        HistorySwiftUIView(ticketList: ticketList)
    }
}

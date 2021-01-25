//
//  PlateListSwiftUIView.swift
//  CarSpot
//
//  Created by Brian Domingo on 2021-01-24.
//

import SwiftUI
//
//struct PlateListSwiftUIView: View {
//    let plateList: [PlateNumber]
//    @State private var isPresented: Bool = false
//
//    init(plateList:[PlateNumber]) {
//        self.plateList = plateList
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().backgroundColor = .clear
//        UITableView.appearance().backgroundColor = .clear
//    }
//
//    var body: some View {
//        VStack {
//            List
//            {
//                ForEach(plateList) { licensePlate in
//
//                    LicensePlateSwiftUIView(plateNumber: licensePlate.plateNumber)
//                        .listRowBackground(Color.clear)
//                        .listRowInsets(EdgeInsets())
////                        .onTapGesture {}
//                }
//            }
//
//        }
//            .onAppear()
//        {
//            UITableView.appearance().backgroundColor = .clear
//            UITableViewCell.appearance().backgroundColor = .clear
//            UITableView.appearance().separatorStyle = .none
//            UITableView.appearance().separatorColor = .clear
//        }
//            .background(Color("mainBackground"))
//    }
//
//}
//
//struct PlateListSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        let plateNumber = [PlateNumber(plateNumber: "BRIAN170", email: "B@B.com")]
//
//        PlateListSwiftUIView(plateList: plateNumber)
//    }
//}

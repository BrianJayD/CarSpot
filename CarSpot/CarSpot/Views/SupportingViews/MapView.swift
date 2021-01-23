//
//  MapView.swift
//  CarSpot
//
//  Created by Daryl Dyck on 2021-01-21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable
{
    var location: Location

    func makeUIView(context: Context) -> some MKMapView
    {
        MKMapView()

    }

    func updateUIView(_ uiView: UIViewType, context: Context)
    {
        //   let coordinates
    }



}

struct MapView_Previews: PreviewProvider
{
    static var previews: some View {
        MapView(location: Location(id: UUID(),
                                   lat: 43.6532,
                                   lon: -79.3832,
                                   streetAddress: "123 Carlton Street",
                                   city: "Toronto",
                                   country: "Canada"))
    }
}

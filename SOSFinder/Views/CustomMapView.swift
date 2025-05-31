//
//  CustomMapView.swift
//  SOSFinder
//
//  Created by Iago Xavier de Lima on 30/05/25.
//
import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {
    var mapStyle: MKMapType
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = mapStyle
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.mapType = mapStyle
        uiView.showsUserLocation = true
        uiView.userTrackingMode = .follow
    }
}

#Preview {
    CustomMapView(mapStyle: .hybrid,
                  region: .constant(MKCoordinateRegion(.init(x: 0, y: 0, width: 1000, height: 1000))))
}

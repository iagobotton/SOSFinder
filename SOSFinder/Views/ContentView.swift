//
//  ContentView.swift
//  SOSFinder
//
//  Created by Iago Xavier de Lima on 12/12/24.
//
import SwiftUI
import MapKit

struct ContentView : View {
    @StateObject var locationManager: LocationManager = LocationManager()
    @State private var mapStyle: MKMapType = .standard
    @State private var scaleIcon = false
    
    @State private var activeMapStyle: MKMapType = .standard
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                HStack {
                    Button(action: {
                        locationManager.locationManager.startUpdatingLocation()
                        provideHapticFeedback()
                    }) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.white)
                            .font(.system(size: 38))
                            .scaleEffect(scaleIcon ? 1.2 : 1)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: scaleIcon)
                    }
                    
                    Text(locationManager.address ?? "Loading Address...")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding(.horizontal, 16)
                .background(Color.accentColor)
                
                
                CustomMapView(mapStyle: mapStyle, region: $locationManager.region)
                    .edgesIgnoringSafeArea(.all)
            }
            .shadow(radius: 10)
            
            VStack(alignment: .trailing, spacing: 8) {
                
                Spacer()
                    .frame(height: 150)
                
                MapStyleButton(icon: "map", action: {
                    mapStyle = .standard
                    activeMapStyle = .standard
                    provideHapticFeedback()
                }, isActive: activeMapStyle == .standard)
                MapStyleButton(icon: "globe.europe.africa.fill", action: {
                    mapStyle = .satellite
                    activeMapStyle = .satellite
                    provideHapticFeedback()
                }, isActive: activeMapStyle == .satellite)
                MapStyleButton(icon: "square.3.layers.3d.down.right", action: {
                    mapStyle = .hybrid
                    activeMapStyle = .hybrid
                    provideHapticFeedback()
                }, isActive: activeMapStyle == .hybrid)
                Spacer()
            }
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
            VStack {
                
                Spacer()
                HStack(spacing: 10) {
                    EmergencyButton(type: "Police", number: locationManager.emergencyNumbers["police"])
                    EmergencyButton(type: "Ambulance", number: locationManager.emergencyNumbers["ambulance"])
                    EmergencyButton(type: "Fire", number: locationManager.emergencyNumbers["fire"])
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(.horizontal, 16)
                .background(Color.white)
                
            }.shadow(radius: 5)
            
        }
        .onAppear {
            scaleIcon.toggle()
        }
    }
    func provideHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

#Preview {
    ContentView()
}

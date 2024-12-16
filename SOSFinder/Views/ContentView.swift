//
//  sheetmodal.swift
//  SOSFinder
//
//  Created by Iago Xavier de Lima on 12/12/24.
//
import SwiftUI
import MapKit

struct SheetModalView : View {
    @State private var isSheetExpanded: Bool = false
    @StateObject var locationManager: LocationManager = LocationManager()
    @State private var mapStyle: MKMapType = .standard // Default map style
    @State private var scaleIcon = false // Estado para controlar o efeito de escala
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header com o endereço
                HStack {
                    Button(action: {
                        locationManager.locationManager.startUpdatingLocation()
                    }) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.white)
                            .font(.system(size: 38))
                            .scaleEffect(scaleIcon ? 1.2 : 1) // Efeito de escala
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: scaleIcon) // Animação de escala
                    }
                    
                    Text(locationManager.address ?? "Loading Address...")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding(.horizontal, 16)
                .background(Color.blue)
                
                // Custom MKMapView usando UIViewRepresentable
                CustomMapView(mapStyle: mapStyle, region: $locationManager.region)
                    .edgesIgnoringSafeArea(.all)
            }
            .shadow(radius: 10)
            
            VStack(alignment: .trailing, spacing: 8) {
                
                Spacer()
                    .frame(height: 100) // Espaço abaixo do cabeçalho
                
                MapStyleButton(icon: "map", action: {
                    mapStyle = .standard
                })
                MapStyleButton(icon: "globe.europe.africa.fill", action: {
                    mapStyle = .satellite
                })
                MapStyleButton(icon: "square.3.layers.3d.down.right", action: {
                    mapStyle = .hybrid
                })
                Spacer()
            }
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
            VStack {
                
                Spacer()
                HStack(spacing: 10) {// Espaçamento entre os botões
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
            scaleIcon.toggle() // Inicia o efeito de escala assim que a view aparece
        }
    }
}

struct MapStyleButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .padding(10)
                .background(Color.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

struct EmergencyButton: View {
    var type: String
    var number: String?
    
    var body: some View {
        Button {
            if let emergencyNumber = number, emergencyNumber != "Unavailable" {
                callEmergencyNumber(emergencyNumber)
            }
        } label: {
            VStack {
                Spacer()
                Image(systemName: "phone.down.fill")
                    .font(.system(size: 38))
                    .foregroundColor(.white)
                
                Image(systemName: iconForType(type))
                    .font(.system(size: 50))
                    .foregroundColor(number == "Unavailable" ? .gray : .white)
                
                Text(type)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.top, 8)
            }
            .frame(width: 115, height: 120)  // Tamanho fixo dos botões
            .background(Color.red)
            .cornerRadius(12) // Cantos arredondados
        }
        .disabled(number == "Unavailable")
    }
    
    func callEmergencyNumber(_ number: String) {
        guard let url = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(url)
    }
    
    func iconForType(_ type: String) -> String {
        switch type {
        case "Police": return "light.beacon.max.fill"
        case "Ambulance": return "cross.circle.fill"
        case "Fire": return "flame.circle.fill"
        default: return "questionmark.circle.fill"
        }
    }
}

struct CustomMapView: UIViewRepresentable {
    var mapStyle: MKMapType
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = mapStyle // Set the map style
        mapView.showsUserLocation = true // Show user location
        mapView.userTrackingMode = .follow // Track user location
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.mapType = mapStyle // Update map style on change
        uiView.showsUserLocation = true // Ensure user location is displayed
        uiView.userTrackingMode = .follow // Ensure tracking mode is set to follow
    }
}

#Preview {
    SheetModalView()
}

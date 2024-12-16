//
//  LocationManager.swift
//  SOSFinder
//
//  Created by Iago Xavier de Lima on 09/12/24.
//
import Foundation
import CoreLocation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    var locationManager = CLLocationManager()
    private let emergencyAPIUrl = "https://emergencynumberapi.com/api/country/"
    
    @Published var countryCode: String?
    @Published var address: String?
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var emergencyNumbers: [String: String] = [
        "ambulance": "Unavailable",
        "fire": "Unavailable",
        "police": "Unavailable"
    ]
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchEmergencyNumbers(for countryCode: String) {
        guard let url = URL(string: "\(emergencyAPIUrl)\(countryCode)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching emergency numbers: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let emergencyData = try decoder.decode(EmergencyData.self, from: data)
                DispatchQueue.main.async {
                    self.emergencyNumbers = [
                        "ambulance": emergencyData.data.ambulance.all.first ?? "Unavailable",
                        "fire": emergencyData.data.fire.all.first ?? "Unavailable",
                        "police": emergencyData.data.police.all.first ?? "Unavailable"
                    ]
                }
            } catch {
                print("Error decoding emergency data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.emergencyNumbers = [
                        "ambulance": "Unavailable",
                        "fire": "Unavailable",
                        "police": "Unavailable"
                    ]
                }
            }
        }
        
        task.resume()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude

        // Update the region to focus the map on the user's location
        self.region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        position = MapCameraPosition.region(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    let street = placemark.thoroughfare ?? ""
                    let neighborhood = placemark.subLocality ?? ""
                    let city = placemark.locality ?? ""
                    let state = placemark.administrativeArea ?? ""
                    let country = placemark.country ?? ""
                    
                    self.address = [street, neighborhood, city, state, country]
                        .filter { !$0.isEmpty }
                        .joined(separator: ", ")
                    
                    self.countryCode = placemark.isoCountryCode
                    self.fetchEmergencyNumbers(for: placemark.isoCountryCode ?? "")
                }
            }
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obtaining location: \(error.localizedDescription)")
    }
}

struct EmergencyData: Codable {
    struct Data: Codable {
        struct EmergencyNumbers: Codable {
            var all: [String]
        }
        var ambulance: EmergencyNumbers
        var fire: EmergencyNumbers
        var police: EmergencyNumbers
    }
    var data: Data
}

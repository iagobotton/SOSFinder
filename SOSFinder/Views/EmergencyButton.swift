//
//  EmergencyButton.swift
//  SOSFinder
//
//  Created by Iago Xavier de Lima on 30/05/25.
//
import SwiftUI

struct EmergencyButton: View {
    var type: String
    var number: String?
    
    var body: some View {
        Button {
            if let emergencyNumber = number, emergencyNumber != "Unavailable" {
                callEmergencyNumber(emergencyNumber)
            }
            provideHapticFeedback()
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
            .frame(width: 115, height: 120)
            .background(Color.red)
            .cornerRadius(12)
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
    
    func provideHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}

#Preview {
    EmergencyButton(type: "", number: "")
}

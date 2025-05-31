//
//  MapStyleButton.swift
//  SOSFinder
//
//  Created by Iago Xavier de Lima on 30/05/25.
//

import SwiftUI

struct MapStyleButton: View {
    let icon: String
    let action: () -> Void
    var isActive: Bool
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .padding(10)
                .background(isActive ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        
    }
}

#Preview {
    MapStyleButton(icon: "map", action: { }, isActive: true)
}

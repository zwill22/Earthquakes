//
//  RefreshButton.swift
//  Earthquakes
//
//  Created by Zack Williams on 30/09/2024.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RefreshButton()
}

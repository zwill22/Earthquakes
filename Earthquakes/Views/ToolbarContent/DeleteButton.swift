//
//  DeleteButton.swift
//  Earthquakes
//
//  Created by Zack Williams on 30/09/2024.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Label("Delete", systemImage: "trash")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DeleteButton()
}

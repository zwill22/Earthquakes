//
//  QuakeDetail.swift
//  Earthquakes
//
//  Created by Zack Williams on 05/10/2024.
//

import SwiftUI

struct QuakeDetail: View {
    var quake: Quake
    @EnvironmentObject private var quakesProvider: QuakesProvider
    @State private var location: QuakeLocation? = nil
    @State private var high_precision: Bool = false
    
    var body: some View {
        VStack {
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(Color.secondary)
            if let location = self.location {
                if high_precision {
                    Text("Latitude: \(location.latitude.formatted())")
                    Text("Longitude: \(location.longitude.formatted())")
                } else {
                    Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                    Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
                }
            }
        }.onTapGesture {
            if high_precision {
                high_precision = false
            } else {
                high_precision = true
            }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}

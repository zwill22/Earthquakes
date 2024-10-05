//
//  QuakeDetailMap.swift
//  Earthquakes
//
//  Created by Zack Williams on 05/10/2024.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColour: Color
    private let place: QuakePlace
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    init(location: QuakeLocation, tintColour: Color) {
        self.location = location
        self.tintColour = tintColour
        self.place = QuakePlace(location: location)
    }
    
    var body: some View {
        Map(position: $position) {
            Marker("", systemImage: "arrowshape.down.fill", coordinate: place.location)
                .tint(tintColour)
        }
            .onAppear {
                withAnimation {
                    position = .region(MKCoordinateRegion(center: place.location, span: .init(latitudeDelta: 1, longitudeDelta: 1)))
                }
            }
    }
}

struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: QuakeLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
    }
}

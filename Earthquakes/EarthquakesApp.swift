//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by Zack Williams on 30/09/2024.
//

import SwiftUI

@main
struct EarthquakesApp: App {
    @StateObject var quakesProvider = QuakesProvider()
    
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}

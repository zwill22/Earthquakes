//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Zack Williams on 30/09/2024.
//

import XCTest

@testable import Earthquakes

class EarthquakesTests: XCTestCase {
    
    func testGeoJSONDecoderQuake() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
}

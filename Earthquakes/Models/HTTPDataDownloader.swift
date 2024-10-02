//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by Zack Williams on 02/10/2024.
//

import Foundation

let validStatus = 200..<300

protocol HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(for: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw QuakeError.networkError
        }
        
        return data
    }
}

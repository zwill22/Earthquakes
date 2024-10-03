//
//  QuakeError.swift
//  Earthquakes
//
//  Created by Zack Williams on 30/09/2024.
//

import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing a valid code, magnitude, place, or time.",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Error fetching quake data from the server",
                comment: ""
            )
        case .unexpectedError(let error):
            return NSLocalizedString(
                "Received unexpected error: \(error.localizedDescription)",
                comment: ""
            )
        }
    }
}

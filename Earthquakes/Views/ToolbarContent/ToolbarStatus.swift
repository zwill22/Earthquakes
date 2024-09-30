//
//  ToolbarStatus.swift
//  Earthquakes
//
//  Created by Zack Williams on 30/09/2024.
//

import SwiftUI

struct ToolbarStatus: View {
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var quakesCount: Int
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Checking for Earthquakes...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(quakesCount) Eathquakes")
                    .foregroundStyle(Color.secondary)
            } else {
                let lastUpdateDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdateDate.formatted(.relative(presentation: .named)))")
                Text("\(quakesCount) Eathquakes")
                    .foregroundStyle(Color.secondary)
            }
        }
        .font(.caption)
    }
}

#Preview(traits: .fixedLayout(width: 200, height: 40)) {
    
    ToolbarStatus(
        isLoading: true,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        quakesCount: 125
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantFuture.timeIntervalSince1970,
        quakesCount: 10_000
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.now.timeIntervalSince1970,
        quakesCount: 10000
    )
    
    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        quakesCount: 10000
    )
}

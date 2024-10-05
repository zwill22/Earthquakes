//
//  Quakes.swift
//  Earthquakes
//
//  Created by Zack Williams on 30/09/2024.
//

import SwiftUI

struct Quakes: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: QuakesProvider
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading: Bool = false
    @State var selection: Set<String> = []
    @State private var error: QuakeError?
    @State private var hasError = false
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.quakes) { quake in
                    NavigationLink(destination: QuakeDetail(quake: quake)) {
                        QuakeRow(quake: quake)
                    }
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
            .refreshable {
                await fetchQuakes()
            }
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchQuakes()
        }
    }

    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }
    
    func deleteQuakes(at offsets: IndexSet) {
        provider.deleteQuakes(atOffsets: offsets)
    }
    
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    
    func fetchQuakes() async {
        isLoading = true
        do {
            try await provider.fetchQuakes()
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Quakes()
        .environmentObject(
            QuakesProvider(client: QuakeClient(downloader: TestDownloader()))
        )
}

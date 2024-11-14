//
//  RecentCallsViewModel.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import Foundation
// No need to dispatch to the main thread because @MainActor ensures it runs on the main thread
@MainActor
class RecentCallsViewModel: ObservableObject {
    @Published var calls: [Call] = []

    // Load CAlls data asynchronously using async/await
    func loadCalls() async {
        do {
            if let url = Bundle.main.url(forResource: "calls", withExtension: "json") {
                let data = try Data(contentsOf: url)
                // Configure JSONDecoder to decode dates in ISO8601 format
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode(CallsResponse.self, from: data)
                calls = decodedResponse.call
            } else {
                print("no file found")
            }
        } catch {
            print("Loading JSON ERROR: \(error)")
        }
    }

    // Clear calls
    func clearCalls() {
        self.calls.removeAll()
    }
}

//
//  TranscriptionsViewModel.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import Foundation

@MainActor
class TranscriptionsViewModel: ObservableObject {
    @Published var transcriptions: [Transcription] = []
    @Published var isLoading = false
    var callerNumber = ""
    var callTime = ""
    private let callUuid: UUID

    init(callUuid: UUID) {
        self.callUuid = callUuid
    }

    func loadTranscriptions() async {
        isLoading = true

        do {
            guard let url = Bundle.main.url(forResource: "transcriptions", withExtension: "json") else {
                print("no file")
                isLoading = false
                return
            }

            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode([String: [Transcription]].self, from: data)
            let allTranscriptions = response["transcription"] ?? []

            transcriptions = allTranscriptions.filter { $0.callUuid == callUuid }
            isLoading = false
        } catch {
            print("Loading JSON ERROR: \(error)")
            isLoading = false
        }
    }
}

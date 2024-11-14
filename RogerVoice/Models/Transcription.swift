//
//  Transcription.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import Foundation

struct Transcription: Identifiable, Codable {
    let id: UUID
    let callUuid: UUID
    let direction: TranscriptionDirection
    let text: String

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case callUuid
        case direction
        case text
    }
}

enum TranscriptionDirection: Int, Codable {
    case outgoing = 1
    case incoming = 0
}

// Sample Data Extension for Preview debug
extension Transcription {
    static let sampleData = [
        Transcription(
            id: UUID(),
            callUuid: UUID(uuidString: "eda3fec2-975a-4b52-87fa-66abf9debf5e")!,
            direction: .incoming,
            text: "Hello, this is a sample incoming message."
        ),
        Transcription(
            id: UUID(),
            callUuid: UUID(uuidString: "eda3fec2-975a-4b52-87fa-66abf9debf5e")!,
            direction: .outgoing,
            text: "Hi there! This is a sample outgoing message."
        )
    ]
}

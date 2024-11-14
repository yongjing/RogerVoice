//
//  Call.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import Foundation

struct CallsResponse: Codable {
    let call: [Call]
}

struct Call: Identifiable, Codable {
    let id: UUID
    let phoneNumber: String
    let startDate: Date
    let endDate: Date?
    let direction: CallDirection
    let status: CallStatus

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case phoneNumber
        case startDate
        case endDate
        case direction
        case status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)

        let formatter = ISO8601DateFormatter()
        // Decode date
        let startDateString = try container.decode(String.self, forKey: .startDate)
        startDate = formatter.date(from: startDateString) ?? Date()

        if let endDateString = try container.decodeIfPresent(String.self, forKey: .endDate) {
            endDate = formatter.date(from: endDateString)
        } else {
            endDate = nil
        }

        direction = try container.decode(CallDirection.self, forKey: .direction)
        status = try container.decode(CallStatus.self, forKey: .status)
    }
}

enum CallDirection: Int, Codable {
    case outgoing = 1
    case incoming = 0
}

enum CallStatus: Int, Codable {
    case success = 0
    case missed = 1
    case rejected = 2
    case notReached = 3
}

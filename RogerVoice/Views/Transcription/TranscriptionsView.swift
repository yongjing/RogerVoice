//
//  TranscriptionsView.swift
//  RogerVoice
//
//  Created by Yongjing CHEN on 14/11/2024.
//

import SwiftUI

struct TranscriptionsView: View {
    @ObservedObject var viewModel: TranscriptionsViewModel
    @Environment(\.presentationMode) var presentationMode
    let phoneNumber: String
    let timestamp: String

    var body: some View {
        NavigationView {
            VStack {
                // Transcriptions list
                List {
                    Section(header: messageHeader) {
                        ForEach(viewModel.transcriptions) { transcription in
                            if transcription.direction == .incoming {
                                IncomingMessageCell(text: transcription.text)
                                    .listRowSeparator(.hidden)
                            } else {
                                OutgoingMessageCell(text: transcription.text)
                                    .listRowSeparator(.hidden)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .listRowSeparator(.hidden)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }) {
                        Image("Back Arrow Blue")
                    }
                }

                // Center Title with Phone Number and Date
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text(phoneNumber)
                            .font(.headline)
                        Text(timestamp)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadTranscriptions()
                }
                // Hide the navigation bar when the view appears
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let navigationController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
                    navigationController.setNavigationBarHidden(true, animated: true)
                }
            }
            .onDisappear {
                // Show the navigation bar again when leaving the view
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let navigationController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
                    navigationController.setNavigationBarHidden(false, animated: true)
                }
            }
        }
        .background(.white)
    }
}

// Header view
var messageHeader: some View {
    HStack {
        Spacer()
        Text("🔒 Ce message sous-titré est encrypté et stocké de manière sécurisée.")
            .font(.system(size: 12))
            .foregroundColor(.gray)
            .lineLimit(2)
            .padding(EdgeInsets(top: 12, leading: 18, bottom: 12, trailing: 18))
        Spacer()
    }
    .frame(height: 54)
    .background(Color.RVColor.backgroundGray)
    .cornerRadius(10)
}

struct IncomingMessageCell: View {
    var text: String

    var body: some View {
        HStack {
            Text(text)
                .padding()
                .background(Color.white)
                .foregroundColor(Color.RVColor.textGray)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.RVColor.lightGray, lineWidth: 2)
                )
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct OutgoingMessageCell: View {
    var text: String

    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .padding()
                .background(Color.RVColor.backgroundGreen)
                .foregroundColor(Color.RVColor.textGreen)
                .cornerRadius(20)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let mockViewModel = MockTranscriptionsViewModel(callUuid: UUID(uuidString: "f0a588e7-941d-4e66-89d1-9389e2d9acba")!)
    TranscriptionsView(viewModel: mockViewModel, phoneNumber: "+33 6 49 14 40 80", timestamp: "10 sept. 2024 à 9:28")
}

class MockTranscriptionsViewModel: TranscriptionsViewModel {
    override init(callUuid: UUID) {
        super.init(callUuid: callUuid)
        self.transcriptions = Transcription.sampleData // Use the sample data
    }

    override func loadTranscriptions() async {
    }
}

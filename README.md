# 📱 Yongjing‘s RogerVoice Technical test

## Project Structure

```mathematica
RogerVoice
│
├── Core
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── UIColor+RV.swift
│
├── Models
│   ├── Call.swift
│   └── Transcription.swift
│
├── ViewModels
│   ├── RecentCallsViewModel.swift
│   └── TranscriptionsViewModel.swift
│
├── Views
│   ├── Parameter
│   │   ├── ParameterViewController.swift
│   │   └── Parameter.storyboard
│   │
│   ├── RecentCall
│   │   ├── RecentCallsViewController.swift
│   │   ├── RecentCallCell.swift
│   │   └── Recent.storyboard
│   │
│   └── Transcription
│       ├── TranscriptionsView.swift (SwiftUI screen)
│
└── Resources
    ├── Assets.xcassets
    ├── calls.json
    ├── transcriptions.json
    └── Info.plist
```

---

## Technical Highlights

- **MVVM Architecture**: Ensures clear separation of concerns, making the project scalable and maintainable.
- **UIKit Screen**: Each screen uses a dedicated storyboard, enhancing ease of maintenance and facilitating team collaboration.
- **Combine**: Improves data binding in `ViewModel`s and supports asynchronous operations
- **Multi-threading**: `Task` and `async/await` for efficient background data processing. Ensures that all UI updates occur on the main thread
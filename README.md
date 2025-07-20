# Gym Freak: An AI-Powered Exercise Monitoring Application

## Project Overview

**Gym Freak** is a modern Flutter application designed to help users monitor and improve their fitness journey. While the app is architected for future AI-powered exercise analysis, the current version focuses on delivering a robust, user-friendly experience for tracking workouts, meals, sleep, and progress—all without requiring any backend AI APIs.

## Features

- **Workout Tracker:** Log and monitor various exercises and routines.
- **Meal Planner:** Plan meals and view nutritional information.
- **Sleep Tracker:** Track sleep schedules and set alarms.
- **Photo Progress:** Capture and compare progress photos over time.
- **Profile Management:** Manage personal details and fitness goals.
- **Onboarding & Authentication:** Smooth onboarding and login/signup flows.
- **Beautiful UI:** Custom fonts, icons, and responsive layouts.

> **Note:** AI-powered features are planned for future releases. The current app does not include AI model APIs.



## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or Xcode (for Android/iOS builds)
- A device or emulator

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/abdullahsohail-00/Gym-Freak-An-AI-Powered-Exercise-Monitoring-Application.git
   cd your-repo-name
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   - For Android:
     ```bash
     flutter run
     ```
   - For iOS:
     ```bash
     flutter run
     ```

> _Ensure you have a connected device or emulator running._

---

## Folder Structure

```
├── android/            # Android native files
├── assets/             # Images, fonts, and workout GIFs
├── dev_lib/            # Custom or third-party Flutter libraries
├── ios/                # iOS native files
├── lib/                # Main Dart codebase
│   ├── Models/         # Data models
│   ├── Utils/          # Utility functions
│   ├── common/         # Common helpers/extensions
│   ├── common_widget/  # Reusable widgets
│   └── view/           # App screens (workout, sleep, meal, etc.)
├── pubspec.yaml        # Flutter project configuration
└── README.md           # Project documentation
```

---

## Dependencies

Key packages used:
- `carousel_slider`, `fl_chart`, `simple_animation_progress_bar`, `dotted_dashed_line`, `simple_circular_progress_bar`, `animated_toggle_switch`, `readmore`, `calendar_agenda`, `intl`, `shared_preferences`, `velocity_x`, `http`, `image_picker`, `url_launcher`, `camera`, `path_provider`, `flutter_inappwebview`, `cached_network_image`, and more.

See [`pubspec.yaml`](pubspec.yaml) for the full list.

---

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements, bug fixes, or new features.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


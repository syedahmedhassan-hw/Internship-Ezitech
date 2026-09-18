# Flutter Counter App

A simple and interactive **Counter Application** built with Flutter as part of **Internship Task 2 (Ezitech)**.

---

## 📱 About the Project

This application demonstrates the fundamentals of state management and UI design in Flutter using a `StatefulWidget`. The app allows users to increment a numeric counter each time a button is pressed, dynamically updating the UI in real-time.

---

## ✨ Features

- **Dynamic State Management**: Utilizes Flutter's built-in `setState()` to update and render count changes.
- **Interactive UI**: Clean and centered layout featuring an AppBar, descriptive text, a large numeric display, and an action button.
- **Material Design**: Follows standard Material Design guidelines with a clean presentation.
- **Cross-Platform**: Ready to run on Android, iOS, Web, macOS, Linux, and Windows.

---

## 📂 Project Structure

```text
counter_app/
├── android/               # Android native configuration
├── ios/                   # iOS native configuration
├── lib/
│   └── main.dart          # Main application source code
├── test/
│   └── widget_test.dart   # Widget testing
├── pubspec.yaml           # Project dependencies & metadata
└── README.md              # Project documentation
```

---

## 🧩 Code Architecture & Components

The core logic is implemented in [`lib/main.dart`](file:///d:/Internship%20Ezitech/Task%202/counter_app/lib/main.dart):

1. **`main()`**: The entry point of the Flutter application that launches `MyApp`.
2. **`MyApp` (`StatelessWidget`)**:
   - The root widget of the application.
   - Configures the `MaterialApp` theme and sets `CounterPage` as the home screen.
3. **`CounterPage` (`StatefulWidget`)**:
   - The stateful interface representing the counter screen.
4. **`_CounterPageState` (`State<CounterPage>`)**:
   - **State variable**: `int counter = 0;`
   - **Method**: `increaseCounter()` — calls `setState()` to increment the counter value and trigger a widget rebuild.
   - **UI Widgets**:
     - `Scaffold`: Provides the top `AppBar` with the title *"My Counter App"*.
     - `Center` & `Column`: Vertically and horizontally aligns the content.
     - `Text`: Displays user prompt and counter value styled with large bold typography (`fontSize: 50`).
     - `ElevatedButton`: Triggers `increaseCounter` when clicked.

---

## 🚀 How to Run the App

### Prerequisites
Make sure you have Flutter installed on your system. You can verify your setup with:
```bash
flutter doctor
```

### Steps to Run
1. **Navigate to the project directory**:
   ```bash
   cd "d:/Internship Ezitech/Task 2/counter_app"
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

---

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - UI framework
- [Dart](https://dart.dev/) - Programming language

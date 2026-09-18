# 📱 Profile Card App (Task 3 - Ezitech Internship)

A clean, responsive, and modern Flutter application that displays a personal user profile card with user details, an about section, contact information, and interactive action buttons.

---

## 🚀 Overview

The **Profile Card App** is developed as part of **Task 3** for the Ezitech Internship. The app demonstrates core Flutter layout concepts, Material Design widgets, scrollable container layouts, and responsive UI structuring.

---

## ✨ Features & UI Components

### 1. 👤 Profile Header Card
- **Avatar**: Circular profile icon (`CircleAvatar`) with accent background.
- **Name**: Displayed with bold, prominent typography (**Syed Ahmed Hassan**).
- **Headline / Title**: Displays professional title (**Flutter Developer & Student**).
- **Styling**: Outlined border container with rounded corners and neat padding.

### 2. 📝 About Me Section
- Dedicated card highlighting a summary and bio.
- Clean line-height and typography for comfortable reading.

### 3. 📞 Contact Information Card
Structured list containing contact details with intuitive icons:
- ✉️ **Email**: `syed@example.com`
- 📞 **Phone**: `+92 300 1234567`
- 📍 **Location**: `Pakistan`

### 4. 🔘 Action Buttons
- **Connect Button**: Primary `ElevatedButton` for initiating connection.
- **Message Button**: Secondary `OutlinedButton` for sending direct messages.

### 5. 📐 Responsive & Safe Layout
- Integrated with `SafeArea` to avoid system notches and navigation bars.
- Uses `SingleChildScrollView` to support devices of all screen sizes without overflow issues.

---

## 🛠️ Tech Stack & Dependencies

- **Language:** [Dart](https://dart.dev/)
- **Framework:** [Flutter](https://flutter.dev/) (Material 3 Design)
- **Icons:** Material Icons & Cupertino Icons

---

## 📂 Project Structure

```text
profile_card_app/
├── android/               # Android native configuration
├── ios/                   # iOS native configuration
├── lib/
│   └── main.dart          # Main application entry point & ProfilePage UI
├── test/                  # Unit and widget tests
├── pubspec.yaml           # App dependencies and assets configuration
└── README.md              # Project documentation
```

---

## 🚀 How to Run the App

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed (v3.x or higher)
- Android Studio / VS Code / Cursor
- An active Android Emulator, iOS Simulator, or connected physical device

### Steps

1. **Clone or navigate to the project directory:**
   ```bash
   cd "d:/Internship Ezitech/Task 3/profile_card_app"
   ```

2. **Get all dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

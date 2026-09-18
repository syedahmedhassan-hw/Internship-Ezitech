# 📱 Simple Calculator (Flutter Web & Mobile)

A sleek, responsive, and cross-platform Calculator application built using **Flutter** and **Dart**, designed to work seamlessly on **Web browsers**, **Desktop**, and **Mobile devices (Android & iOS)**.

---

## 🚀 Overview: What Was Created

This project is a modern standard calculator application developed as part of **Task 1**. It delivers an intuitive user experience with support for both touch/mouse interactions and full **physical keyboard support on the Web & Desktop**.

### ✨ Key Features

- **Standard Arithmetic Operations**:
  - Addition (`+`)
  - Subtraction (`−`)
  - Multiplication (`×`)
  - Division (`÷`)
- **Chained Calculations**: Allows sequential calculations (e.g., `5 + 5 * 2 = 20`) accurately.
- **Division by Zero Protection**: Displays friendly `Error` state instead of crashing when dividing by zero.
- **Clear & Reset (`C`)**: Quickly clear the display and reset all operand states.
- **Backspace Support**: Remove trailing digits one by one when using keyboard input.
- **🌐 Responsive Web Layout**: 
  - Centered, modern card layout optimized for desktop and ultrawide browsers.
  - Expands smoothly on mobile and tablet viewport sizes.
- **⌨️ Physical Keyboard & Numpad Shortcuts (Web & Desktop)**:
  - `0` - `9`: Enter numbers
  - `+`, `-`, `*`, `/`: Arithmetic operators
  - `Enter` or `=`: Calculate result
  - `Backspace`: Delete last digit
  - `Escape` or `C`: Clear calculator display
- **Material 3 Theming**: Modern Google Material 3 design system with custom color seed.

---

## 📂 Project Structure

```
simple_calculator/
├── lib/
│   └── main.dart            # Main application entry point, Calculator UI & logic, Keyboard handling
├── test/
│   └── widget_test.dart     # Comprehensive widget & keyboard interaction tests
├── web/
│   ├── index.html           # Web app container & metadata configuration
│   ├── manifest.json        # Web app manifest for PWA support
│   └── favicon.png          # App icon for browser tab
├── pubspec.yaml             # Flutter dependencies & metadata
└── README.md                # Project documentation & usage guide
```

---

## 🛠️ How to Run & Build the Project

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.x or higher)
- Google Chrome, Edge, or any modern web browser

---

### 1. 🌐 Running on Web (Development Mode)

To run the application directly in your browser with hot-reload enabled:

```bash
flutter run -d chrome
```

Or run via local web server:

```bash
flutter run -d web-server --web-port=8080
```

---

### 2. 📦 Building for Web Deployment (Production Mode)

To generate the optimized production web build:

```bash
flutter build web --release
```

The compiled static web assets will be generated in:
```
build/web/
```

You can host the contents of `build/web/` on any static hosting platform such as:
- **GitHub Pages**
- **Firebase Hosting**
- **Vercel / Netlify**
- **Local Python HTTP Server**:
  ```bash
  cd build/web
  python -m http.server 8000
  ```
  Then open `http://localhost:8000` in your browser.

---

### 3. 🧪 Running Automated Tests

To execute the widget test suite (covering addition, chained operations, division by zero, clear, and keyboard input):

```bash
flutter test
```

---

## ⌨️ Keyboard Shortcuts Reference

| Action | Physical Key / Shortcut |
| :--- | :--- |
| **Number Inputs** | `0` to `9` (Alpha keys or Numpad) |
| **Addition** | `+` or `Numpad +` |
| **Subtraction** | `-` or `Numpad -` |
| **Multiplication** | `*` or `Numpad *` |
| **Division** | `/` or `Numpad /` |
| **Equal / Calculate** | `Enter`, `Numpad Enter`, or `=` |
| **Backspace (Delete)** | `Backspace` |
| **Clear Display** | `Escape` or `C` |


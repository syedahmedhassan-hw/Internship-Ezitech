# Ezitech Internship — Flutter Development

A comprehensive portfolio showcasing all projects developed during the **Ezitech Mobile App Development Internship**. This repository consolidates weekly tasks ranging from fundamental Dart and Flutter concepts to production-grade mobile telemetry, sensor integration, and e-commerce applications.

---

## 🚀 Technologies & Tools

- **Framework:** [Flutter](https://flutter.dev) (Dart SDK `^3.12.2`)
- **Language:** [Dart](https://dart.dev)
- **State Management:** `Provider`, `setState`
- **Hardware & Sensor APIs:** `geolocator`, `sensors_plus`, `mobile_scanner`, `image_picker`
- **Visualization & UI:** `flutter_map`, `latlong2`, `fl_chart`, `qr_flutter`, `google_fonts`, Material 3
- **Storage & Utilities:** `shared_preferences`, `share_plus`, `intl`
- **Tools:** Android Studio, VS Code, Android Wireless Debugging (ADB), Git / GitHub

---

## 📚 Internship Modules & Tasks Overview

### 📱 Task 1: Simple Calculator App
- **Directory:** [`Task 1/simple_calculator`](Task%201/simple_calculator)
- **Description:** A clean, responsive arithmetic calculator supporting basic operations (addition, subtraction, multiplication, division), error handling (such as division by zero), decimal formatting, and keyboard input listening for desktop/web testing.
- **Key Concepts:** `StatefulWidget`, event handling, `KeyboardListener`, mathematical evaluation, UI responsiveness.

---

### 📱 Task 2: Interactive Counter App & Wireless Debugging
- **Directory:** [`Task 2/counter_app`](Task%202/counter_app)
- **Description:** An interactive counter application created to practice Flutter's reactive widget tree and state management with `setState()`. Configured for and verified on physical Android devices via cable-free Android Wireless Debugging (`adb`).
- **Key Concepts:** State lifecycle, UI styling, Android ADB wireless pairing and deployment.

---

### 📱 Task 3: Profile Card App
- **Directory:** [`Task 3/profile_card_app`](Task%203/profile_card_app)
- **Description:** A personal developer profile and digital card interface featuring user avatars, structured biography sections, contact cards (email, phone, location), and social action buttons within a scrollable `SafeArea` layout.
- **Key Concepts:** Layout composition (`Column`, `Container`, `Card`, `CircleAvatar`), border styling, responsive spacing.

---

### 📱 Task 4: Recipe Finder App
- **Directory:** [`Task 4/recipe_finder`](Task%204/recipe_finder)
- **Description:** A multi-screen culinary recipe discovery application with a welcome splash screen, recipe listing cards with network images, interactive favorites toggle, structured ingredient checklists, and step-by-step preparation guides. Includes custom launcher icon configuration.
- **Assets:** Custom icon asset located at [`Task 4/recipe_finder/assets/recipe.png`](Task%204/recipe_finder/assets/recipe.png).
- **Key Concepts:** Multi-screen routing (`Navigator`), dynamic list rendering (`ListView.builder`), interactive state toggles, asset management (`flutter_launcher_icons`).

---

### 📱 Task 5: E-Commerce Store App ("Ahmed Store")
- **Directory:** [`Task 5/ecommerce_app`](Task%205/ecommerce_app)
- **Description:** A full-featured mobile shopping application featuring an animated splash screen, onboarding introduction, categorized product catalog (Electronics, Sports, Stationery, Clothing, Bags, Accessories), live keyword search filtering, product detail views with size selection, favorites management, and cart notification feedback.
- **Key Concepts:** Multi-view flow, filtering logic, Hero animations, search indexing, responsive grid layouts (`GridView`), Material 3 theme styling.

---

### 📱 Task 7: OmniSense Pro — Precision Mobile Telemetry & Spatial Suite
- **Directory:** [`Task 7`](Task%207)
- **Description:** An advanced, production-grade telemetry and sensor suite built with a glassmorphic cyberpunk interface. Integrates real-time device hardware sensors and location services.
- **Features:**
  - **Telemetry Hub:** Live dashboard monitoring GPS coordinates, 3-axis accelerometer, gyroscope rates, inclinometer, and audio levels.
  - **GeoSense Spatial Hub:** Real-time GPS location tracking, reverse geocoding, interactive OpenStreetMap radar mapping (`flutter_map`), coordinate sharing, and GPS simulation mode.
  - **Motion & Sensor Studio:** Live 3-axis waveform line charts (`fl_chart`), 360° dynamic digital compass, and decibel sound meter.
  - **Precision Digital Spirit Level:** Dual-axis bubble inclinometer with zero calibration baseline and surface alignment lock.
  - **QR Studio:** Multi-format QR generator (URLs, Wi-Fi, Contacts, Text, Location) and live camera barcode scanner (`mobile_scanner`) with persistent scan history.
  - **Customization:** 4 switchable persistent themes (Dark OLED, Cyber Teal, Sunset Violet, Clean Light) powered by `Provider` and `shared_preferences`.
- **Key Concepts:** `Provider` architecture, stream subscriptions, hardware sensors (`sensors_plus`, `geolocator`), vector generation (`qr_flutter`), charting, camera integration.

---

## 📁 Repository Structure

```text
.
├── .gitignore
├── README.md
├── Task 1/
│   ├── Setup flutter.txt
│   └── simple_calculator/
│       ├── lib/main.dart
│       └── pubspec.yaml
├── Task 2/
│   ├── Make a counter .txt
│   └── counter_app/
│       ├── lib/main.dart
│       └── pubspec.yaml
├── Task 3/
│   └── profile_card_app/
│       ├── lib/main.dart
│       └── pubspec.yaml
├── Task 4/
│   ├── Task 4.docx
│   └── recipe_finder/
│       ├── assets/recipe.png
│       ├── lib/main.dart
│       └── pubspec.yaml
├── Task 5/
│   ├── TASK 05.docx
│   └── ecommerce_app/
│       ├── lib/main.dart
│       └── pubspec.yaml
└── Task 7/
    ├── README.md
    ├── lib/
    │   ├── core/
    │   ├── models/
    │   ├── providers/
    │   ├── screens/
    │   ├── widgets/
    │   └── main.dart
    └── pubspec.yaml
```

---

## 🌐 Live Vercel Deployments (Independent Task Support)

Every task in this repository is equipped with dedicated **Vercel CI scripts (`vercel-build.sh`, `vercel.json`, and `package.json`)** to enable automated independent live web deployments on Vercel.

### 📋 Task-by-Task Vercel Configuration Table

| # | Task Application | Root Directory in Vercel | Build Command | Output Directory |
|:---:|:---|:---|:---|:---|
| **Hub** | **[Internship Showcase Hub](index.html)** | `.` (Root) | *(Static)* | `.` |
| **01** | **[Simple Calculator](Task%201/simple_calculator)** | `Task 1/simple_calculator` | `bash vercel-build.sh` | `build/web` |
| **02** | **[Counter App](Task%202/counter_app)** | `Task 2/counter_app` | `bash vercel-build.sh` | `build/web` |
| **03** | **[Profile Card App](Task%203/profile_card_app)** | `Task 3/profile_card_app` | `bash vercel-build.sh` | `build/web` |
| **04** | **[Recipe Finder](Task%204/recipe_finder)** | `Task 4/recipe_finder` | `bash vercel-build.sh` | `build/web` |
| **05** | **[Ahmed Store E-Commerce](Task%205/ecommerce_app)** | `Task 5/ecommerce_app` | `bash vercel-build.sh` | `build/web` |
| **07** | **[OmniSense Pro Telemetry](Task%207)** | `Task 7` | `bash vercel-build.sh` | `build/web` |

---

### 🚀 How to Deploy Each Task to Vercel (3 Easy Steps)

1. **Import Repository into Vercel:**
   - Go to the [Vercel Dashboard](https://vercel.com/dashboard) and click **"Add New..." &rarr; "Project"**.
   - Select your GitHub repository: `syedahmedhassan-hw/Internship-Ezitech`.

2. **Select Task Root Directory:**
   - In the project configuration screen, click **"Edit"** next to **Root Directory**.
   - Choose the task folder you want to deploy (e.g., `Task 5/ecommerce_app` or `Task 7`).

3. **Deploy:**
   - Leave Framework Preset as *Other* (the preconfigured `vercel.json` and `vercel-build.sh` automatically handle Flutter SDK installation, dependencies, and release web compilation).
   - Click **"Deploy"**!

> [!TIP]
> Repeat these steps for each task to get separate, dedicated live URLs for all your internship submissions (e.g. `ezitech-calculator.vercel.app`, `ezitech-omnisense.vercel.app`, etc.).

---

## 🚦 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.12.0 or newer)
- Android Studio / VS Code with Flutter & Dart extensions
- Android device, iOS simulator, or Chrome for Web execution

### Running Any Task Project

1. Navigate to the desired project directory:
   ```bash
   # Example: Running Task 5 E-Commerce App
   cd "Task 5/ecommerce_app"

   # Or Task 7 OmniSense Pro
   cd "Task 7"
   ```

2. Fetch package dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

---

## 👨‍💻 Author

**Syed Ahmed Hassan**  
*Flutter Developer & Mobile App Intern at Ezitech*

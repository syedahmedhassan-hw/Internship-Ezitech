# 🌐 OmniSense Pro — Precision Mobile Telemetry & Spatial Suite

**OmniSense Pro** (Task 7) is an advanced, production-grade Flutter application designed for high-precision device telemetry, environmental spatial tracking, motion analysis, and utility workflows. Built with a sleek glassmorphic cyberpunk UI, reactive state management, and real-time hardware sensor integration.

---

## 🚀 Key Features & Modules

### 1. ⚡ Telemetry Hub (Home Dashboard)
- **Real-Time Overview**: Live status cards for GPS position, 3-axis accelerometer, gyroscope rates, inclinometer, and audio levels.
- **Quick Action Grid**: Instant one-tap navigation to all specialized sub-studios.
- **Dynamic Telemetry Stream**: Live ambient noise level meter and telemetry diagnostics with system health indicators.

### 2. 📍 GeoSense Spatial Hub (GPS & Location Tracking)
- **Live GPS Telemetry**: Real-time tracking of latitude, longitude, altitude, speed, bearing, accuracy, and reverse geocoded street address.
- **Interactive Spatial Radar & Map**: Map visualization with custom radar coordinates powered by `flutter_map` and OpenStreetMap tile layers.
- **Location Sharing**: Generate instant Google Maps links and share live coordinates with one tap.
- **GPS Simulation Mode**: Built-in mock location generator allowing seamless testing on emulators and desktop platforms.

### 3. 📈 Motion & Sensor Studio (IMU Waveforms & Compass)
- **3-Axis Real-Time Graph**: Live waveform plotting for X, Y, and Z accelerometer vectors using `fl_chart`.
- **Dynamic 360° Digital Compass**: Smooth orientation compass with cardinal headings, target angles, and precision dial markings.
- **Environmental Sound Meter**: Visual decibel gauge with pulse animations.
- **Hardware Simulation Fallback**: Toggleable live data simulator for testing without physical motion hardware.

### 4. 📐 Precision Digital Spirit Level
- **Dual-Axis Inclinometer**: Bubble level widget measuring exact pitch and roll surface angles.
- **Zero Calibration**: Calibrate any surface to a relative `0.0°` baseline with persistent zero-offset correction.
- **Surface Level Lock**: Visual lock alert and color transitions (emerald green) when surfaces reach alignment within fine tolerance.

### 5. 🔲 QR Studio (Generator, Scanner & History)
- **Multi-Format Generator**: Generate custom QR codes for URLs, Plain Text, Wi-Fi configurations, Contacts (vCard), and Geolocation.
- **Color Customization & Sharing**: Custom foreground and background palette styling with instant sharing and saving.
- **Live Camera Scanner**: High-speed camera scanner powered by `mobile_scanner` with flash control, front/back camera toggling, and gallery photo barcode extraction.
- **Persistent Scan History**: Local history storage of generated and scanned codes with timestamps, copy-to-clipboard, and management actions.

### 6. 🎨 Customization & System Settings
- **4 Custom Themes**:
  - 🌌 **Dark OLED** (High-contrast deep space dark mode)
  - 💠 **Cyber Teal** (Neon futuristic cyan & teal accents)
  - 🌆 **Sunset Violet** (Vibrant magenta & purple gradient palette)
  - ☀️ **Clean Light** (Minimalist high-readability daylight mode)
- **Persistent Preferences**: Settings, themes, and calibration parameters saved locally via `shared_preferences`.

---

## 🛠️ Architecture & Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK `^3.12.2`)
- **State Management**: [Provider](https://pub.dev/packages/provider) (`MultiProvider` architecture with reactive `ChangeNotifier` stores)
- **Sensors & Hardware**:
  - `sensors_plus` — Accelerometer, Gyroscope, and User Accelerometer streams
  - `geolocator` — High-accuracy GPS positioning & geofencing telemetry
  - `mobile_scanner` — Fast native camera barcode & QR reading
- **Visualization & UI**:
  - `flutter_map` & `latlong2` — OpenStreetMap tile rendering and marker mapping
  - `fl_chart` — High-performance real-time telemetry line charts
  - `qr_flutter` — Vector QR code generation
  - `google_fonts` — Modern typography (Outfit & JetBrains Mono)
  - Custom Glassmorphism (`GlassCard`) with backdrop filters and glowing neon gradients
- **Utilities**:
  - `shared_preferences` — Key-value local persistence
  - `share_plus` — Native system sharing sheet
  - `image_picker` — Gallery image selection for QR decoding
  - `intl` — Date & time formatting

---

## 📁 Project Structure

```text
lib/
├── core/
│   └── theme/
│       ├── app_theme.dart          # Multi-theme definitions (OLED, Cyber Teal, Violet, Light)
│       └── theme_provider.dart    # Theme state management & persistence
├── models/
│   ├── location_data.dart         # Location telemetry data model
│   ├── qr_code_item.dart          # QR history & code structure
│   └── sensor_reading.dart        # 3-axis IMU readings & Spirit Level models
├── providers/
│   ├── location_provider.dart     # GPS tracking, stream controller, & simulation
│   ├── qr_provider.dart           # QR generator/scanner state & history manager
│   └── sensor_provider.dart       # IMU listeners, wave buffers, calibration offsets
├── screens/
│   ├── home_dashboard_screen.dart # Central telemetry control panel
│   ├── level_screen.dart          # Digital bubble level & inclinometer
│   ├── location_screen.dart       # GPS map, spatial coordinates & address
│   ├── qr_studio_screen.dart      # QR generator, camera scanner & history tabs
│   ├── sensor_screen.dart         # Accelerometer chart, compass & sound meter
│   └── settings_screen.dart       # Theme selector & telemetry configurations
├── widgets/
│   ├── compass_widget.dart        # 360° rotating compass dial
│   ├── custom_bottom_bar.dart     # Floating glassmorphic navigation bar
│   ├── dummy_map_widget.dart      # Interactive spatial radar map
│   ├── glass_card.dart            # Frosted glass container with neon borders
│   ├── sensor_chart.dart          # Live 3-axis fl_chart telemetry graph
│   ├── sound_meter_widget.dart    # Decibel sound gauge widget
│   └── spirit_level_widget.dart   # Interactive dual-axis bubble level
└── main.dart                      # App entry point & MultiProvider bootstrap
```

---

## 🚦 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.12.0 or newer)
- Android Studio / VS Code with Flutter extensions
- Android device or emulator with Google Play Services (or iOS Simulator / physical device)

### Installation & Run

1. **Clone or open the project repository:**
   ```bash
   cd "Task 7"
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on connected device / emulator:**
   ```bash
   flutter run
   ```

---

## 📱 Permissions Configuration

### Android (`android/app/src/main/AndroidManifest.xml`)
The application includes permissions for:
- `ACCESS_FINE_LOCATION` & `ACCESS_COARSE_LOCATION` (GPS positioning)
- `CAMERA` (Live QR scanning)
- `READ_EXTERNAL_STORAGE` / `READ_MEDIA_IMAGES` (Scanning QR from gallery photos)
- `HIGH_SAMPLING_RATE_SENSORS` (High-frequency IMU telemetry)

### iOS (`ios/Runner/Info.plist`)
- `NSLocationWhenInUseUsageDescription`
- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`

---

## 📄 License
Created as part of the **Ezitech Mobile App Development Internship (Task 7)**.

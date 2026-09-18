# 🍳 Recipe Finder App

A mobile recipe discovery application built with **Flutter** and **Dart**. This application is developed as part of **Ezitech Internship - Task 4**, designed to provide users with a clean, intuitive, and visually appealing way to browse, explore, and cook delicious recipes.

---

## 📱 Features

- **👋 Welcome / Onboarding Screen**:
  - Clean hero interface with custom culinary iconography.
  - Quick "Get Started" call-to-action button to enter the recipe catalog.

- **📜 Recipe Catalog (Home Screen)**:
  - Scrollable card-based list of delicious dishes (Biryani, Karahi, Zinger Burger, Paratha Roll, Cookies, etc.).
  - Displays thumbnail previews, dish names, cooking time, and difficulty badges (*Easy*, *Medium*).
  - Network image loading with automatic fallback placeholders.

- **📖 Detailed Recipe View**:
  - Full-width hero food imagery.
  - **Quick Stats**: Prep/cooking time and difficulty level.
  - **Interactive Favorite Toggle**: Add or remove recipes from favorites with real-time heart indicator.
  - **Ingredients Checklist**: Clean itemized list with check indicators.
  - **Step-by-Step Cooking Instructions**: Sequenced numerical guide for easy cooking.

- **🎨 UI / UX & Design**:
  - Material Design with a vibrant warm food-themed color palette (`Colors.orange`).
  - Smooth screen transitions and responsive layouts.
  - Custom launcher icon support configured via `flutter_launcher_icons`.

---

## 📂 Project Structure

```text
recipe_finder/
├── android/                   # Android native platform files
├── ios/                       # iOS native platform files
├── assets/                    # Project assets (icons, images)
│   └── recipe.png             # Application launcher icon
├── lib/
│   └── main.dart              # Main application entry point & all screen widgets
│       ├── RecipeApp          # Application root with Material theme
│       ├── recipes data       # Pre-configured recipe list & ingredients
│       ├── WelcomeScreen      # Initial landing / start screen
│       ├── HomeScreen         # Recipe list / catalogue screen
│       └── DetailScreen       # Recipe details, ingredients & instructions
├── pubspec.yaml               # Project dependencies and asset configuration
└── README.md                  # Project documentation
```

---

## 🛠️ Built With

- **[Flutter](https://flutter.dev/)** - UI Software Development Kit
- **[Dart](https://dart.dev/)** - Modern client-optimized programming language
- **[flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)** - Automated launcher icon generator
- **[Cupertino Icons](https://pub.dev/packages/cupertino_icons)** - iOS-styled icons support

---

## 🚀 Getting Started

### Prerequisites

Make sure you have Flutter installed on your machine:
```bash
flutter --version
```

### Installation & Running

1. **Clone or open the project folder**:
   ```bash
   cd recipe_finder
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **(Optional) Generate launcher icons**:
   ```bash
   dart run flutter_launcher_icons
   ```

4. **Run the application**:
   ```bash
   flutter run
   ```

---

## 🍲 Sample Recipes Included

| Recipe | Cooking Time | Difficulty |
| :--- | :--- | :--- |
| **Chicken Biryani** | 45 minutes | Medium |
| **Chicken Karahi** | 40 minutes | Medium |
| **Zinger Burger** | 30 minutes | Easy |
| **Paratha Roll** | 25 minutes | Easy |
| **Cookies** | 35 minutes | Easy |

# 🛍️ Ahmed Store - Flutter E-Commerce Application

A clean, modern, and responsive **E-Commerce Mobile Application** built with Flutter and Material 3 design principles as part of **Internship Ezitech - Task 5**.

---

## 📱 Project Overview

**Ahmed Store** is a multi-category retail mobile app designed to provide an intuitive shopping experience. It features a complete user flow from splash and onboarding to product discovery, category filtering, search, product details, cart management, and user profile.

---

## ✨ Features & What Is Made

### 1. 🚀 Splash Screen (`SplashScreen`)
- **Branded Launch Screen**: Elegant dark background (`#111827`) featuring the store logo badge and typography.
- **Tagline**: *"Everything you need in one place"*.
- **Auto-Navigation**: Displays a loading progress indicator and automatically transitions to the Onboarding Screen after 3 seconds.

### 2. 🌟 Onboarding Screen (`OnboardingScreen`)
- **Hero Imagery**: High-quality visual introduction.
- **Value Proposition**: Highlights available categories (stationery, sports, electronics, clothing, bags, and accessories).
- **Get Started Action**: Direct call-to-action button seamlessly navigating into the main marketplace.

### 3. 🏠 Home & Product Catalog Screen (`HomeScreen`)
- **Live Product Search**: Interactive search bar that filters products in real-time as the user types.
- **Category Filter**: Horizontal scrollable choice chips (`All`, `Stationery`, `Sports`, `Electronics`, `Clothing`, `Bags`, `Accessories`).
- **Product Grid**: Responsive 2-column grid layout with custom cards.
- **Quick Add-to-Cart**: Instant button on every product card with SnackBar feedback.
- **Empty State**: Fallback message when no products match search/filter criteria.
- **Top Bar Actions**: Fast access to Cart and Profile screens.

### 4. 🔍 Product Detail Screen (`ProductDetailScreen`)
- **Hero Animations**: Smooth image transitions when navigating from the product card.
- **Interactive Wishlist / Favorite**: Toggleable heart icon with visual state updates.
- **Product Specifications**: Displays high-res product image, title, price, and detailed description.
- **Size Selector**: Interactive size selection chips (`S`, `M`, `L`, `XL`).
- **Action Buttons**: Dual action buttons for **"Add to Cart"** and **"Buy Now"** with SnackBar notifications.

### 5. 🛒 Cart Screen (`CartScreen`)
- **Cart Item List**: Overview of selected cart items with thumbnails, titles, and itemized pricing.
- **Item Removal**: Delete action button for each cart item.

### 6. 👤 Profile Screen (`ProfileScreen`)
- **User Information**: Profile avatar and user greeting.
- **Quick Links**: Menu options for Account Settings and My Favorites.
- **Account Actions**: Full-width Logout button.

---

## 📦 Data Model & Mock Catalog

The application uses a strongly typed `Product` model:
- `name` (String)
- `category` (String)
- `image` (String URL)
- `price` (double)
- `description` (String)

Includes a diverse built-in catalog spanning multiple categories:
- 📓 **Stationery**: Notebook, Pen Set
- 👟 **Sports**: Running Shoes, Football, Basketball
- 🎧 **Electronics**: Wireless Headphones, Smart Watch
- 👕 **Clothing**: Hoodie
- 🎒 **Bags**: Classic Backpack
- 🕶️ **Accessories**: Sunglasses

---

## 🛠️ Technology Stack & Architecture

- **Framework**: Flutter (SDK `^3.12.2` / Dart 3)
- **UI Design**: Material 3 Design (`ThemeData`, `ColorScheme`, `ChoiceChip`, `Hero`, `Card`)
- **Icons**: Material Icons & Cupertino Icons
- **Image Handling**: `Image.network` with fallback error builder widgets
- **State Management**: Flutter `StatefulWidget` / `setState` for reactive local UI state

---

## 📂 Project Structure

```
ecommerce_app/
├── lib/
│   └── main.dart            # Main entry point containing all screens & product data
├── android/                 # Android native project files
├── ios/                     # iOS native project files
├── web/                     # Flutter web support
├── test/                    # Unit and widget tests
├── pubspec.yaml             # Project dependencies and configurations
└── README.md                # Project documentation
```

---

## 🚀 Getting Started & Installation

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- Android Studio / VS Code / IntelliJ IDEA with Flutter extensions.
- An Android/iOS Emulator or physical device connected.

### Installation Steps

1. **Clone or open the repository**:
   ```bash
   cd "d:/Internship Ezitech/Task 5/ecommerce_app"
   ```

2. **Get packages & dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

---

## 👨‍💻 Author
- **Developer**: Syed Ahmed Hassan
- **Internship**: Ezitech - Task 5


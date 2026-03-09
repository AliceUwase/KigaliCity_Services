# 🇷🇼 Kigali City Services

A comprehensive city directory mobile application built with **Flutter** and **Firebase**, designed to help residents and visitors discover and manage local services in Kigali, Rwanda.

---

## 📖 Project Overview

**Kigali City Services** serves as a single point of discovery for local services like hospitals, restaurants, cafes, banks, and more. Users can browse, search, and filter places, as well as add their own listings to the directory.

### 🚀 Key Features
- **Discover**: Browse and search for services across Kigali.
- **Interactive Maps**: See all places pinned on a Google Map.
- **Detailed Information**: View address, phone number, and location for every place.
- **Direct Action**: Call places directly or get directions via Google Maps.
- **User Listings**: Register accounts to add, edit, or delete your own place listings.
- **Security**: Secure authentication with email verification.

---

## 🛠️ Tech Stack

| Technology | Role |
|---|---|
| **Flutter** | Cross-platform UI Framework |
| **Dart** | Programming Language |
| **Firebase Auth** | Secure Authentication & Email Verification |
| **Cloud Firestore** | Real-time NoSQL Database |
| **Google Maps** | Interactive mapping and location services |
| **BLoC/Cubit** | State Management |
| **url_launcher** | External intent handling (Calls/Maps) |

---

## 🏗️ Architecture Overview

The project follows a **three-layer architecture** for clean separation of concerns:

- **Presentation Layer**: UI Screens and reusable Widgets.
- **Logic Layer (Cubit)**: Manages application state and business logic.
- **Data Layer**: Repositories for Firestore interaction and Data Models.

This ensures real-time updates across all screens whenever data changes in the Firestore database.

---

## 🏁 Getting Started

Follow these steps to set up the project locally.

### 🧰 Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.5.0)
- [Firebase account](https://console.firebase.google.com/)
- [Google Maps API Key](https://developers.google.com/maps/documentation/android-sdk/get-api-key)

### 📥 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/AliceUwase/KigaliCity_Services.git
   cd KigaliCity_Services
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Environment Setup**:
   - Copy `.env.example` to `.env`.
   - Add your Google Maps API Key to the `.env` file.
   ```bash
   cp .env.example .env
   ```

4. **Firebase Configuration**:
   - Ensure you have the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) installed.
   - Run `flutterfire configure` to link your local project to your Firebase project.

5. **Run the app**:
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
KigaliCity_Services/
├── lib/
│   ├── main.dart             # App Entry & Auth Routing
│   ├── core/                 # Themes & Shared Utilities
│   ├── data/                 # Models & Repositories
│   ├── logic/                # BLoC/Cubit implementation
│   └── presentation/         # Screens & Widgets
├── android/                  # Android-specific configuration
├── ios/                      # iOS-specific configuration
└── pubspec.yaml              # Package dependencies
```

---

## 🔐 Authentication Flow

The app uses a `StreamBuilder` at the root (`main.dart`) to handle routing automatically:
- **No User** ➡️ `LoginScreen`
- **Unverified User** ➡️ `EmailVerificationScreen`
- **Verified User** ➡️ `MainScreen` (Directory)

---

## ⚖️ License

Distributed under the MIT License. See `LICENSE` for more information.

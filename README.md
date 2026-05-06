# Smart Emergency Response & Incident Reporting App 🚨

A comprehensive, production-ready Flutter application designed for rapid emergency reporting, real-time responder communication, and advanced administrative management. This project serves as a full-featured solution for campus, residential, and workplace safety, including a dedicated **MAD Practical Exam Portal** with offline-first capabilities.

## 📱 Features

### Core Application (Firebase & GetX)
*   **Rapid First Responder Alerts:** Instant communication with Police, Ambulance, and Fire services.
*   **Live Location Tracking:** Real-time GPS sharing with active responders via Google Maps API.
*   **Emergency Video Streaming:** Live video feeds for remote incident assessment.
*   **Emergency Contact Sync:** Automatic distress SMS alerts to predefined emergency contacts.
*   **Web Integration:** Dedicated admin web panel for global incident oversight.

### MAD Practical Exam Portal (Provider & Hive)
*   **Offline-First Reporting:** Log incidents without an internet connection using **Hive** local storage.
*   **Priority Intelligence:** Automatic sorting and color-coding (Red/Critical, Yellow/Medium) for urgent cases.
*   **Admin Analytics Dashboard:** Interactive data visualization using `fl_chart` for incident metrics.
*   **Smart Search & Filter:** Granular incident tracking by ID, category, priority, and status.
*   **Auto-Sync Simulation:** Dynamic connectivity detection and simulated cloud synchronization.

## 🛠️ Technology Stack

*   **Framework:** Flutter (Dart)
*   **State Management:** GetX (Core) & Provider (Exam Portal)
*   **Backend/Cloud:** Firebase (Auth, Realtime Database)
*   **Local Storage:** Hive & Shared Preferences
*   **Visualization:** fl_chart
*   **Maps/Location:** Google Maps Flutter, Geolocator
*   **Communication:** Background SMS, Zego UIKit (Live Streaming)

## 📂 Project Architecture
```text
lib/
 ├── Features/        # Core business modules (User, Responder, Admin)
 ├── mad_exam/        # Dedicated MAD Practical Exam module (Provider + Hive)
 │    ├── models/     # Incident data structures
 │    ├── providers/  # State management logic
 │    ├── screens/    # Exam-specific UI screens
 │    └── services/   # Offline storage & connectivity
 ├── Common Widgets/  # Reusable UI components
 └── main.dart        # Entry point with dual-mode initialization
```

## 🚀 Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/dev11062004/MAD-Emergency-Response-App.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Configure Firebase:**
   Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly placed.
4. **Run the app:**
   ```bash
   flutter run
   ```

## 📜 Development Timeline & Commit Requirements
This project strictly follows the MAD Practical Exam milestones:
1. **Project Initialization:** Base setup, dependencies, and architecture.
2. **UI Implementation:** Responsive screens for reporting and administration.
3. **Core Logic:** Incident management, priority algorithms, and state handling.
4. **Offline & Final Polish:** Hive integration, charts, and final optimizations.

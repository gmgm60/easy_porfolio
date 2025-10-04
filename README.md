# Easy Portfolio - Flutter Developer Portfolio

A cross-platform (iOS, Android, Web) portfolio application for developers to showcase their work, skills, and experience. Built with Flutter and powered by Firebase.

## ✨ Features

- **📝 Profile Management:** Display your bio, skills, work experience, and education.
- **🚀 Project Showcase:** A gallery to feature your projects with images, descriptions, and links (GitHub, Live Demo, etc.).
- **📞 Contact Information:** A dedicated section for your email, phone, and social media profiles.
- **🎨 Theme Customization:** Personalize the look and feel of your portfolio by changing the primary color.
- **🔒 Admin Dashboard:** A secure, private dashboard for you to easily manage all your portfolio content.
- **📱 Cross-Platform:** A single codebase for iOS, Android, and Web.
- **🌐 Offline Support:** Content is cached locally for offline viewing.

## 🛠️ Tech Stack & Architecture

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **Architecture:** Clean Architecture
- **State Management:** [Riverpod](https://riverpod.dev/)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router)
- **Backend:** [Firebase](https://firebase.google.com/) (Authentication, Firestore, Storage)
- **Local Cache:** [Hive](https://pub.dev/packages/hive)
- **CI/CD:** [Codemagic](https://codemagic.io/)

The project follows a strict Clean Architecture pattern, separating the UI (Presentation), business logic (Domain), and data handling (Data) into independent layers. This makes the codebase scalable, maintainable, and testable.

## 📂 Project Structure

The project is organized into the following main directories:

```
lib/
 ├── core/          # Common utilities, constants, theme
 ├── features/      # Application features (e.g., profile, projects)
 │   ├── profile/
 │   │   ├── data/
 │   │   ├── domain/
 │   │   └── presentation/
 │   └── ...
 ├── services/      # Abstracted services (e.g., auth, storage)
 └── ...
```

## 🚀 Getting Started

1.  **Clone the repository:**
    ```sh
    git clone <repository-url>
    cd easy_porfolio
    ```

2.  **Set up Firebase:**
    - Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    - Configure your Flutter app for iOS, Android, and Web.
    - Download and place `google-services.json` in `android/app/`.
    - Download and place `GoogleService-Info.plist` in `ios/Runner/`.
    - Add your Firebase web configuration to `web/index.html`.

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the app:**
    ```sh
    flutter run
    ```

## Screenshots

*(Coming Soon)*
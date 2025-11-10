# Easy Portfolio — Flutter Developer Portfolio

A cross-platform portfolio app (iOS, Android, Web) for developers to showcase projects, skills, and contact info. Built with Flutter and designed around Clean Architecture. Firebase is used for backend services (auth, Firestore, storage).

## Status

- Platform: iOS · Android · Web
- State: Active development

## Quick links

- Repository: (this workspace)
- Flutter SDK: https://flutter.dev

## Key features

- Profile management (bio, skills, experience, education)
- Project showcase with images, descriptions and links (GitHub / Live demo)
- Contact section (email, social links)
- Theme customization (primary color, light/dark)
- Admin dashboard for content management
- Cross-platform single codebase (iOS/Android/Web)
- Offline caching for faster load and offline viewing

## Tech Stack & Architecture

- Framework: Flutter
- Language: Dart
- Architecture: Clean Architecture (presentation / domain / data)
- State management: Riverpod
- Navigation: GoRouter
- Backend: Firebase (Auth, Firestore, Storage)
- Local cache: Hive
- CI/CD: Codemagic (optional)

## Project layout (high level)

```
lib/
 ├── core/          # utilities, constants, theme
 ├── features/      # feature modules (profile, projects, onboarding, contact)
 ├── apps/          # platform entrypoints if present
 └── widgets/       # reusable UI components
```

## Getting started (local)

1. Clone the repository and enter the folder:

```sh
git clone <repository-url>
cd easy_porfolio
```

2. Install Dart/Flutter if you haven't already: follow https://flutter.dev/docs/get-started/install

3. Install dependencies:

```sh
flutter pub get
```

4. Firebase setup (required for full functionality):

- Create a Firebase project at https://console.firebase.google.com/
- Add Android, iOS and/or Web apps in the Firebase console.
- Android: download `google-services.json` and place it in `android/app/`.
- iOS: download `GoogleService-Info.plist` and add it to `ios/Runner/` (in Xcode add to the Runner target).
- Web: copy the Firebase config snippet into `web/index.html` (replace placeholders).
- Configure Firestore rules and any required collections (projects, profile, users).

Notes:
- Do not commit your Firebase credentials or service files to a public repo.
- For local testing without Firebase, consider mocking or using emulator suite.

## Run the app

- Run on a connected device / simulator:

```sh
flutter run
```

- Run on a specific platform (examples):

```sh
# iOS simulator
flutter run -d ios

# Android emulator
flutter run -d emulator-5554

# Web (Chrome)
flutter run -d chrome
```

## Build (release)

```sh
# Android release
flutter build apk --release

# iOS (requires Xcode & signing)
flutter build ios --release

# Web
flutter build web
```

## Testing

Run unit/widget tests (if present):

```sh
flutter test
```

## Contributing

Contributions are welcome. A quick checklist for contributors:

1. Fork the repo and create a feature branch.
2. Run and test locally.
3. Open a pull request with a clear description of changes.

Please follow existing code style and run tests before submitting.

## Screenshots

Add screenshots or a demo GIF in this section. (Place images in `assets/` and reference them here.)

## Contact

Project maintained by the repository owner. For questions or help, open an issue or contact the author via the repo profile.

## License

This repo does not include a license file. Add a `LICENSE` if you want to make the terms explicit.

---

If you'd like, I can also:

- add badges (build / Flutter / pub / license) if you provide the repo URL and CI details
- create a short CONTRIBUTING.md
- add example screenshots / seed data

*(README updated to include quickstart, Firebase notes, and contribution guidance.)*
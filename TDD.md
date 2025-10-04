# 🛠️ Technical Design Document (TDD)

## 1. Introduction
This document describes the **technical implementation details** of the **Flutter Portfolio App for Developers**.  
It defines frameworks, libraries, design patterns, coding standards, and how modules interact.

---

## 2. Technology Stack
- **Frontend**: Flutter (Mobile + Web).
- **Language**: Dart.
- **State Management**: Riverpod.
- **Navigation**: GoRouter with AuthGuard.
- **Networking**: Dio + Retrofit (abstracted).
- **Backend (initial)**: Firebase (Auth, Firestore, Storage, Analytics).
- **Storage Abstraction**: Interface to support Firebase / Cloudinary / Supabase.
- **Build/CI**: Codemagic.
- **Testing**: Unit, Widget, Integration.
- **Version Control**: GitHub.

---

## 3. Project Structure
```
lib/
 ├── core/                # Common utilities, constants
 │    ├── theme/          # Theming & color configs
 │    ├── network/        # Dio setup, interceptors
 │    └── utils/          # Helpers, extensions
 │
 ├── features/            # Each module is independent
 │    ├── profile/
 │    │    ├── data/      # Repos, models
 │    │    ├── domain/    # Use cases
 │    │    └── presentation/ # UI + State
 │    ├── projects/
 │    ├── contact/
 │    └── theme/
 │
 ├── services/            # Abstract services (storage, auth, cache)
 │    ├── firebase/
 │    ├── rest/
 │    └── interfaces/
 │
 ├── app.dart             # Root app
 └── main.dart            # Entry point
```

---

## 4. Coding Standards
- **Clean Architecture** enforced: `presentation → domain → data`.
- **Dependency Injection**: Riverpod providers.
- **Naming Conventions**:
  - Classes → PascalCase.
  - Variables/Methods → camelCase.
  - Constants → SCREAMING_SNAKE_CASE.
- **Error Handling**: Result/Either pattern for async ops.
- **Code Formatting**: `flutter format` + `lint` rules.

---

## 5. API Design
### 5.1 Abstraction Interface
```dart
abstract class ProjectRepository {
  Future<List<Project>> getProjects();
  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<void> deleteProject(String id);
}
```

### 5.2 Firebase Implementation
- Firestore: `/projects/{projectId}`.
- Storage: `/projects/{projectId}/screenshots/*`.

### 5.3 REST Implementation
- `GET /projects`
- `POST /projects`
- `PUT /projects/:id`
- `DELETE /projects/:id`

---

## 6. Data Management
### 6.1 Models (Example)
```dart
class Project {
  final String id;
  final String title;
  final String description;
  final List<String> screenshots;
  final Map<String, String> links;
}
```

### 6.2 Caching Strategy
- Local DB: `Hive` for offline cache.
- Data flow:
  - On fetch → check cache first → if stale, fetch from network → update cache.

---

## 7. Authentication Flow
1. User logs in (Email/Password).  
2. Token saved securely (EncryptedSharedPreferences / FlutterSecureStorage).  
3. AuthGuard checks state before routing to Dashboard.  
4. Refresh handled automatically by Firebase SDK.  

---

## 8. Theming
- **Primary color** customizable by developer.
- Light/Dark theme support.
- Stored in Firestore → synced across devices.

---

## 9. Analytics
### Events
- `app_opened`
- `profile_viewed`
- `project_viewed`
- `contact_clicked`
- `cv_downloaded`
- `theme_changed`
- `login_success`
- `project_added`

Data shown in Dashboard (charts via `charts_flutter` or `fl_chart`).

---

## 10. Testing Plan
### 10.1 Unit Tests
- Test domain logic & use cases.
- Mock repositories.

### 10.2 Widget Tests
- Ensure UI renders correctly with mock data.

### 10.3 Integration Tests
- Test flows: login, add project, offline mode.

---

## 11. CI/CD
- **Codemagic Pipelines**:
  - `dev` → Deploy to Firebase Hosting (web) + Internal Test (Android/iOS).
  - `staging` → QA testers.
  - `production` → Play Store + App Store.

---

## 12. Risks & Mitigations
- **Firebase lock-in** → abstraction layer ensures portability.
- **Offline consistency** → Hive cache strategy with sync.
- **Cross-platform UI issues** → widget tests + responsive design.

---

## 13. Future Considerations
- Add Google OAuth.
- Notifications for multi-user version.
- GraphQL API support.
- Multi-language support.

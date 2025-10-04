# 📑 Software Requirements Specification (SRS)

## 1. Introduction
### 1.1 Purpose
This document defines the requirements for the **Flutter Portfolio App for Developers**.

### 1.2 Scope
- Cross-platform app: Mobile (iOS/Android) + Web (Flutter Web).
- Showcases developer profile, projects, contact details, and themes.
- Includes private dashboard for the developer to manage content.
- Firebase used initially as backend (Auth, Firestore, Storage), but with abstraction to allow future backend replacements (REST APIs, Supabase, etc.).
- Offline support with caching.

---

## 2. Overall Description
### 2.1 Product Perspective
The app acts as a digital portfolio for developers with a clean UI and modular backend.

### 2.2 Product Features
- Profile (CV, skills, experiences).
- Projects (list, details, links, screenshots).
- Contact info (phone, email, LinkedIn, GitHub).
- Theme customization (primary color).
- Dashboard for managing data.
- Offline cache.

### 2.3 Users
- **Developer (Owner)** → Full access to dashboard.
- **Public Visitors** → Read-only access to portfolio.

---

## 3. Functional Requirements
- User Authentication (Email/Password, extendable to Google login).
- Profile management (CRUD).
- Project management (CRUD).
- Contact information management (CRUD).
- Theme management (select color).
- Public portfolio viewing.

---

## 4. Non-Functional Requirements
- Performance: Fast loading, responsive UI.
- Reliability: Works offline with cache fallback.
- Scalability: Backend abstraction allows switching services.
- Security: Dashboard protected, Firestore rules ensure data ownership.
- Maintainability: Clean Architecture + Riverpod + Modular design.

---

## 5. External Interfaces
- Firebase (Auth, Firestore, Storage).
- Future: REST APIs (Dio + Retrofit).
- Firebase Analytics for event tracking.

---

## 6. Constraints
- Initial backend limited to Firebase free tier.
- Must run on mobile and web browsers.
- Limited to public read-only for visitors.

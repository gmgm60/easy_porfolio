# 📘 System Design Document (SDD)

## 1. Introduction
### 1.1 Purpose
This document describes the system design for the **Flutter Portfolio App for Developers**, covering architecture, data models, modules, APIs, security, and deployment.

### 1.2 Scope
- Cross-platform: **Mobile (iOS/Android) + Web (Flutter Web)**  
- Offline support with caching  
- Admin Panel (private dashboard)  
- Firebase as initial backend with abstraction layer for future backends (REST APIs)  

---

## 2. System Overview
The app consists of:
- **Flutter Client App (Mobile + Web)**  
- **Backend Services**: Firebase (Auth, Firestore, Storage) initially  
- **Storage Abstraction Layer**: Firebase / Cloudinary / Supabase  
- **Admin Panel (Flutter Web)** for managing content  

### 2.1 High-Level System Architecture

```
+-------------------+       +------------------+
|   Flutter Client  | <---> |   Repository     |
| (Mobile + Web)    |       | (Abstract Layer) |
+-------------------+       +------------------+
          |                          |
          v                          v
   +--------------+           +--------------+
   | Firebase     |           | REST Backend |
   | (Auth, DB,   |           | (Future)     |
   | Storage)     |           +--------------+
   +--------------+
```

---

## 3. Architecture Design
### 3.1 Clean Architecture Layers
- **Presentation Layer**: Flutter UI + GoRouter (with Auth Guard)  
- **Domain Layer**: Use Cases (business logic, pure Dart)  
- **Data Layer**:  
  - Repository Interfaces (abstracted)  
  - Implementations (Firebase / REST via Dio & Retrofit)  

### 3.2 State Management
- **Riverpod** for state management.  

### 3.3 Navigation
- **GoRouter** for routing and deep linking.  
- **Auth Guard** ensures dashboard access only for authenticated users.  

---

## 4. Modules
### 4.1 Profile Module
- Displays developer info, skills, CV.  

### 4.2 Projects Module
- List + details page (description, screenshots, links).  

### 4.3 Contact Module
- Displays contact methods (email, phone, LinkedIn, GitHub).  

### 4.4 Theme Module
- Allows user to pick a **primary color**.  

---

## 5. Data Model
### 5.1 Firestore Collections
- `profile` → personal info, skills, CV link.  
- `projects` → {title, description, screenshots[], links}.  
- `contact` → {email, phone, links}.  
- `theme` → {primaryColor}.  

### 5.2 ERD (ASCII)

```
+-----------+        +------------+
|  profile  |        |  projects  |
|-----------|        |------------|
| id        |<------>| ownerId    |
| name      |        | title      |
| bio       |        | desc       |
| skills[]  |        | screenshots[] 
| cvLink    |        | links{}    |
+-----------+        +------------+

+-----------+
|  contact  |
|-----------|
| id        |
| email     |
| phone     |
| links{}   |
+-----------+

+-----------+
|  theme    |
|-----------|
| id        |
| primaryColor |
+-----------+
```

---

## 6. APIs & Abstraction
- **REST API Contract** (Future-ready):  
  - `GET /profile`  
  - `PUT /profile`  
  - `GET /projects`  
  - `POST /projects`  
  - `GET /contact`  
  - `PUT /contact`  
- **Dio + Retrofit** used for networking.  
- Abstraction layer ensures easy backend replacement.  

---

## 7. Security
- **Auth**: Firebase Auth (Email/Password, Google OAuth in next phase).  
- **Authorization**: Public app, dashboard restricted.  
- **Firestore Rules**:  
  - `projects`: readable by all, writable by owner only.  
- **Secure Navigation**: GoRouter + Auth Guard.  

---

## 8. User Interface
### 8.1 Wireframes (ASCII)

**Main Navigation**

```
[Profile] --- [Projects] --- [Contact] --- [Theme]
     |               |              |
     v               v              v
 [Profile Page]   [Projects List]  [Contact Info]
                     |
                     v
              [Project Details]
```

**Dashboard Flow**

```
[Login Page] -> [Dashboard Home]
                      |
     --------------------------------
     |             |                |
 [Manage Profile] [Manage Projects] [Analytics View]
```

---

## 9. Data Flow
### 9.1 Sequence Diagram (Add Project)

```
User -> App: Add project details
App -> Repo: saveProject(project)
Repo -> Firebase: POST project
Firebase -> Repo: success
Repo -> App: project saved
App -> UI: show success + refresh project list
```

---

## 10. Testing Strategy
- **Phase 1**: Unit Tests (Domain & Data layers).  
- **Phase 2**: Widget Tests (UI).  
- **Phase 3**: Integration Tests (API + Offline mode).  

---

## 11. Deployment & DevOps
- **CI/CD**: Codemagic for builds + deployments.  
- **Environments**: dev, staging, production.  
- **Hosting**: Firebase Hosting (Web), Play Store, App Store.  

---

## 12. Analytics
### 12.1 Events to Track
- `app_opened`  
- `profile_viewed`  
- `project_viewed`  
- `contact_clicked` (email/phone/link)  
- `cv_downloaded`  
- `theme_changed`  
- `login_success`  
- `project_added` (from dashboard)  

### 12.2 Dashboard Reports
- Number of project views.  
- Contact clicks breakdown.  
- Most viewed projects.  
- CV download count.  

---

## 13. Future Enhancements
- Multi-user support.  
- Push notifications.  
- Advanced analytics.  
- API integrations (LinkedIn, GitHub).  
- Multi-language support.  

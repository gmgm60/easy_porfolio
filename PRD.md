# Product Requirements Document (PRD)

## 1. Introduction
- **App Name**: Flutter Portfolio App for Developers
- **Description**: A personal portfolio application (Web + Mobile) that allows developers to showcase their CV, projects, and contact details in a professional way, with customization options.

---

## 2. Product Goals
- Enable developers to present themselves professionally.
- Aggregate all information in one place (CV + Projects + Links).
- Support UI customization (primary color / theme).
- Easy sharing of the portfolio link with clients or recruiters.

---

## 3. Target Users
- Freelance developers.
- Developers seeking job opportunities.
- Small startups showcasing their developer teams.

---

## 4. Core Features
1. **Profile / CV**: Display developer info, experience, and skills.
2. **Projects**: Grid/list view with images, descriptions, and links (GitHub / Play Store / App Store).
3. **Contact**: Phone, email, LinkedIn, GitHub, personal website.
4. **Theme Customization**: Primary color selection.
5. **Dashboard**: Private admin panel for the developer to manage data.

---

## 5. Secondary Features (Future Scope)
- Blog / Articles page.
- Testimonials page.
- Push Notifications.
- Additional authentication methods (Google, GitHub OAuth).

---

## 6. Product Constraints
- All data belongs to the portfolio owner only.
- Limited offline cache (read-only).
- Public view for everyone, Dashboard restricted to the developer.

---

## 7. Acceptance Criteria
- Developer can log in using Email/Password.
- Developer can manage profile, projects, and contact info from the Dashboard.
- Public users can view profile and projects without login.
- Each project displays (thumbnail, title, description, links).
- Users can change primary color theme.

---

## 8. Success Metrics (KPIs)
- Number of portfolio views.
- Click-through rate on contact links.
- Average session duration.
- Number of projects added.

---

## 9. Analytics Events
- `app_opened`
- `profile_viewed`
- `project_viewed`
- `contact_clicked`
- `cv_downloaded`
- `theme_changed`
- `dashboard_login`

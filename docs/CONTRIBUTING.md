# Contributor Guidelines - ShinkaTrack

We welcome contributions to ShinkaTrack! To maintain high code quality, security, and performance, all contributors must follow these coding guidelines.

---

## 1. Coding Conventions

### 1.1 Flutter & Dart Standards
* **Formatting**: Always format your code using the official formatter before submitting (`flutter format .`).
* **Lints**: Ensure that no analyzer warnings exist. Run `flutter analyze` before committing.
* **Immutability**: UI models and data classes must be immutable. Use `@immutable` and `final` attributes for all parameters.
* **Const Constructors**: Prefer using `const` constructors on UI widgets to maximize rendering performance.

### 1.2 Naming Conventions
* **Classes & Types**: `UpperCamelCase` (e.g. `KanjiEntity`, `DeveloperOptionsScreen`).
* **Files & Folders**: `snake_case` (e.g. `admin_dashboard_screen.dart`, `study_providers.dart`).
* **Variables & Methods**: `lowerCamelCase` (e.g. `resetMasterDatabase()`, `obsurePassword`).
* **Private Members**: Prefix with a leading underscore (e.g. `_versionTapCount`).

---

## 2. Architecture & Design Rules

### 2.1 State Management (Riverpod)
* Do not use global state variables. All shared states must reside inside Riverpod providers.
* Prefer watching specific parameters (`ref.watch(provider.select(...))`) to prevent unnecessary widget rebuilds.
* Avoid async gaps inside build methods. Capture `ScaffoldMessenger.of(context)` before calling async wait functions.

### 2.2 Database (Drift)
* Schema updates must increment the version number in [database.dart](file:///e:/Web%20Development/Shin/lib/core/database/database.dart) and include non-destructive migrations.
* Never run unfiltered queries. Use indexed attributes for all search/filtering operations to preserve the 60 FPS scrolling target.
* Segregate mutable user data from static master database tables.

---

## 3. Pull Request (PR) Workflow
1. **Branch Naming**: Use descriptive prefixes (e.g., `feat/srs-scheduler`, `bugfix/migration-reads`).
2. **Local Verification**:
   * Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate mappings.
   * Run `flutter analyze` to ensure there are no lints or errors.
   * Run all tests: `flutter test`.
3. **Commit Messages**: Write concise, descriptive commit summaries (e.g., `feat: Implement developer options passcode gate`).

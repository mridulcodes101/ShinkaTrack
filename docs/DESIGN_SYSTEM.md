# Design System & UI/UX Guidelines - ShinkaTrack

ShinkaTrack uses a premium, Material 3-aligned design language. The system features a responsive layout, sleek animations, dynamic transitions, and modern HSL colors optimized for both Light and Dark themes.

---

## 1. Color Palettes

### 1.1 Color Tokens
The interface utilizes custom Color tokens defined under `PremiumDesignSystem` in the code:

* **Indigo Accent** (Primary Accent): `Color(0xFF3F51B5)`
* **Vibrant Blue** (Buttons & Chips): `Color(0xFF2196F3)`
* **Dark Slate** (Dark mode base background): `Color(0xFF121214)`
* **Deep Charcoal** (Dark mode card background): `Color(0xFF1E1E22)`
* **Pure Light** (Light mode base background): `Color(0xFFF8F9FA)`
* **Pure White** (Light mode card background): `Color(0xFFFFFFFF)`
* **Amber Gold** (Stars & Favorites): `Color(0xFFFFC107)`
* **Emerald Green** (Success states): `Color(0xFF4CAF50)`
* **Crimson Red** (Danger & Alert zones): `Color(0xFFF44336)`

---

## 2. Typography
We use **Inter** (via Google Fonts) as our primary typeface for high-readability and modern style. The typography scale complies with the following sizes:

| Token | Font Size | Weight | Line Height | Usage |
| :--- | :--- | :--- | :--- | :--- |
| **Display Large**| 48 sp | Bold (w800) | 1.1 | Large Kanji header displays |
| **Headline Medium**| 24 sp | Bold (w700) | 1.2 | Page title and section titles |
| **Title Medium** | 16 sp | Semi-Bold (w600) | 1.3 | Card titles, modal titles |
| **Body Medium** | 14 sp | Regular (w400) | 1.4 | Kanji meanings, explanations |
| **Label Small** | 11 sp | Medium (w500) | 1.2 | Badges, tags, and subtitle metadata |

---

## 3. Layout Grid & Spacing
Spacing units follow a strict **8dp grid system** for consistent alignment and screen balance:

* **spacing-xs**: 4dp (tight margins, internal badge padding)
* **spacing-sm**: 8dp (spacing between small components)
* **spacing-md**: 16dp (standard grid list margins, internal card padding)
* **spacing-lg**: 24dp (scaffold outer horizontal/vertical padding)
* **spacing-xl**: 32dp (spans between major content blocks)

---

## 4. Elevation & Radii

### 4.1 Elevation (Shadows)
ShinkaTrack uses flat Material 3-aligned elevations utilizing subtle color-tinted borders and overlays rather than deep drop shadows:
* **Level 0**: Flat surface (scaffold backgrounds).
* **Level 1**: Card surfaces. Custom borders with 1px thickness and a light opacity overlay (e.g., `.withValues(alpha: 0.05)`).
* **Level 2**: Active buttons, sliding panels, and pinned bottom sheets.

### 4.2 Radii (Rounded Corners)
* **radius-sm**: 8dp (tags, status chips, input text fields)
* **radius-md**: 16dp (card surfaces, action buttons)
* **radius-lg**: 24dp (dialog popups, bottom sheets)

---

## 5. UI Component Guidelines

### 5.1 Buttons
* **Primary Action Buttons**: Filled with primary theme colors and constructed with rounded borders (`radius-md`). Should exhibit micro-scale scaling animations when tapped.
* **Secondary Buttons**: Outlined styling. Minimum tap surface must measure at least 48x48dp.
* **FAB (Floating Action Buttons)**: Bottom right positioning. Follows tab context dynamically (e.g., showing collection add tools or dictionary edits based on login status).

### 5.2 Cards
* **Elevation**: Flat with custom border curves (`radius-md`).
* **Visual feedback**: Include high-responsiveness tap scaling effects and hover tint overlays to indicate selectability.

### 5.3 Dialogs
* **Backgrounds**: SurfaceContainerHighest opacity overlay matching light/dark modes.
* **Confirm actions**: Highlight danger buttons with clear red alert tones. Cancel buttons are always left-aligned or rendered as flat text buttons.

### 5.4 Bottom Sheets
* Pinned dynamic configurations that expand smoothly using slide transitions.
* Pinned bottom sheets should contain clear action triggers (e.g., collection additions on the Details page) with high readability.

### 5.5 Snackbars
* **Placement**: Floated slightly above the screen bottom (floating behavior).
* **Visuals**: Dark background colors with white text and color-themed indicators (green for success, red for errors).

### 5.6 Charts
* Standard circular rings or horizontal progress bar grids representing daily target progress (study seconds and reviewed item counts).
* Color-coded segments corresponding to the selected accent color.

---

## 6. Animations & Transitions
* **Hero Animations**: Smooth transitions of Kanji cards from lists to the details page, maintaining coordinate bounds of the large Kanji character.
* **Tap Gestures**: Linear scaling animations (`Transform.scale`) scaling elements down by 2-3% on touch down and bouncing back on touch release.
* **List Animation**: Items in lists should load with subtle vertical slide-in fade effects (`AnimatedSwitcher` or `ListView.builder` custom wrappers).

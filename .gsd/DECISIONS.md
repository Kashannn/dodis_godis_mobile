# ⚖️ Architecture Decision Records (ADRs)

This file documents critical architectural decisions, context, and their rationale.

---

## ADR-001: Mandate `AppCustomScaffold` with `safeBottom: true`

- **Status:** Accepted ✅
- **Date:** 2026-10-09
- **Context:**
  Modern iOS and Android devices feature gesture bars and rounded screen corners at the bottom. Standard `Scaffold` without carefully managed bottom padding causes critical controls (e.g. "Nästa fråga", rolling dice, category chips) to overlap with system home bars or trigger unintentional OS navigation gestures. Additionally, dismissing keyboards required boilerplate `GestureDetector` widgets in every screen.
- **Decision:**
  Create and mandate `AppCustomScaffold` across all screens under `lib/presentation/*/view/`. By default and in each view implementation, `safeBottom: true` must be maintained.
- **Consequences:**
  - Redundant nested `SafeArea` widgets in view bodies are eliminated.
  - Consistent background coloring across screens.
  - Tapping background automatically unfocuses text fields.
  - Consistent layout across devices of all aspect ratios.

---

## ADR-002: BLoC Pattern for Feature State Management

- **Status:** Accepted ✅
- **Date:** 2026-10-07
- **Context:**
  The mobile app has complex interactive multi-turn state (e.g. 5 dice holding logic in Yatzy, dynamic track positions in Dodis Game). Mixing state inside StatefulWidgets creates tight coupling and makes unit testing difficult.
- **Decision:**
  Adopt `flutter_bloc` with `Equatable` states and discrete event classes. Register Blocs as factories in `GetIt`.
- **Consequences:**
  - Clear separation between presentation widgets and game business logic.
  - Easily testable state transitions.

---

## ADR-003: GoRouter for Declarative Navigation

- **Status:** Accepted ✅
- **Date:** 2026-10-07
- **Context:**
  Future features include deep linking (QR code game joins) and TV casting handoffs. Standard Flutter Navigator 1.0 does not scale well with deep links.
- **Decision:**
  Use `go_router` (`14.8.1`) with a centralized `Routes` constant file and `AppRouter`.
- **Consequences:**
  - URL-style path navigation simplifies web deployment and QR scanning transitions.

---

## ADR-004: ScreenUtil for Responsive Pixel Scaling

- **Status:** Accepted ✅
- **Date:** 2026-10-07
- **Context:**
  Swedish board game artwork and circular wheel elements require fixed proportional layout across various Android and iOS screen widths.
- **Decision:**
  Use `flutter_screenutil` anchored at `393 x 852` design size.
- **Consequences:**
  - All spacing, fonts, and box sizes use `.w`, `.h`, `.r`, and `.sp`.

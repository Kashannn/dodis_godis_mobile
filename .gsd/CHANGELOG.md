# 📜 Changelog

All notable changes and architectural evolutions of the **Dodis Godis Mobile** project are documented here.

---

## [Unreleased]

### Planned
- Real-time multiplayer synchronization (WebSockets / Supabase Edge Functions).
- Local state persistence using `shared_preferences` for active game resumes.
- Sound effects and tactile haptic feedback during dice rolls.

---

## [1.0.0+1] - 2026-10-09

### Added
- **GSD (Get Stuff Done) Documentation System**: Created `.gsd/` with structured state tracking files (`README.md`, `STATE.md`, `FLOW.md`, `CHANGELOG.md`, `ROADMAP.md`, `ARCHITECTURE.md`, `DECISIONS.md`, `SERENA.md`).
- **Serena MCP Integration**:
  - Added `serena_config.yml` for Flutter/Dart language server & project indexing.
  - Added `.vscode/mcp.json` for IDE MCP tools.
  - Added `.agents/mcp.json` for agentic environments.
- **Unified Custom Scaffold Architecture**:
  - Implemented `AppCustomScaffold` (`lib/core/utils/app_custom_scaffold.dart`) featuring integrated `SafeArea`, customizable `safeBottom`, background color fallback, keyboard auto-unfocus, and app bar/drawer slots.

### Changed
- **Presentation Layer Migration**:
  - Replaced native `Scaffold` across all 7 presentation view screens with `AppCustomScaffold`:
    - `lib/presentation/home/view/home_view.dart`
    - `lib/presentation/yatzy/view/yatzy_view.dart`
    - `lib/presentation/splash/view/splash_view.dart`
    - `lib/presentation/online_play/view/online_play_view.dart`
    - `lib/presentation/date_cards/view/date_cards_view.dart`
    - `lib/presentation/dodis_game/view/dodis_game_view.dart`
    - `lib/presentation/rules/view/rules_view.dart`
  - Explicitly enforced `safeBottom: true` on all views to eliminate bottom navigation bar overlap on modern iOS & Android gesture bars.
  - Removed duplicate nested `SafeArea` widgets in view files to streamline the render tree.

### Fixed
- Fixed bottom padding clipping on home and rules screens when viewing on edge-to-edge screens.

---

## [0.1.0] - Initial Setup
- Initial Flutter project scaffolding with Clean Architecture structure.
- State management setup with `flutter_bloc`.
- Dependency injection container configured with `get_it`.
- Routing configuration using `go_router`.
- Responsive layout configuration using `flutter_screenutil`.

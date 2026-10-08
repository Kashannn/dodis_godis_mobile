# 📍 Project State

**App Name:** Dodis Godis Mobile (`dodis_godis`)  
**Platform:** Flutter (iOS & Android)  
**SDK Target:** Dart ^3.5.0, Flutter SDK  
**State Architecture:** BLoC (`flutter_bloc` 9.1.1, `bloc` 9.0.0)  
**Last Updated:** October 2026  
**Health Status:** 🟢 All views verified (`dart analyze` clean, 0 errors)

---

## 🎯 Current Milestone: Phase 1 — Core Offline Games & Presentation Standardization

### Implementation Status by Module

| Module / Screen | Route | BLoC / State Handler | Scaffold Standard | Status |
| :--- | :--- | :--- | :--- | :--- |
| **Splash Screen** | `/` | `SplashBloc` | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (Candy bag animation + entrance) |
| **Home Dashboard** | `/home` | `HomeBloc` | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (Categories, Hero banner, QR trigger) |
| **Dodis Game (Board)** | `/dodis-game` | `DodisGameBloc` | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (Wheel painter, dice roll, candy tracker) |
| **Yatzy** | `/yatzy` | `YatzyBloc` | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (Dice widget, hold toggles, protocol scoring) |
| **Date Cards** | `/date-cards` | `DateCardsBloc` | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (Category chips, card carousel, 18+ mode) |
| **Rules & Guides** | `/rules` | Local State (`_RulesViewState`) | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (Searchable filter, categorized expandable rules) |
| **Online Play / Cast** | `/online-play` | Local State (`_OnlinePlayViewState`) | `AppCustomScaffold` (`safeBottom: true`) | ✅ Complete (TV casting card, participant roster, camera toggle) |

---

## 🏗️ Core Infrastructure

- **Scaffold Standardization:** Unified all presentation screens onto `AppCustomScaffold` with `safeBottom: true`, eliminating device navigation bar clipping on edge-to-edge iOS/Android displays.
- **Dependency Injection:** Centralized via `get_it` in `lib/core/di/injection_container.dart` (`sl<T>()`).
- **Responsive Layout:** Powered by `flutter_screenutil` (Base design size: `393 x 852`).
- **Routing:** Handled declaratively with `go_router` (`14.8.1`).
- **MCP Integration:** Serena MCP server configuration and `.gsd` state files active.

---

## ⚠️ Known Blockers & Technical Debt

1. **Online Multiplayer Backend:** Currently, `OnlinePlayView` features UI mockups for room code and participants; real-time WebSocket / WebRTC / Supabase synchronization is pending.
2. **Audio / SFX:** Dice rolling and candy pickup lack haptic/audio feedback.
3. **Persisted State:** Game saves currently reset upon app closure; SharedPreferences integration for active game sessions is planned for next milestone.

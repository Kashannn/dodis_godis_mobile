# 🏛️ System Architecture

This document describes the architectural layout, patterns, and coding conventions of **Dodis Godis Mobile**.

---

## 🏗️ Clean Architecture Overview

The codebase is organized into layered Clean Architecture boundaries inside `lib/`:

```
lib/
├── app/
│   └── router/                # Route definitions & GoRouter configuration
├── core/
│   ├── constants/             # Design tokens: AppColors, AppStrings, AppStyles, AppImages
│   ├── di/                    # Dependency Injection via GetIt (injection_container.dart)
│   ├── services/              # Common utilities & services (e.g. SplashAnimationService)
│   └── utils/                 # AppCustomScaffold & reusable helper utilities
├── data/
│   ├── datasources/           # Local/remote data sources
│   ├── models/                # Serializable data models (GameCategoryModel, DateCardModel)
│   └── repositories/          # Repository implementations
├── domain/
│   ├── entities/              # Business entities
│   ├── repositories/          # Repository interfaces / contracts
│   └── usecases/              # Core business rules & use cases
└── presentation/
    ├── home/                  # Home dashboard (view, bloc, widgets)
    ├── dodis_game/            # Main Dodis Godis Board Game
    ├── yatzy/                 # Swedish Yatzy dice game
    ├── date_cards/            # Dejtkort & 18+ party cards
    ├── online_play/           # TV Casting & party participants
    ├── rules/                 # Searchable rulebook
    └── splash/                # Animated candy bag splash screen
```

---

## 🧩 Architectural Patterns

### 1. State Management: BLoC Pattern (`flutter_bloc`)
- Each feature folder contains a `bloc/` subfolder with three files:
  - `<feature>_event.dart`: Sealed or abstract event classes representing UI actions.
  - `<feature>_state.dart`: Immutable state classes (extending `Equatable`).
  - `<feature>_bloc.dart`: Event handler mutating and emitting states.
- Blocs are injected either via `BlocProvider(create: (context) => sl<FeatureBloc>())` or accessed via `context.read<FeatureBloc>()`.

### 2. Custom Scaffold Standard: `AppCustomScaffold`
- Every view screen must return `AppCustomScaffold` from `lib/core/utils/app_custom_scaffold.dart`.
- Features provided out-of-the-box:
  - **Integrated `SafeArea`**: Top, bottom, left, and right controllable via booleans (`safeBottom: true` required on all screens).
  - **Keyboard Auto-unfocus**: Dismisses open software keyboards when tapping outside input fields (`enableUnfocus: true`).
  - **Background Consistency**: Automatically applies `backgroundColor: kBackgroundColor` when set.
  - **Slots for System Widgets**: Fully supports `appBar`, `drawer`, `floatingActionButton`, `bottomNavigationBar`.

### 3. Dependency Injection: Service Locator (`get_it`)
- All singleton services and Bloc factories are registered inside `lib/core/di/injection_container.dart`.
- Blocs are registered as factories so each view instance receives a fresh state lifecycle:
  ```dart
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => YatzyBloc());
  sl.registerFactory(() => DodisGameBloc());
  sl.registerFactory(() => DateCardsBloc());
  ```

### 4. Responsive UI: `flutter_screenutil`
- Base resolution: **393 x 852** (iPhone 14/15/16 standard).
- Extension units used:
  - `.w`: Width scaling
  - `.h`: Height scaling
  - `.r`: Radius scaling
  - `.sp`: Font size scaling

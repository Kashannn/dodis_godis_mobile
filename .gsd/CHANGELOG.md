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

- **Dodis Game Visual & Gameplay Overhaul (`DodisGameView`)**:
  - Upgraded `PlayerRosterBar` to feature vibrant gradient capsule cards matching each player's chosen holder color (Blue, Orange, Purple, Green, Red, Yellow), displaying circular avatars, names, candy coin counts (`3`, `2`, `1`, `0`), and active turn glow.
  - Implemented high-resolution 3D circular board track with `BoardWheelPainter` and `GameBoardWidget`:
    - 24 glossy spherical candy tiles around the perimeter with milestone markers (Purple 'X', Red 'X', Golden stars).
    - 8-slice rainbow spinner center with golden rim and candy cane pointer.
    - Sculpted 3D board game pawns with radial gradients and ground shadows, rendered in each player's holder color on their respective `currentTile`.
  - Added `GameBottomControlsWidget` with a large pulsing circular 3D dice button and flanking chat & rules quick-access buttons (Screenshot 1).
  - Built `GameDiceRollOverlay` with active player card header, radiant sunburst aura, and "Tap to Roll Dice" button (Screenshot 2).
  - Built `GameTurnResultCardWidget` with 3D candy trophy icon, "You moved X steps! Collected 1 Candy" floating card, and green "Continue" action button (Screenshot 3).
  - Implemented `ChooseHolderBloc`, `ChooseHolderEvent`, and `ChooseHolderState` in `lib/presentation/create_join_party/bloc/` for managing active player selection and color cup holder assignments without `setState`.
  - Created `ChooseHolderScreen` (`lib/presentation/create_join_party/view/choose_holder_screen.dart`) matching the reference mockup UI:
    - 2-column dynamic grid of player cards displaying each player's 3D cartoon avatar, name, and colored ring matching their chosen holder cup color (e.g., Luna (Blue), Noah (Green), Sara (Orange), Omar (Purple)...).
    - Modular `HolderPlayerCardWidget` and `HolderColorPaletteWidget` with concentric halo rings for active swatch selection.
    - Full palette of 6 vibrant candy holder colors (`kHolderBlue`, `kHolderGreen`, `kHolderOrange`, `kHolderPurple`, `kHolderRed`, `kHolderYellow`) centralized in `app_colors.dart`.
    - Integrated reusable `TapToPlayButton` with green gradient and "Ready!" action text, passing the configured players with their chosen colors to `DodisGameView`.
  - Connected navigation flow: Tapping "Start Party" on `CreatePartyScreen` pushes `Routes.chooseHolder`, which leads to `DodisGameView` on pressing "Ready!".
- **High-End 3D Interactive Dice Roll Experience**:
  - Re-engineered 60fps 3D tumbling dice Lottie animation (`assets/LottieFiles/dice_roll.json`) with genuine 3D physics: high parabolic toss, 3D multi-axis tumbling, beveled chamfered resin edges, realistic double ground shadow scaling with height, impact squash, secondary bounce, and smooth resting ease.
  - Built an authentic **Casino Felt Rolling Arena Stage** with dynamic ambient radial gradients, pulsing active border, and tap indicators.
  - Implemented an **Isometric 3D Landed Resin Dice Cube** (`Isometric3DDicePainter`) with porcelain top face, beveled mid-tone & shadow side faces, specular diagonal sheen, and 3D embossed cherry candy pips.
  - Added physical **Landing Bounce & Squash** elastic animations (`_landController`) and 8-point **Celebration Sparkle Burst Particles** (`SparkleBurstPainter`) when the dice lands.
  - Synchronized dice rolling sound (`assets/sounds/Dice.mp3`) via `AudioService`.
- **How To Play Screen & Reusable App Bar**:
  - Generated fresh high-resolution 3D circular Dodis Godis wheel gameboard asset (`assets/images/how_to_play_board.png`) with clean alpha transparency.
  - Built reusable `AppCustomAppBar` (`lib/core/widgets/app_custom_app_bar.dart`) supporting preferred size, back chevron navigation, and bold comic typography for use across multiple screens.
  - Implemented `HowToPlayScreen` (`lib/presentation/rules/view/how_to_play_screen.dart`) featuring smooth floating board animations, 6 colored numbered rule cards with centralized strings, and reusable `TapToPlayButton` with green gradient.
  - Centralized all rule texts and assets in `app_strings.dart` and `app_images.dart`.
- **Single-Device Party Setup Screen & BLoC (`CreatePartyScreen`)**:
  - Implemented `CreatePartyBloc`, `CreatePartyEvent`, and `CreatePartyState` in `lib/presentation/create_join_party/bloc/` for reactive state management without `setState`.
  - Generated 6 high-resolution 3D cartoon player avatar images (`assets/images/player_avatar_1.png` to `player_avatar_6.png`) registered in `kPlayerAvatarList`.
  - Built `PartyPlayerNamesListWidget`: Dynamically renders 2–6 editable player input rows with player index numbers, cartoon avatars, editable names (e.g. "Kashan", "Arslan", "Saad", "Saqib"), host crown 👑 for Player 1, and clear button ✖ for other players.
  - Connected `PartyPlayerSelectorWidget` (2–6 players) to dynamically expand/trim the player roster in BLoC.
  - Seamlessly wired player data into `DodisGameBloc` via `SetPartyPlayersEvent`, displaying the custom names and cartoon avatars in the game's `PlayerRosterBar`.
  - Reusable green `TapToPlayButton` ("Start Party") passes configured players directly to `DodisGameView`.
- **Modular 3D Tap To Play Screen**:
  - Created brand new high-resolution 3D digital illustration assets via AI generation:
    - `assets/images/tap_screen_logo.png`: 3D bubble candy "DODIS GODIS" logo with festive sunburst celebration rays.
    - `assets/images/candy_mountain.png`: 3D assortment pile of Swedish sweets (striped peppermint, sugar-coated gumdrop, rainbow striped ball, sprinkled chocolate egg, jelly beans).
    - `assets/images/candy_bean_red.png`: 3D glossy red Swedish jelly bean.
    - `assets/images/candy_bean_yellow.png`: 3D translucent sunny golden jelly bean.
    - `assets/images/candy_bean_green.png`: 3D emerald sugar-crystal coated candy.
  - Implemented `TapToPlayScreen` (`lib/presentation/splash/view/tap_to _play_screen.dart`) featuring floating physics animations, breathing pulse, and hand-drawn comic typography ("The Sweetest Party Game!").
  - Extracted reusable `TapToPlayButton` widget (`lib/presentation/splash/widgets/tap_to_play_button.dart`) with customizable text, gradient colors, border color, text color, dimensions, and built-in bouncy tap micro-animations.
  - Updated navigation flow so `SplashView` seamlessly transitions to `TapToPlayScreen`, which on tap routes into `HomeView`.
- **GSD (Get Stuff Done) Documentation System**: Created `.gsd/` with structured state tracking files (`README.md`, `STATE.md`, `FLOW.md`, `CHANGELOG.md`, `ROADMAP.md`, `ARCHITECTURE.md`, `DECISIONS.md`, `SERENA.md`).
- **Serena MCP Integration**:
  - Added `serena_config.yml` for Flutter/Dart language server & project indexing.
  - Added `.vscode/mcp.json` for IDE MCP tools.
  - Added `.agents/mcp.json` for agentic environments.
- **Unified Custom Scaffold Architecture**:
  - Implemented `AppCustomScaffold` (`lib/core/utils/app_custom_scaffold.dart`) featuring integrated `SafeArea`, customizable `safeBottom`, background color fallback, keyboard auto-unfocus, and app bar/drawer slots.
  - Added edge-to-edge transparent system bars support via `AnnotatedRegion<SystemUiOverlayStyle>` with `systemNavigationBarColor: Colors.transparent`, `systemNavigationBarDividerColor: Colors.transparent`, and `systemNavigationBarContrastEnforced: false`.
  - Added `safeBottom` wrapping for `bottomNavigationBar` and `bottomSheet` so system navigation bar never covers bottom content.

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

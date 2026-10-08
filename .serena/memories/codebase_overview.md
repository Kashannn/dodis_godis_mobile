# Memory: Codebase Overview

**Project Name:** `dodis_godis_mobile`  
**Framework:** Flutter (Targeting iOS & Android)  
**Language:** Dart (^3.5.0)

---

## Screen & Feature Map

1. **Splash Screen (`lib/presentation/splash/`)**:
   - Animated candy bag entrance (`BagBackgroundPainter`, `SplashAnimationService`).
   - Driven by `SplashBloc`. Navigates to `/home`.

2. **Home Dashboard (`lib/presentation/home/`)**:
   - Category carousels, Hero banner ("Dodis Godis Spelet"), QR scanner trigger (`HomeHeaderWidget`), Party Banner.
   - Driven by `HomeBloc`.

3. **Dodis Godis Board Game (`lib/presentation/dodis_game/`)**:
   - Custom wheel painter (`BoardWheelPainter`), interactive 3D-styled dice roller (`DiceRollerWidget`), player roster bar, active challenge modal.
   - Driven by `DodisGameBloc`.

4. **Yatzy Game (`lib/presentation/yatzy/`)**:
   - 5-dice roller with toggleable hold states (`YatzyDiceWidget`).
   - Interactive Swedish Yatzy protocol scoring table (`YatzyProtocolTable`).
   - Driven by `YatzyBloc`.

5. **Date Cards (`lib/presentation/date_cards/`)**:
   - Category filtering (Icebreaker, Fun, Deep, 18+ Naughty mode).
   - Flip/shuffle card deck interface (`DateCardDisplay`).
   - Driven by `DateCardsBloc`.

6. **Online Play & Casting (`lib/presentation/online_play/`)**:
   - TV Mirroring switch, Room code generation, joined participant roster with drink tokens, camera toggle.

7. **Rulebook & Search (`lib/presentation/rules/`)**:
   - Searchable game rules for Dodis Godis Spelet, Yatzy, and party games (`RulesTileWidget`).

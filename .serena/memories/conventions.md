# Memory: Coding Conventions & Standards

## 1. Scaffold Requirement
- **MANDATORY:** Every view screen under `lib/presentation/*/view/` MUST use `AppCustomScaffold` (`lib/core/utils/app_custom_scaffold.dart`).
- Always keep `safeBottom: true` to avoid gesture bar overlap on iOS and Android.
- Do NOT nest additional `SafeArea` widgets inside the body unless explicitly overriding safe padding.
- `AppCustomScaffold` automatically provides tap-to-unfocus for text inputs (`enableUnfocus: true`).

## 2. Responsive Units
- Always use `flutter_screenutil` units:
  - Width: `.w`
  - Height: `.h`
  - Radius: `.r`
  - Text size: `.sp`
- Base design size is anchored at `393 x 852`.

## 3. Colors & Theming
- Do not hardcode magic hex colors in presentation widgets.
- Use `AppColors` tokens: `kBackgroundColor`, `kWhite`, `kCandyPink`, `kCandyYellow`, `kCandyRed`, `kCandyBlue`, `kBorderColor`, `kPrimaryTextColor`, etc.

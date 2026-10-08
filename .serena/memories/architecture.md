# Memory: Architecture & Patterns

## Clean Architecture Layers

- **`lib/core/`**:
  - `constants/`: `AppColors`, `AppStrings`, `AppStyles`, `AppImages`.
  - `di/`: `injection_container.dart` initializes `GetIt` (`sl`).
  - `utils/`: `AppCustomScaffold.dart`.
- **`lib/data/`**: Models (`GameCategoryModel`, `DateCardModel`), repositories, local storage.
- **`lib/domain/`**: Business entities and usecases.
- **`lib/presentation/`**: Feature-first folders containing `view/`, `bloc/`, and `widgets/`.
- **`lib/app/router/`**: `GoRouter` declarative navigation configuration.

## State Management Standard

- Use `flutter_bloc` with `Equatable`.
- Each feature has:
  - `*_event.dart`
  - `*_state.dart`
  - `*_bloc.dart`
- Blocs are registered in `lib/core/di/injection_container.dart` as factories.
- Views use `BlocProvider` or `BlocConsumer`/`BlocBuilder`.

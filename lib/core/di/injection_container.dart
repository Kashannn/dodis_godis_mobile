import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/date_cards/bloc/date_cards_bloc.dart';
import '../../presentation/dodis_game/bloc/dodis_game_bloc.dart';
import '../../presentation/home/bloc/home_bloc.dart';
import '../../presentation/yatzy/bloc/yatzy_bloc.dart';

import '../services/splash_animation_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── 1. Local Storage (Async Init) ──
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ── 2. Services & DataSources ──
  sl.registerFactory<SplashAnimationService>(() => SplashAnimationService());

  // ── 3. Repositories ──

  // ── 4. Use Cases ──

  // ── 5. BLoCs ──
  sl.registerFactory<HomeBloc>(() => HomeBloc());
  sl.registerFactory<DodisGameBloc>(() => DodisGameBloc());
  sl.registerFactory<YatzyBloc>(() => YatzyBloc());
  sl.registerFactory<DateCardsBloc>(() => DateCardsBloc());
}

import 'package:go_router/go_router.dart';

import '../../presentation/date_cards/view/date_cards_view.dart';
import '../../presentation/dodis_game/view/dodis_game_view.dart';
import '../../presentation/home/view/home_view.dart';
import '../../presentation/online_play/view/online_play_view.dart';
import '../../presentation/rules/view/rules_view.dart';
import '../../presentation/splash/view/splash_view.dart';
import '../../presentation/yatzy/view/yatzy_view.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static final AppRouter _instance = AppRouter._();

  factory AppRouter() => _instance;

  late final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: SplashView()),
      ),
      GoRoute(
        path: Routes.home,
        name: Routes.home,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: HomeView()),
      ),
      GoRoute(
        path: Routes.dodisGame,
        name: Routes.dodisGame,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: DodisGameView()),
      ),
      GoRoute(
        path: Routes.yatzy,
        name: Routes.yatzy,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: YatzyView()),
      ),
      GoRoute(
        path: Routes.dateCards,
        name: Routes.dateCards,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: DateCardsView()),
      ),
      GoRoute(
        path: Routes.rules,
        name: Routes.rules,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: RulesView()),
      ),
      GoRoute(
        path: Routes.onlinePlay,
        name: Routes.onlinePlay,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: OnlinePlayView()),
      ),
    ],
  );
}

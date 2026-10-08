import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/services/splash_animation_service.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import '../widgets/bag_background_painter.dart';
import '../widgets/candy_floating_item.dart';
import '../widgets/splash_bottom_banner.dart';
import '../widgets/splash_headline.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const SplashStarted()),
      child: const _SplashViewBody(),
    );
  }
}

class _SplashViewBody extends StatefulWidget {
  const _SplashViewBody();

  @override
  State<_SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<_SplashViewBody>
    with TickerProviderStateMixin {
  late final SplashAnimationService _animService;

  @override
  void initState() {
    super.initState();

    // Initialize animation service from core/services
    _animService = sl<SplashAnimationService>();
    _animService.initialize(this);
    _animService.startEntrance();
  }

  void _goToHome() {
    context.read<SplashBloc>().add(const SplashCompleted());
  }

  @override
  void dispose() {
    _animService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.readyToNavigate) {
          context.go(Routes.home);
        }
      },
      child: AppCustomScaffold(
        backgroundColor: const Color(0xFFFF7B9B),
        safeBottom: true,
        body: GestureDetector(
          onTap: _goToHome,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Custom Painted Candy Bag Background (Pink Foil + Crimp + Blue Window + Rainbow)
              const Positioned.fill(
                child: CustomPaint(
                  painter: BagBackgroundPainter(),
                ),
              ),

              // 2. Proportional Responsive Layout of Individual Elements
              LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final h = constraints.maxHeight;

                  return Stack(
                    children: [
                      // Swedish Flag Sticker (Top Left)
                      Positioned(
                        top: h * 0.048,
                        left: w * 0.05,
                        width: w * 0.18,
                        child: FadeTransition(
                          opacity: _animService.logoFade,
                          child: Transform.rotate(
                            angle: -0.05,
                            child: Image.asset(
                              kSwedishFlag,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // DODIS GODIS 3D Gummy Candy Logo (Top Center)
                      Positioned(
                        top: h * 0.088,
                        left: w * 0.08,
                        right: w * 0.08,
                        child: ScaleTransition(
                          scale: _animService.logoScale,
                          child: FadeTransition(
                            opacity: _animService.logoFade,
                            child: CandyFloatingItem(
                              animation: _animService.floatController,
                              floatDelta: 4.0,
                              rotationDelta: 0.015,
                              phaseOffset: 0.0,
                              child: Image.asset(
                                kDodisLogo,
                                fit: BoxFit.contain,
                                height: h * 0.16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Headline Text: "CONTAINS +50 GAMES / Made entirely of candy"
                      Positioned(
                        top: h * 0.255,
                        left: w * 0.07,
                        width: w * 0.46,
                        child: FadeTransition(
                          opacity: _animService.contentFade,
                          child: const SplashHeadline(),
                        ),
                      ),

                      // Candy Dice Cluster (Upper Right)
                      Positioned(
                        top: h * 0.235,
                        right: w * 0.04,
                        width: w * 0.38,
                        child: ScaleTransition(
                          scale: _animService.gamesScale,
                          child: CandyFloatingItem(
                            animation: _animService.floatController,
                            floatDelta: 5.0,
                            rotationDelta: 0.03,
                            phaseOffset: 0.25,
                            child: Image.asset(
                              kCandyDice,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Wooden Backgammon Board (Mid Right)
                      Positioned(
                        top: h * 0.39,
                        right: w * 0.03,
                        width: w * 0.44,
                        child: ScaleTransition(
                          scale: _animService.gamesScale,
                          child: CandyFloatingItem(
                            animation: _animService.floatController,
                            floatDelta: 5.5,
                            rotationDelta: -0.025,
                            phaseOffset: 0.5,
                            child: Image.asset(
                              kBackgammonBoard,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Yellow Smiley Face + Candy + Pawn (Bottom Left)
                      Positioned(
                        bottom: h * 0.175,
                        left: w * 0.04,
                        width: w * 0.35,
                        child: ScaleTransition(
                          scale: _animService.gamesScale,
                          child: CandyFloatingItem(
                            animation: _animService.floatController,
                            floatDelta: 6.0,
                            rotationDelta: 0.04,
                            phaseOffset: 0.75,
                            child: Image.asset(
                              kSmileyCandy,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Black Peg Board Game (Bottom Center)
                      Positioned(
                        bottom: h * 0.18,
                        left: w * 0.38,
                        width: w * 0.31,
                        child: ScaleTransition(
                          scale: _animService.gamesScale,
                          child: CandyFloatingItem(
                            animation: _animService.floatController,
                            floatDelta: 4.5,
                            rotationDelta: -0.02,
                            phaseOffset: 0.1,
                            child: Image.asset(
                              kPegBoard,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Tic-Tac-Toe Candy Ropes (Bottom Right)
                      Positioned(
                        bottom: h * 0.175,
                        right: w * 0.03,
                        width: w * 0.32,
                        child: ScaleTransition(
                          scale: _animService.gamesScale,
                          child: CandyFloatingItem(
                            animation: _animService.floatController,
                            floatDelta: 6.0,
                            rotationDelta: 0.03,
                            phaseOffset: 0.4,
                            child: Image.asset(
                              kTicTacToeCandy,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Bottom Packaging Banner & Interactive Button
                      Positioned(
                        bottom: h * 0.03,
                        left: 0,
                        right: 0,
                        child: FadeTransition(
                          opacity: _animService.contentFade,
                          child: SplashBottomBanner(
                            onTap: _goToHome,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

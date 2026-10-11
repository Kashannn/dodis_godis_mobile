import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/router/routes.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../data/models/board_tile_model.dart';
import '../../splash/widgets/tap_to_play_button.dart';
import '../bloc/dodis_game_bloc.dart';
import '../bloc/dodis_game_event.dart';
import '../bloc/dodis_game_state.dart';
import '../widgets/active_challenge_modal.dart';
import '../widgets/game_board_widget.dart';
import '../widgets/game_bottom_controls_widget.dart';
import '../widgets/game_dice_roll_overlay.dart';
import '../widgets/game_turn_result_card_widget.dart';
import '../widgets/player_roster_bar.dart';
import 'challenge_result_screen.dart';
import 'game_winner_screen.dart';

class DodisGameView extends StatelessWidget {
  final List<GamePlayer>? initialPlayers;

  const DodisGameView({super.key, this.initialPlayers});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<DodisGameBloc>();
        if (initialPlayers != null && initialPlayers!.isNotEmpty) {
          bloc.add(SetPartyPlayersEvent(initialPlayers!));
        }
        return bloc;
      },
      child: const _DodisGameContent(),
    );
  }
}

class _DodisGameContent extends StatefulWidget {
  const _DodisGameContent();

  @override
  State<_DodisGameContent> createState() => _DodisGameContentState();
}

class _DodisGameContentState extends State<_DodisGameContent> {
  bool _showRollOverlay = false;

  void _onRollTapped(BuildContext context) {
    context.read<DodisGameBloc>().add(const RollDiceEvent());
  }

  void _showAddPlayerDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          kAddPlayerTitle,
          style: GoogleFonts.comicNeue(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: kPlayerNameHint,
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              kCancel,
              style: GoogleFonts.comicNeue(fontSize: 16.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context
                    .read<DodisGameBloc>()
                    .add(AddPlayerEvent(controller.text.trim()));
              }
              Navigator.pop(ctx);
            },
            child: Text(
              kAdd,
              style: GoogleFonts.comicNeue(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChallengeDetailsModal(
    BuildContext context,
    DodisGameState state,
  ) {
    if (state.currentChallenge == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: ActiveChallengeModal(
          challenge: state.currentChallenge!,
          allPlayers: state.players,
          currentPlayer: state.currentPlayer,
          selectedOpponent: state.selectedOpponent,
          onSelectOpponent: (opp) {
            context.read<DodisGameBloc>().add(SelectOpponentEvent(opp));
          },
          onCompleteChallenge: (win) {
            Navigator.pop(ctx);
            context
                .read<DodisGameBloc>()
                .add(CompleteChallengeEvent(didWin: win));
            if (win) {
              _showChallengeSuccessScreen(
                context,
                state.currentPlayer.name,
                int.tryParse(state.currentChallenge?.candyReward ?? '1') ?? 1,
              );
            } else {
              context.read<DodisGameBloc>().add(const NextTurnEvent());
            }
          },
        ),
      ),
    );
  }

  void _showChallengeSuccessScreen(
    BuildContext context,
    String playerName,
    int candiesWon,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChallengeResultScreen(
          playerName: playerName,
          candiesWon: candiesWon,
          onContinue: () {
            Navigator.of(context).pop();
            context.read<DodisGameBloc>().add(const NextTurnEvent());
          },
        ),
      ),
    );
  }

  void _showWinnerScreen(BuildContext context, DodisGameState state) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameWinnerScreen(
          winnerName: state.currentPlayer.name,
          onPlayAgain: () {
            Navigator.of(context).pop();
            context.read<DodisGameBloc>().add(const ResetGameEvent());
          },
          onMainMenu: () {
            Navigator.of(context).pop();
            context.go(Routes.home);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DodisGameBloc, DodisGameState>(
      listener: (context, state) {
        if (state.status == DodisGameStatus.gameOver) {
          _showWinnerScreen(context, state);
        }
        if (state.lastLandedTile?.type == BoardTileType.kastaOm &&
            state.status == DodisGameStatus.waitingForRoll) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '🎲 Kasta Om! ${state.currentPlayer.name} gets a free extra roll!',
                style: GoogleFonts.comicNeue(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFFFF5722),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        if (state.status == DodisGameStatus.challengeActive &&
            _showRollOverlay) {
          setState(() => _showRollOverlay = false);
        }
      },
      builder: (context, state) {
        final isChallengeState =
            state.status == DodisGameStatus.challengeActive ||
                state.status == DodisGameStatus.challengeResolved;

        return AppCustomScaffold(
          backgroundColor: const Color(0xFFFFF8E7),
          safeBottom: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE1F5FE),
                  Color(0xFFFFF9E6),
                  Color(0xFFFDEAC9),
                ],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // 1. Main Game Board & UI
                  Column(
                    children: [
                      // Top Utility Bar (Back & Rules)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 4.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (Navigator.of(context).canPop()) {
                                  Navigator.of(context).pop();
                                } else {
                                  context.go(Routes.home);
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: const Color(0xFF1E293B),
                                  size: 18.sp,
                                ),
                              ),
                            ),
                            Image.asset(
                              kTapScreenLogo,
                             // width: 365.w,
                              height: 100.h,
                              fit: BoxFit.contain,
                            ),
                            GestureDetector(
                              onTap: () => context.push(Routes.rules),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.help_outline_rounded,
                                  color: const Color(0xFF1E293B),
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 2. Dynamic Top Header:
                      // If just moved: Show "You moved 4 steps! Collected 1 Candy" card (Screenshot 3)
                      // Otherwise: Show the Player Roster capsules (Screenshot 1)
                      if (isChallengeState)
                        GestureDetector(
                          onTap: () {
                            if (state.currentChallenge != null) {
                              _showChallengeDetailsModal(context, state);
                            }
                          },
                          child: GameTurnResultCardWidget(
                            player: state.currentPlayer,
                            stepsMoved: state.lastDiceRoll,
                            challenge: state.currentChallenge,
                            landedTile: state.lastLandedTile,
                            onContinue: () {
                              if (state.currentChallenge != null) {
                                context.read<DodisGameBloc>().add(
                                      const CompleteChallengeEvent(
                                        didWin: true,
                                      ),
                                    );
                              }
                              context
                                  .read<DodisGameBloc>()
                                  .add(const NextTurnEvent());
                            },
                          ),
                        )
                      else
                        PlayerRosterBar(
                          players: state.players,
                          currentPlayerIndex: state.currentPlayerIndex,
                          onAddPlayer: () => _showAddPlayerDialog(context),
                        ),

                      const Spacer(),

                      // 3. Central Game Board with 24 Candy Nodes, Spinner & 3D Pawns
                      GameBoardWidget(
                        activeTile: state.currentPlayer.currentTile,
                        players: state.players,
                        currentPlayerIndex: state.currentPlayerIndex,
                        boardTiles: state.boardTiles,
                      ),

                      const Spacer(),

                      // 4. Bottom Controls:
                      // If challenge active: "Start Challenge" opens Duel Modal
                      // If candy resolved: "Continue" moves to next player
                      // Otherwise: Circular 3D Dice Button
                      if (isChallengeState)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 14.h,
                          ),
                          child: TapToPlayButton(
                            text: state.currentChallenge != null
                                ? 'Start Challenge'
                                : 'Continue',
                            width: 320.w,
                            height: 60.h,
                            fontSize: 24.sp,
                            gradientColors: const [
                              Color(0xFF45D461),
                              Color(0xFF28B744),
                              Color(0xFF1A9331),
                            ],
                            borderColor: const Color(0xFF116522),
                            textColor: Colors.white,
                            onPressed: () {
                              if (state.currentChallenge != null) {
                                _showChallengeDetailsModal(context, state);
                              } else {
                                context
                                    .read<DodisGameBloc>()
                                    .add(const NextTurnEvent());
                              }
                            },
                          ),
                        )
                      else
                        GameBottomControlsWidget(
                          isRolling: state.isRollingDice,
                          diceValue: state.lastDiceRoll,
                          onRoll: () => _onRollTapped(context),
                          onChat: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '🍬 ${state.currentPlayer.name}’s turn to roll!',
                                  style: GoogleFonts.comicNeue(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          onRules: () => context.push(Routes.rules),
                        ),
                    ],
                  ),

                  // 5. Cinematic Dice Roll Modal Overlay (Screenshot 2)
                  if (_showRollOverlay)
                    GameDiceRollOverlay(
                      currentPlayer: state.currentPlayer,
                      allPlayers: state.players,
                      currentPlayerIndex: state.currentPlayerIndex,
                      diceValue: state.lastDiceRoll,
                      isRolling: state.isRollingDice,
                      onRoll: () => _onRollTapped(context),
                      onClose: () => setState(() => _showRollOverlay = false),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

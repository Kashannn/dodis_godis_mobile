import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../bloc/dodis_game_bloc.dart';
import '../bloc/dodis_game_event.dart';
import '../bloc/dodis_game_state.dart';
import '../widgets/active_challenge_modal.dart';
import '../widgets/board_wheel_painter.dart';
import '../widgets/dice_roller_widget.dart';
import '../widgets/player_roster_bar.dart';

class DodisGameView extends StatelessWidget {
  const DodisGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DodisGameBloc>(),
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
  bool _showBoardMap = false;

  void _showAddPlayerDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          kAddPlayerTitle,
          style: kHeadingSmall,
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
            child: Text(kCancel, style: kBodyMedium),
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
            child: Text(kAdd, style: kButtonSmallStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          kDodisGameTitle,
          style: kHeadingSmall.copyWith(fontSize: 17.sp),
        ),
        actions: [
          IconButton(
            tooltip: 'Visa spelplan',
            icon: Icon(
              _showBoardMap ? Icons.casino_rounded : Icons.map_rounded,
              color: kCandyBlue,
            ),
            onPressed: () {
              setState(() {
                _showBoardMap = !_showBoardMap;
              });
            },
          ),
          IconButton(
            tooltip: kRules,
            icon: const Icon(Icons.info_outline_rounded, color: kPrimaryTextColor),
            onPressed: () => context.push(Routes.rules),
          ),
        ],
      ),
      body: BlocConsumer<DodisGameBloc, DodisGameState>(
          listener: (context, state) {
            if (state.status == DodisGameStatus.gameOver) {
              _showGameOverDialog(context, state);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  // 1. Player Roster Bar
                  PlayerRosterBar(
                    players: state.players,
                    currentPlayerIndex: state.currentPlayerIndex,
                    onAddPlayer: () => _showAddPlayerDialog(context),
                  ),
                  SizedBox(height: 14.h),

                  // 2. Status message banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: kBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.campaign_rounded, color: kCandyYellow, size: 22.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            state.message,
                            style: kHeadingSmall.copyWith(fontSize: 12.5.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // 3. Middle Area: Circular Board View OR Dice Roller
                  if (_showBoardMap) ...[
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: kBorderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kBoardFront,
                                style: kHeadingSmall.copyWith(fontSize: 13.sp),
                              ),
                              Text(
                                '$kTilePrefix${state.currentPlayer.currentTile + 1} / 24',
                                style: kHeadingSmall.copyWith(
                                  fontSize: 12.sp,
                                  color: kCandyRed,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 260.w,
                            height: 260.w,
                            child: CustomPaint(
                              painter: BoardWheelPainter(
                                activeTile: state.currentPlayer.currentTile,
                                playerPositions:
                                    state.players.map((p) => p.currentTile).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ] else ...[
                    DiceRollerWidget(
                      diceValue: state.lastDiceRoll,
                      isRolling: state.isRollingDice,
                      onRoll: () {
                        context.read<DodisGameBloc>().add(const RollDiceEvent());
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // 4. Active Challenge or Next Turn Action
                  if (state.currentChallenge != null &&
                      state.status == DodisGameStatus.challengeActive) ...[
                    ActiveChallengeModal(
                      challenge: state.currentChallenge!,
                      allPlayers: state.players,
                      currentPlayer: state.currentPlayer,
                      selectedOpponent: state.selectedOpponent,
                      onSelectOpponent: (opp) {
                        context
                            .read<DodisGameBloc>()
                            .add(SelectOpponentEvent(opp));
                      },
                      onCompleteChallenge: (win) {
                        context
                            .read<DodisGameBloc>()
                            .add(CompleteChallengeEvent(didWin: win));
                      },
                    ),
                  ] else if (state.status == DodisGameStatus.challengeResolved) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: kCandyGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(color: kCandyGreen.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            kRoundFinished,
                            style: kHeadingSmall.copyWith(
                              fontSize: 15.sp,
                              color: kCandyGreen,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '$kRemainingInBagPrefix${state.totalCandiesInBag}$kCandiesSuffix',
                            style: kBodyMedium.copyWith(color: kPrimaryTextColor),
                          ),
                          SizedBox(height: 12.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<DodisGameBloc>().add(const NextTurnEvent());
                            },
                            icon: const Icon(Icons.arrow_forward_rounded, color: kWhite),
                            label: Text(
                              kNextTurnAction,
                              style: kButtonSmallStyle.copyWith(fontSize: 13.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kCandyGreen,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 12.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
    );
  }

  void _showGameOverDialog(BuildContext context, DodisGameState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
        title: Text(
          kGameOverTitle,
          style: kHeadingMedium,
        ),
        content: Text(
          'The last candy has been collected from the bag! ${state.currentPlayer.name} claimed the final piece and wins the game!',
          style: kBodyMedium.copyWith(color: kPrimaryTextColor),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<DodisGameBloc>().add(const ResetGameEvent());
            },
            child: Text(kPlayAgain, style: kButtonSmallStyle),
          ),
        ],
      ),
    );
  }
}

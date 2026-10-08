import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../bloc/yatzy_bloc.dart';
import '../bloc/yatzy_event.dart';
import '../bloc/yatzy_state.dart';
import '../widgets/yatzy_dice_widget.dart';
import '../widgets/yatzy_protocol_table.dart';

class YatzyView extends StatelessWidget {
  const YatzyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<YatzyBloc>(),
      child: const _YatzyViewContent(),
    );
  }
}

class _YatzyViewContent extends StatelessWidget {
  const _YatzyViewContent();

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          kYatzyTitle,
          style: kHeadingSmall.copyWith(fontSize: 17.sp),
        ),
        actions: [
          IconButton(
            tooltip: 'Starta om',
            icon: const Icon(Icons.refresh_rounded, color: kPrimaryTextColor),
            onPressed: () {
              context.read<YatzyBloc>().add(const ResetYatzyGameEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<YatzyBloc, YatzyState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  // Candy prize banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: kCandyYellow.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: kCandyYellow.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.stars_rounded, color: const Color(0xFFD35400), size: 22.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            kYatzyCandyPrize,
                            style: kHeroBadgeStyle.copyWith(
                              fontSize: 12.sp,
                              color: const Color(0xFF964B00),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Current Turn & Instruction
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: kCandyRed,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            state.currentPlayer.name,
                            style: kMiniBadgeStyle.copyWith(color: kWhite),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            state.message,
                            style: kBodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // 5 Dice Interactive Widget
                  YatzyDiceWidget(
                    dice: state.dice,
                    heldDice: state.heldDice,
                    rollsRemaining: state.rollsRemaining,
                    isRolling: state.isRolling,
                    onToggleHold: (index) {
                      context.read<YatzyBloc>().add(ToggleHoldDieEvent(index));
                    },
                    onRoll: () {
                      context.read<YatzyBloc>().add(const RollYatzyDiceEvent());
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Yatzy Score Protocol Table
                  YatzyProtocolTable(
                    players: state.players,
                    currentPlayerIndex: state.currentPlayerIndex,
                    onRecordScore: (catId) {
                      context.read<YatzyBloc>().add(RecordScoreEvent(catId));
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
    );
  }
}

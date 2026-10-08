import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_custom_scaffold.dart';
import '../../../data/models/date_card_model.dart';
import '../bloc/date_cards_bloc.dart';
import '../bloc/date_cards_event.dart';
import '../bloc/date_cards_state.dart';
import '../widgets/date_card_display.dart';

class DateCardsView extends StatelessWidget {
  const DateCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DateCardsBloc>(),
      child: const _DateCardsViewContent(),
    );
  }
}

class _DateCardsViewContent extends StatelessWidget {
  const _DateCardsViewContent();

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      backgroundColor: kBackgroundColor,
      safeBottom: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          kDateCardsTitle,
          style: kHeadingSmall.copyWith(fontSize: 17.sp),
        ),
      ),
      body: BlocBuilder<DateCardsBloc, DateCardsState>(
          builder: (context, state) {
            final card = state.currentCard;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                children: [
                  // Category selector tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _categoryTab(
                          context,
                          kTabIcebreaker,
                          DateCardCategory.icebreaker,
                          state.currentCategory,
                        ),
                        SizedBox(width: 8.w),
                        _categoryTab(
                          context,
                          kTabFun,
                          DateCardCategory.fun,
                          state.currentCategory,
                        ),
                        SizedBox(width: 8.w),
                        _categoryTab(
                          context,
                          kTabDeep,
                          DateCardCategory.deep,
                          state.currentCategory,
                        ),
                        SizedBox(width: 8.w),
                        _categoryTab(
                          context,
                          kTabNaughty,
                          DateCardCategory.naughty18,
                          state.currentCategory,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Active Card
                  Expanded(
                    child: card == null
                        ? Center(child: Text(kNoCardsAvailable, style: kBodyMedium))
                        : DateCardDisplay(card: card),
                  ),
                  SizedBox(height: 20.h),

                  // Bottom Controls
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: () {
                          context
                              .read<DateCardsBloc>()
                              .add(const PreviousCardEvent());
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.all(14.w),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<DateCardsBloc>()
                                .add(const NextCardEvent());
                          },
                          icon: const Icon(Icons.shuffle_rounded, color: kWhite),
                          label: Text(
                            kNextQuestion,
                            style: kButtonMediumStyle.copyWith(fontSize: 15.sp),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.currentCategory ==
                                    DateCardCategory.naughty18
                                ? kShotModeColor
                                : kCandyPink,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            );
          },
        ),
    );
  }

  Widget _categoryTab(
    BuildContext context,
    String label,
    DateCardCategory category,
    DateCardCategory currentCategory,
  ) {
    final isSelected = category == currentCategory;
    final isNaughty = category == DateCardCategory.naughty18;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: isNaughty
          ? kShotModeColor.withValues(alpha: 0.2)
          : kCandyPink.withValues(alpha: 0.2),
      labelStyle: kChipTextStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected
            ? (isNaughty ? kShotModeColor : kCandyPink)
            : kPrimaryTextColor,
      ),
      onSelected: (_) {
        context.read<DateCardsBloc>().add(ChangeCategoryEvent(category));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../data/models/yatzy_score_model.dart';

class YatzyProtocolTable extends StatelessWidget {
  final List<YatzyPlayer> players;
  final int currentPlayerIndex;
  final void Function(String categoryId) onRecordScore;

  const YatzyProtocolTable({
    super.key,
    required this.players,
    required this.currentPlayerIndex,
    required this.onRecordScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C54),
              borderRadius: BorderRadius.vertical(top: Radius.circular(17.r)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    kYatzyProtocolTitle,
                    style: kProtocolHeaderStyle,
                  ),
                ),
                ...players.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final player = entry.value;
                  final isCurrent = idx == currentPlayerIndex;
                  return Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        player.name,
                        style: kProtocolHeaderStyle.copyWith(
                          fontSize: 11.sp,
                          fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                          color: isCurrent ? kCandyYellow : kWhite,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Upper Categories
          ...YatzyCategory.upperCategories.map((cat) => _buildRow(cat)),

          // Upper Sum & Bonus
          _buildCalculationRow(
            kUpperSumLabel,
            (p) => '${p.upperSectionSum}',
            isBold: true,
          ),
          _buildCalculationRow(
            kBonusLabel,
            (p) => '${p.bonus}',
            highlight: true,
          ),

          // Divider
          Container(height: 2, color: kBorderColor),

          // Lower Categories
          ...YatzyCategory.lowerCategories.map((cat) => _buildRow(cat)),

          // Divider
          Container(height: 2, color: kBorderColor),

          // Grand Total
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: kCandyYellow.withValues(alpha: 0.15),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(17.r)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    kTotalLabel,
                    style: kProtocolTotalLabelStyle,
                  ),
                ),
                ...players.map((p) {
                  return Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '${p.totalScore} p',
                        style: kProtocolTotalLabelStyle,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(YatzyCategory cat) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kBorderColor, width: 0.8)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                cat.label,
                style: kProtocolRowLabelStyle,
              ),
            ),
            ...players.asMap().entries.map((entry) {
              final idx = entry.key;
              final player = entry.value;
              final score = player.scores[cat.id];
              final isCurrent = idx == currentPlayerIndex;

              if (score != null) {
                return Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      '$score',
                      style: kProtocolScoreStyle,
                    ),
                  ),
                );
              }

              if (isCurrent) {
                return Expanded(
                  flex: 2,
                  child: Center(
                    child: InkWell(
                      onTap: () => onRecordScore(cat.id),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: kCandyRed.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          kChooseRow,
                          style: kMiniBadgeStyle.copyWith(
                            fontSize: 10.sp,
                            color: kCandyRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              return const Expanded(
                flex: 2,
                child: Center(child: Text('-')),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationRow(
    String label,
    String Function(YatzyPlayer) getValue, {
    bool isBold = false,
    bool highlight = false,
  }) {
    return Container(
      color: highlight ? kCandyGreen.withValues(alpha: 0.08) : Colors.grey.shade50,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: kHeadingSmall.copyWith(
                fontSize: 11.5.sp,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
                color: highlight ? kCandyGreen : kPrimaryTextColor,
              ),
            ),
          ),
          ...players.map((p) {
            return Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  getValue(p),
                  style: kHeadingSmall.copyWith(
                    fontSize: 12.sp,
                    color: highlight ? kCandyGreen : kPrimaryTextColor,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

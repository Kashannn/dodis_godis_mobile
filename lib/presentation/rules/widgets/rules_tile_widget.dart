import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class RulesTileWidget extends StatelessWidget {
  final Map<String, dynamic> section;

  const RulesTileWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    final color = section['color'] as Color;
    final rules = section['rules'] as List<String>;

    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: kBorderColor),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(section['icon'] as IconData, color: color, size: 20.sp),
          ),
          title: Text(
            section['title'] as String,
            style: kHeadingXSmall,
          ),
          subtitle: Text(
            section['category'] as String,
            style: kBodySmall,
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 18.w,
                right: 18.w,
                bottom: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rules.map((r) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Icon(Icons.circle, size: 6.sp, color: color),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            r,
                            style: kBodyMedium.copyWith(
                              color: kPrimaryTextColor,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

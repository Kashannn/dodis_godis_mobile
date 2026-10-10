import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../bloc/create_party_state.dart';

class HolderColorPaletteWidget extends StatelessWidget {
  final HolderColorOption selectedColor;
  final ValueChanged<HolderColorOption> onColorSelected;

  const HolderColorPaletteWidget({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Title: "Choose Your Color"
        Text(
          kChooseYourColor,
          style: GoogleFonts.comicNeue(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w900,
            color: kPartyTextDark,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 14.h),

        // Color Swatches Wrap (Responsive and immune to overflow)
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.w,
          runSpacing: 8.h,
          children: CreatePartyState.defaultColors.map((option) {
            final isSelected = option.name == selectedColor.name;
            return GestureDetector(
              onTap: () => onColorSelected(option),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 44.w,
                height: 44.h,
                padding: EdgeInsets.all(isSelected ? 3.r : 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? option.color : Colors.transparent,
                    width: isSelected ? 2.2 : 0,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: option.color,
                    boxShadow: [
                      BoxShadow(
                        color: option.color.withValues(alpha: 0.35),
                        blurRadius: 4.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class PartyNameInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const PartyNameInputWidget({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Icon(
              Icons.celebration_rounded,
              color: kPartyPrimaryBlue,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              kPartyNameLabel,
              style: GoogleFonts.comicNeue(
                fontSize: 16.5.sp,
                fontWeight: FontWeight.w800,
                color: kPartyTextDark,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Text Field Container
        Container(
          decoration: BoxDecoration(
            color: kPartyInputFill,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: kPartyInputBorder,
              width: 1.6,
            ),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: GoogleFonts.comicNeue(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.w800,
              color: kPartyTextDark,
            ),
            decoration: InputDecoration(
              hintText: kDefaultPartyName,
              hintStyle: GoogleFonts.comicNeue(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: kPartyTextSubtle,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              border: InputBorder.none,
              suffixIcon: const Icon(
                Icons.edit_rounded,
                color: kPartyTextSubtle,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

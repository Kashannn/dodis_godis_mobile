import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final bool centerTitle;
  final Widget? leading;
  final double elevation;

  const AppCustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.centerTitle = true,
    this.leading,
    this.elevation = 0,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: leading ??
          GestureDetector(
            onTap: onBackTap ??
                () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    context.pop();
                  }
                },
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.04),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: iconColor ?? const Color(0xFF26190E),
                  size: 20.sp,
                ),
              ),
            ),
          ),
      title: Text(
        title,
        style: GoogleFonts.comicNeue(
          fontSize: 24.sp,
          fontWeight: FontWeight.w900,
          color: titleColor ?? const Color(0xFF1F1E2C),
          letterSpacing: 0.2,
        ),
      ),
      actions: actions,
    );
  }
}

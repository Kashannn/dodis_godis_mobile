import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TapToPlayButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderWidth;

  const TapToPlayButton({
    super.key,
    required this.text,
    this.onPressed,
    this.gradientColors,
    this.borderColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.borderWidth,
  });

  @override
  State<TapToPlayButton> createState() => _TapToPlayButtonState();
}

class _TapToPlayButtonState extends State<TapToPlayButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.gradientColors ??
        const [
          Color(0xFFFFE072),
          Color(0xFFFFCA28),
          Color(0xFFFFB300),
        ];
    final border = widget.borderColor ?? const Color(0xFF2A180B);
    final textCol = widget.textColor ?? const Color(0xFF26190E);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: widget.width ?? 320.w,
          height: widget.height ?? 64.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular((widget.height ?? 64.h) / 2),
            border: Border.all(
              color: border,
              width: widget.borderWidth ?? 2.8,
            ),
            boxShadow: [
              BoxShadow(
                color: border.withValues(alpha: 0.28),
                blurRadius: 10.r,
                offset: Offset(0, 6.h),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.7),
                blurRadius: 3.r,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: GoogleFonts.comicNeue(
                fontSize: widget.fontSize ?? 23.sp,
                fontWeight: FontWeight.w900,
                color: textCol,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

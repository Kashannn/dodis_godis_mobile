import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppCustomScaffold extends StatelessWidget {
  const AppCustomScaffold({
    required this.body,
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.backgroundColor,
    this.padding,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
    this.safeTop = true,
    this.safeBottom = true,
    this.safeLeft = true,
    this.safeRight = true,
    this.enableUnfocus = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.systemUiOverlayStyle,
    this.statusBarIconBrightness = Brightness.dark,
    this.systemNavigationBarIconBrightness = Brightness.dark,
  });

  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final bool resizeToAvoidBottomInset;
  final bool safeTop;
  final bool safeBottom;
  final bool safeLeft;
  final bool safeRight;
  final bool enableUnfocus;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final Brightness statusBarIconBrightness;
  final Brightness systemNavigationBarIconBrightness;

  @override
  Widget build(BuildContext context) {
    final effectiveOverlayStyle = systemUiOverlayStyle ??
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusBarIconBrightness,
          statusBarBrightness: statusBarIconBrightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
          systemNavigationBarContrastEnforced: false,
          systemStatusBarContrastEnforced: false,
        );

    Widget content = SafeArea(
      top: safeTop,
      bottom: safeBottom,
      left: safeLeft,
      right: safeRight,
      child: padding == null ? body : Padding(padding: padding!, child: body),
    );

    if (enableUnfocus) {
      content = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: content,
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: effectiveOverlayStyle,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        body: content,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        bottomNavigationBar: bottomNavigationBar != null && safeBottom
            ? SafeArea(
                top: false,
                bottom: true,
                child: bottomNavigationBar!,
              )
            : bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        drawer: drawer,
        endDrawer: endDrawer,
        bottomSheet: bottomSheet != null && safeBottom
            ? SafeArea(
                top: false,
                bottom: true,
                child: bottomSheet!,
              )
            : bottomSheet,
      ),
    );
  }
}
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: content,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
    );
  }
}
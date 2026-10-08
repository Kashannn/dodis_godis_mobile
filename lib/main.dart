import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/router/app_routers.dart';
import 'core/constants/app_strings.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependencies (GetIt, LocalStorage, etc.)
  await initDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const DodisGodisApp());
}

class DodisGodisApp extends StatelessWidget {
  const DodisGodisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: kAppName,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}

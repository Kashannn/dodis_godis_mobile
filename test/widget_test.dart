import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dodis_godis/core/di/injection_container.dart';
import 'package:dodis_godis/main.dart';
import 'package:dodis_godis/presentation/splash/view/splash_view.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await initDependencies();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DodisGodisApp());
    await tester.pump();
    expect(find.byType(SplashView), findsOneWidget);
    expect(find.textContaining('DODIS GODIS'), findsAtLeast(1));
  });
}

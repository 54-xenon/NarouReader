import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naroureader/main.dart';

void main() {
  testWidgets('App starts and shows bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('ホーム'), findsOneWidget);
    expect(find.text('保存'), findsOneWidget);
    expect(find.text('設定'), findsOneWidget);
  });
}

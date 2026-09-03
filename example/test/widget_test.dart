import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vialer_voip_flutter_example/main.dart';
import 'package:vialer_voip_flutter_example/src/phone.dart';

void main() {
  testWidgets('renders the dialer', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await Phone.instance.load();

    await tester.pumpWidget(const ExampleApp());

    expect(find.text('Dialer'), findsWidgets);
    expect(find.text('Settings'), findsOneWidget);
  });
}

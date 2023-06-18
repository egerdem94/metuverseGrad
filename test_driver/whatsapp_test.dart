import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('WhatsApp integration', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('launch WhatsApp', () async {
      final whatsappWidget = find.byValueKey('whatsapp');

      await driver.tap(whatsappWidget);

      final whatsappApp = find.byType('App');
      expect(await driver.getText(whatsappApp), contains('WhatsApp'));

      final screenshot = await driver.screenshot(); // Returns Uint8List
    });
  });
}

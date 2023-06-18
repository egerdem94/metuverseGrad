import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable List', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('scroll to item', () async {
      final listViewFinder = find.byType('ListView');

      // Scroll the ListView widget to the bottom.
      await driver.scrollUntilVisible(
        listViewFinder,
        find.byValueKey('Item 10'),
        dyScroll: -300.0,
      );

      // Check if 'Item 10' is visible.
      expect(await driver.getText(find.byValueKey('Item 10')), 'Item 10');
    }, timeout: Timeout(Duration(minutes: 2))); // increase the timeout here
  });
}

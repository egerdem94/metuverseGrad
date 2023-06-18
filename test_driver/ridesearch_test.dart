// Import the flutter_driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Ride Search Test', () {
    // First, define the Finders. We'll use these to locate the widgets we want to interact with.
    final searchFieldFinder = find.byValueKey('searchField');
    final departureDropdownFinder = find.byValueKey('departureDropdown');
    final destinationDropdownFinder = find.byValueKey('destinationDropdown');
    final searchButtonFinder = find.byValueKey('searchButton');

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('search for rides', () async {
      await driver.tap(searchFieldFinder);
      await driver.enterText('passenger count');

      await driver.tap(departureDropdownFinder);
      await driver.tap(find.text('Campus'));
      await driver.tap(destinationDropdownFinder);
      await driver.tap(find.text('Güzelyurt'));

      await driver.tap(searchButtonFinder);
    }, timeout: Timeout(Duration(minutes: 2)));
  });
}

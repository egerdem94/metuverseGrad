// Import the flutter_driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Ride Posting Test', () {
    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('post a ride', () async {
      // Find the input fields and buttons
      final departureDropdownFinder = find.byValueKey('departureDropdown');
      final destinationDropdownFinder = find.byValueKey('destinationDropdown');
      final priceFieldFinder = find.byValueKey('priceField');
      final seatsFieldFinder = find.byValueKey('seatsField');
      final descriptionFieldFinder = find.byValueKey('descriptionField');
      final postButtonFinder = find.byValueKey('postButton');

      await driver.tap(departureDropdownFinder);
      await driver.tap(find.text('Campus'));

      await driver.tap(destinationDropdownFinder);
      await driver.tap(find.text('Güzelyurt'));

      await driver.enterText('10');

      await driver.enterText('4');

      await driver.enterText('This is a test ride.');

      await driver.tap(postButtonFinder);

      await Future.delayed(Duration(seconds: 2));
    }, timeout: Timeout(Duration(minutes: 3)));
  });
}

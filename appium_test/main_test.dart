/*
 *  *
 *  * Created by IsuruRanapana on 6/13/2023 10:09 AM
 *  * Copyright (c) 2021 . All rights reserved.
 *  *
 */


import 'package:appium_driver/async_io.dart';

import 'package:test/test.dart';


void main() {
  late AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
        desired: {
          'platformName': 'Android',
          'appium:automationName':'flutter',
          'appium:appPackage':'com.example.appium_test_new',
          'deviceName': 'Flutter emu',
          'appium:app':'"D:/Self-Study/appium_test_new/build/app/outputs/flutter-apk/app-debug.apk',
          'reduceMotion': true,
        });
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('connect to server', () async {
    expect(await driver.title, 'Appium/welcome');
  });

  test('connect to existing session', () async {
    var sessionId = driver.id;

    AppiumWebDriver newDriver = await fromExistingSession(sessionId);
    expect(await newDriver.title, 'Appium/welcome');
    expect(newDriver.id, sessionId);
  });

  test('find by appium element', () async {
    final title = 'Appium/welcome';
    try {
      await driver.findElement(AppiumBy.accessibilityId(title));
      throw 'expected Unsupported locator strategy: accessibility id error';
    } on UnknownException catch (e) {
      expect(
          e.message!.contains('Unsupported locator strategy: accessibility id'),
          true);
    }
  });
}

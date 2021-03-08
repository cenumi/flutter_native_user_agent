import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_user_agent/flutter_native_user_agent.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_native_user_agent');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'CFNetwork/897.15 Darwin/17.5.0 (iPhone/6s iOS/11.3)';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('userAgent', () async {
    final ua = await FlutterNativeUserAgent().userAgent;
    debugPrint('ua');
    expect(ua.isNotEmpty, true);
  });
}

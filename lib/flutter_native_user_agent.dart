import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

class FlutterNativeUserAgent {
  static late final _instance = FlutterNativeUserAgent._();

  factory FlutterNativeUserAgent() => _instance;

  FlutterNativeUserAgent._();

  final _channel = const MethodChannel('flutter_native_user_agent');

  String _cache = '';

  Future<String> get userAgent async {
    if (_cache.isEmpty) {
      if (Platform.isAndroid) {
        _cache = (await _channel.invokeMethod('getUserAgent')).toString();
      } else {
        _cache = await _iosUserAgent;
      }
    }
    return _cache;
  }

  Future<String> get _iosUserAgent async {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    final cfnVersion = (await _channel.invokeMethod('getCfnVersion')).toString();
    return 'CFNetwork/$cfnVersion Darwin/${iosInfo.utsname.release} (${iosPhoneName(iosInfo.utsname.machine)} ${iosInfo
        .systemName}/${iosInfo.systemVersion})';
  }

  String iosPhoneName(String? codeName) =>
      switch (codeName) {
        'iPhone5,1' || 'iPhone5,2' => 'iPhone 5',
        'iPhone5,3' || 'iPhone5,4' => 'iPhone 5C',
        'iPhone6,1' || 'iPhone6,2' => 'iPhone 5S',
        'iPhone7,1' => 'iPhone 6 Plus',
        'iPhone7,2' => 'iPhone 6',
        'iPhone8,1' => 'iPhone 6S',
        'iPhone8,2' => 'iPhone 6S Plus',
        'iPhone8,4' => 'iPhone SE',
        'iPhone9,1' || 'iPhone9,3' => 'iPhone 7',
        'iPhone9,2' || 'iPhone9,4' => 'iPhone 7 Plus',
        'iPhone10,1' || 'iPhone10,4' => 'iPhone 8',
        'iPhone10,2' || 'iPhone10,5' => 'iPhone 8 Plus',
        'iPhone10,3' || 'iPhone10,6' => 'iPhone X',
        'iPhone11,2' => 'iPhone XS',
        'iPhone11,4' || 'iPhone11,6' => 'iPhone XS MAX',
        'iPhone11,8' => 'iPhone XR',
        'iPhone12,1' => 'iPhone 11',
        'iPhone12,3' => 'iPhone 11 Pro',
        'iPhone12,5' => 'iPhone 11 Pro Max',
        'iPhone12,8' => 'iPhone SE 2',
        'iPhone13,1' => 'iPhone 12 mini',
        'iPhone13,2' => 'iPhone 12',
        'iPhone13,3' => 'iPhone 12 Pro',
        'iPhone13,4' => 'iPhone 12 Pro Max',
        'iPhone14,4' => 'iPhone 13 mini',
        'iPhone14,5' => 'iPhone 13',
        'iPhone14,2' => 'iPhone 13 Pro',
        'iPhone14,3' => 'iPhone 13 Pro Max',
        'iPhone14,7' => 'iPhone 14',
        'iPhone14,8' => 'iPhone 14 Plus',
        'iPhone15,2' => 'iPhone 14 Pro',
        'iPhone15,3' => 'iPhone 14 Pro Max',
        _ => 'iPhone'
      };
}

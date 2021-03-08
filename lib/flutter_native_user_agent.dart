import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class FlutterNativeUserAgent {
  static final _instance = FlutterNativeUserAgent._();

  factory FlutterNativeUserAgent() => _instance;

  FlutterNativeUserAgent._();

  final _channel = const MethodChannel('flutter_native_user_agent');

  String _cache = '';

  Future<String> get userAgent async {
    if (_cache.isEmpty) {
      if(Platform.isAndroid){
        _cache = (await _channel.invokeMethod('getUserAgent')).toString();
      }else{
        _cache = await _iosUserAgent;
      }
    }
    return _cache;
  }

  Future<String> get _iosUserAgent async {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    final cfnVersion = (await _channel.invokeMethod('getCfnVersion')).toString();
    return 'CFNetwork/$cfnVersion Darwin/${iosInfo.utsname.release} (${iosPhoneName(iosInfo.utsname.machine)} ${iosInfo.systemName}/${iosInfo.systemVersion})';
  }

  String iosPhoneName(String codeName) {
    const iphone = 'iPhone';
    switch (codeName) {
      case '${iphone}5,1':
      case '${iphone}5,2':
        return '$iphone 5';
      case '${iphone}5,3':
      case '${iphone}5,4':
        return '$iphone 5C';
      case '${iphone}6,1':
      case '${iphone}6,2':
        return '$iphone 5S';
      case '${iphone}7,1':
        return '$iphone 6 Plus';
      case '${iphone}7,2':
        return '$iphone 6';
      case '${iphone}8,1':
        return '$iphone 6S';
      case '${iphone}8,2':
        return '$iphone 6S Plus';
      case '${iphone}8,4':
        return '$iphone SE';
      case '${iphone}9,1':
      case '${iphone}9,3':
        return '$iphone 7';
      case '${iphone}9,2':
      case '${iphone}9,4':
        return '$iphone 7 Plus';
      case '${iphone}10,1':
      case '${iphone}10,4':
        return '$iphone 8';
      case '${iphone}10,2':
      case '${iphone}10,5':
        return '$iphone 8 Plus';
      case '${iphone}10,3':
      case '${iphone}10,6':
        return '$iphone X';
      case '${iphone}11,2':
        return '$iphone XS';
      case '${iphone}11,4':
      case '${iphone}11,6':
        return '$iphone XS MAX';
      case '${iphone}11,8':
        return '$iphone XR';
      case '${iphone}12,1':
        return '$iphone 11';
      case '${iphone}12,3':
        return '$iphone 11 Pro';
      case '${iphone}12,5':
        return '$iphone 11 Pro Max';
      case '${iphone}12,8':
        return '$iphone SE 2';
      case '${iphone}13,1':
        return '$iphone 12 mini';
      case '${iphone}13,2':
        return '$iphone 12';
      case '${iphone}13,3':
        return '$iphone 12 Pro';
      case '${iphone}13,4':
        return '$iphone 12 Pro Max';
    }
    return codeName;
  }
}

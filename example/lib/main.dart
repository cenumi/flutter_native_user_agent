import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_native_user_agent/flutter_native_user_agent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _userAgent = 'Unknown';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _userAgent = await FlutterNativeUserAgent().userAgent;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on:\n$_userAgent\n'),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:time_change_detector/time_change_detector.dart';
import 'package:time_change_detector_example/definitions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: CHANNEL_KEY,
        channelName: CHANNEL_NAME,
        channelDescription: CHANNEL_DESCRIPTION,
        importance: NotificationImportance.High)
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Stream<bool>? _controller;
  String _message = EVENT_MESSAGE_DEFAULT;

  late StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _permissionHandler();
    _initWatcher();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && Platform.isAndroid) {
      _initWatcher();
    }
  }

  _permissionHandler() =>
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          // This is just a basic example. For real apps, you must show some
          // friendly dialog box before call the request method.
          // This is very important to not harm the user experience
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

  _initWatcher() {
    _controller ??= TimeChangeDetector().listener(calendarDayChanged: false);
    print(_message);
    _subscription = _controller!.listen((event) {
      setState(() => _message = '$EVENT_MESSAGE_SUCCESS: ${DateTime.now()}');
      createNotification(_message);
      print(_message);
    },
        onError: (error) => print('$ERROR: $error'),
        onDone: () => print(STREAM_COMPLETE));
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text(APP_TITLE)),
          body: SafeArea(child: Center(child: Text(_message)))));
}

createNotification(String title) => AwesomeNotifications().createNotification(
    content:
        NotificationContent(id: 10, channelKey: CHANNEL_KEY, title: title));

import 'dart:async';
import 'package:flutter/services.dart';

class TimeChangeDetector {
  static const EventChannel _eventChannel =
      EventChannel('time_change_detector');

  static Stream<bool> get init {
    return _eventChannel.receiveBroadcastStream().cast();
  }
}

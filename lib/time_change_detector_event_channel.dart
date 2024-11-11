import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'time_change_detector_platform_interface.dart';

/// An implementation of [TimeChangeDetectorPlatform] that uses method channels.
class EventChannelTimeChangeDetector extends TimeChangeDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel('time_change_detector');

  @override
  Stream<bool> listener({
    bool clockDidChange = true,
    bool timeZoneDidChange = true,
    bool calendarDayChanged = true,
  }) {
    final Map<String, bool> arguments = {
      'clockDidChange': clockDidChange,
      'timeZoneDidChange': timeZoneDidChange,
      'calendarDayChanged': calendarDayChanged,
    };
    return eventChannel.receiveBroadcastStream(arguments).cast();
  }
}

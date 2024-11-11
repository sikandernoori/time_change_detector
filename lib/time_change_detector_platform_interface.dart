import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'time_change_detector_event_channel.dart';

abstract class TimeChangeDetectorPlatform extends PlatformInterface {
  /// Constructs a TimeChangeDetectorPlatform.
  TimeChangeDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static TimeChangeDetectorPlatform _instance =
      EventChannelTimeChangeDetector();

  /// The default instance of [TimeChangeDetectorPlatform] to use.
  ///
  /// Defaults to [EventChannelTimeChangeDetector].
  static TimeChangeDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TimeChangeDetectorPlatform] when
  /// they register themselves.
  static set instance(TimeChangeDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<bool> listener({
    bool clockDidChange = true,
    bool timeZoneDidChange = true,
    bool calendarDayChanged = true,
  }) {
    throw UnimplementedError('listener() has not been implemented.');
  }
}

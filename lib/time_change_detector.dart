import 'time_change_detector_platform_interface.dart';

class TimeChangeDetector {
  Stream<bool> listener({
    bool clockDidChange = true,
    bool timeZoneDidChange = true,
    bool calendarDayChanged = true,
  }) {
    return TimeChangeDetectorPlatform.instance.listener(
      calendarDayChanged: calendarDayChanged,
      clockDidChange: clockDidChange,
      timeZoneDidChange: timeZoneDidChange,
    );
  }
}

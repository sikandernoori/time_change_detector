import Foundation
import Flutter

class TimeWatcherStreamHandler: NSObject, FlutterStreamHandler {
    var _sink: FlutterEventSink?

    private let clockDidChangeNotification = NSNotification.Name.NSSystemClockDidChange
    private let timeZoneDidChangeNotification = NSNotification.Name.NSSystemTimeZoneDidChange
    private let calendarDayChangedNotification = NSNotification.Name.NSCalendarDayChanged

    private var registeredNotifications = [NSNotification.Name]()

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _sink = events

        NotificationCenter.default.removeObserver(self)
        registeredNotifications.removeAll()

        if let args = arguments as? [String: Bool] {
            if args["clockDidChange"] == true {
                NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: clockDidChangeNotification, object: nil)
                registeredNotifications.append(clockDidChangeNotification)
            }
            if args["timeZoneDidChange"] == true {
                NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: timeZoneDidChangeNotification, object: nil)
                registeredNotifications.append(timeZoneDidChangeNotification)
            }
            if args["calendarDayChanged"] == true {
                NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: calendarDayChangedNotification, object: nil)
                registeredNotifications.append(calendarDayChangedNotification)
            }
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: clockDidChangeNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: timeZoneDidChangeNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: calendarDayChangedNotification, object: nil)
            registeredNotifications = [clockDidChangeNotification, timeZoneDidChangeNotification, calendarDayChangedNotification]
        }

        return nil
    }

    @objc func timeChangedNotification(notification: NSNotification) {
        guard let _sink = _sink else {
            return
        }
        // TODO(Sikander): check with Team if we need to distinguish between notification types in future
//        print(notification.name.rawValue)
        _sink(true)
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _sink = nil

        for notification in registeredNotifications {
            NotificationCenter.default.removeObserver(self, name: notification, object: nil)
        }
        registeredNotifications.removeAll()
        return nil
    }
}

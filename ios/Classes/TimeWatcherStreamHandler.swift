import Foundation
import Flutter

class TimeWatcherStreamHandler: NSObject, FlutterStreamHandler{
    var _sink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _sink = events
        NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: NSNotification.Name.NSSystemClockDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(timeChangedNotification), name: NSNotification.Name.NSSystemTimeZoneDidChange, object: nil)
        return nil
    }

    // Method get called user changed the system time manually.
    @objc func timeChangedNotification(notification:NSNotification){
    guard let _sink = _sink else {
      return
    }
    _sink(true)
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _sink = nil
        return nil
    }
}

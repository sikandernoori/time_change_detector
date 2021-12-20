import Flutter
import UIKit

public class SwiftTimeChangeDetectorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let eventChannel = FlutterEventChannel(name: "time_change_detector", binaryMessenger: registrar.messenger())
    let timeWatcherStreamHandler = TimeWatcherStreamHandler()
    eventChannel.setStreamHandler(timeWatcherStreamHandler)
  }

}

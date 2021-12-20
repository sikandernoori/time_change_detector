#import "TimeChangeDetectorPlugin.h"
#if __has_include(<time_change_detector/time_change_detector-Swift.h>)
#import <time_change_detector/time_change_detector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "time_change_detector-Swift.h"
#endif

@implementation TimeChangeDetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTimeChangeDetectorPlugin registerWithRegistrar:registrar];
}
@end

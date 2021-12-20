Pod::Spec.new do |s|
  s.name             = 'time_change_detector'
  s.version          = '0.0.1'
  s.summary          = 'A flutter plugin to detect change in device time, date and timezone for Android and IOS.'
  s.description      = <<-DESC
  Time change detector
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Skandar Munir Ahmed' => 'skandar_munir@yahoo.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end

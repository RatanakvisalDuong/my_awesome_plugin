Pod::Spec.new do |s|
  s.name             = 'my_awesome_plugin'
  s.version          = '0.0.2'
  s.summary          = 'A Flutter plugin for awesome functionality'
  s.description      = <<-DESC
A Flutter plugin that provides device battery level monitoring, platform version detection, and text data processing capabilities.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
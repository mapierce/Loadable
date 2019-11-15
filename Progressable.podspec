#
# Be sure to run `pod lib lint Progressable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Progressable'
  s.version          = '0.1.0'
  s.summary          = 'Make any UIView a UIProgressView'
  s.description      = <<-DESC
Now you can make any UIView or subclass into a UIProgressView and show progress wherever you like
                       DESC

  s.homepage         = 'https://github.com/Matthew Pierce/Progressable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matthew Pierce' => 'mp.mapierce@gmail.com' }
  s.source           = { :git => 'https://github.com/Matthew Pierce/Progressable.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/PierceMatthew'
  s.ios.deployment_target = '11.0'
  s.source_files = 'Progressable/Classes/**/*'
  s.swift_version = '5.0'
  s.frameworks = 'UIKit'
end

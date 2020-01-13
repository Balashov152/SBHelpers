#
# Be sure to run `pod lib lint SBHelpers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SBHelpers'
  s.version          = '0.1.0'
  s.summary          = 'SBHelpers write on Swift 5.0. Include extensions and structs for making life easier'
  s.swift_versions   = '5.0'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                  'SBHelpers write on Swift 5.0. Include extensions and structs for making life easier'
                       DESC

  s.homepage         = 'https://github.com/Balashov152/SBHelpers'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Balashov152' => 'balashov.152@gmail.com' }
  s.source           = { :git => 'https://github.com/Balashov152/SBHelpers.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.default_subspec = "Core"
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "5.0" }

  s.source_files = 'SBHelpers/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
  
  s.subspec "Core" do |ss|
    ss.source_files = "Classes/Core/"
    ss.dependency 'AlamofireImage', '~> 3.5'
  end

  s.subspec "Rx" do |ss|
    ss.source_files = "Classes/Rx/"
    ss.dependency "RxSwift", "~> 4.5"
    ss.dependency "RxCocoa", "~> 4.5"
    ss.dependency "RxDataSources", "~> 3.1"
    ss.dependency "RxKeyboard", '~> 0.9'
    ss.dependency "RxViewController", '~> 0.4'
  end

end

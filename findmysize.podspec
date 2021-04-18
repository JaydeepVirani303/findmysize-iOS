#
# Be sure to run `pod lib lint findmysize.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'findmysize'
  s.version          = '0.1.7'
  s.summary          = 'findmysize is the size getting library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: findmysize is the size getting library.
                       DESC

  s.homepage         = 'https://github.com/ViraniJaydeep303/findmysize-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jaydeep' => 'viranijaydeep303@gmail.com' }
  s.source           = { :git => 'https://github.com/JaydeepVirani303/findmysize-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.module_name = "findmysize"
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
    
  s.framework = "UIKit"
  s.dependency 'SwiftyJSON', '~> 4.3.0'
  s.dependency 'Alamofire', '~> 4.9.1'
  s.dependency 'ReachabilitySwift', '~> 5.0.0'
  s.dependency 'AlamofireSwiftyJSON', '~> 1.0.2'
  s.dependency 'ObjectMapper', '~> 4.2.0'

  
  s.source_files = "findmysize/**/*.{swift}"
  
  s.resources = "findmysize/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  
#  s.resource_bundles = {
#      'findmysize' => ['findmysize/*/*.{xib,storyboard,xcassets}'] }
#  s.resource_bundles = {
#       'findmysize' => ['findmysize/**']
#     }
#    s.resources = ['Classes/Resources/Assets.xcassets']
#  s.resources = [
#  'findmysize/*.storyboard',
#  'findmysize/**/*.xcassets',
#  'findmysize/**/*.xcassets/*.json',
#  'findmysize/Assets']
  
  
  
  # s.resource_bundles = {
  #   'findmysize' => ['findmysize/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

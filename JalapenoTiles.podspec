#
# Be sure to run `pod lib lint JalapenoTiles.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'JalapenoTiles'
    s.version          = '0.1.0'
    s.summary          = 'A simple way to create a store screen.'
    s.description      = 'The library was created to help developers create store screens. It adapts to each screen in a very simple and transparent way.'
    s.homepage         = 'https://github.com/Appnroll/jalapeno-tiles'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Namedix' => 'bartek.pichalski@appnroll.com' }
    s.source           = { :git => 'https://github.com/Appnroll/jalapeno-tiles.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    s.ios.deployment_target = '10.0'
    s.source_files = 'JalapenoTiles/**/*.{swift}'
    s.resources = 'JalapenoTiles/Assets/*.{png,jpeg,jpg,storyboard,xib,xcassets}'
    s.frameworks = 'UIKit'
    s.swift_version = '4.2'

end

#
# Be sure to run `pod lib lint BlockListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BlockListView'
  s.version          = '0.1.1'
  s.summary          = '使用block将tableView的代理方法和网络封装'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
使用block将tableView的代理方法和网络封装，使用更加简单
                       DESC

  s.homepage         = 'https://github.com/crazyLuobo/BlockListView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yanwenbo_78201@163.com' => 'yanwenbo_78201@163.com' }
  s.source           = { :git => 'https://github.com/crazyLuobo/BlockListView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BlockListView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BlockListView' => ['BlockListView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
   s.dependency 'MJRefresh'
   s.dependency 'PPNetworkHelper'
end

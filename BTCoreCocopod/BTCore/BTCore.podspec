#
# Be sure to run `pod lib lint BTCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BTCore'
  #version要和git上的tag进行对应
  s.version          = '0.2.2'
  s.summary          = 'BT学院App中基础文件、公共文件、第三方库等集成框架库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        'BT学院App中基础文件、公共文件、第三方库等集成框架库,gogogogo'
                       DESC

  s.homepage         = 'https://caifan@gitlab.btclass.cn/caifan/BTCoreDemo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'caifan' => '2998000457@qq.com' }
  s.source           = { :git => 'https://caifan@gitlab.btclass.cn/caifan/BTCoreDemo.git', :tag => s.version.to_s }

  s.platform = :ios, '9.0'
  
  s.requires_arc = true

#s.prefix_header_file = 'BTCore/Classes/prefixHeader.pch'


  s.frameworks = 'UIKit', 'AVFoundation','QuartzCore'
  
  #s.source_files = 'BTCore/Classes/prefixHeader.h'
  #s.public_header_files = 'BTCore/Classes/prefixHeader.h'
  
  s.subspec 'Kit' do |kit|
      kit.source_files = 'BTCore/Classes/Kit/**/*.{h,m}'
      kit.public_header_files = 'BTCore/Classes/Kit/**/*.h'
      kit.dependency 'BTCore/ThirdParty'
  end
  
  s.subspec 'ThirdParty' do |thirdparty|
      thirdparty.source_files = 'BTCore/Classes/ThirdParty/**/*.{h,m}'
      thirdparty.public_header_files = 'BTCore/Classes/ThirdParty/**/*.h'
      thirdparty.resource = 'BTCore/Assets/SVProgressHUD.bundle'
  end
  
  s.dependency 'Masonry', '~> 1.0.2'

end

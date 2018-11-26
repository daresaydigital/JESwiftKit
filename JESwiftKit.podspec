#
# Be sure to run `pod lib lint JESwiftKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JESwiftKit'
  s.version          = '0.1.0'
  s.summary          = 'A collection of extra tools.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A collection of extensions and useful views'

  s.homepage         = 'https://github.com/joeboyscout04/JESwiftKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'joeboyscout04' => 'joseph.elliott@daresay.co' }
  s.source           = { :git => 'https://github.com/joeboyscout04/JESwiftKit.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.source_files = 'JESwiftKit/Classes/**/*'
  s.default_subspec = 'Core', 'Views'
  s.frameworks = 'UIKit'
  s.swift_version = '4.2'
  
  s.subspec 'Core' do |cs|
      cs.source_files = 'Classes/Core'
  end
  
  s.subspec 'Views' do |cs|
      cs.source_files = 'Classes/Views'
      cs.dependency 'SwifterSwift'
  end

  s.subspec 'Rx' do |cs|
      cs.source_files = 'Classes/Rx'
      cs.dependency 'RxSwift'
      cs.dependency 'RxCocoa'
  end

  s.subspec 'Lottie' do |cs|
      cs.source_files = 'Classes/Lottie'
      cs.dependency 'lottie-ios'
      cs.dependency 'SwifterSwift'
  end
end

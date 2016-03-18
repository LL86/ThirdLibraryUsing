#

Pod::Spec.new do |s|

  s.name         = "ThirdLibraryTest.podspec"
  s.version      = "0.0.1"

  s.description  = <<-DESC

	test thirdLibrary.

                   DESC

  s.homepage     = "https://github.com/LL86/ThirdLibraryUsing"


  s.license      = "MIT"

  s.author             = { "LL" => "18657141238@163.com" }

  s.source       = { :git => "https://github.com/LL86/ThirdLibraryUsing", :tag => "0.0.1" }


  s.platform     = :ios, '7.0' 
  s.requires_arc = true

  s.public_header_files = 'Pod/Classes/**/*.h'   #公开头文件地址
  s.frameworks = 'UIKit'  
 
  s.dependency 'AFNetworking', '~> 2.6.0'
  s.dependency 'FMDB', '~> 2.6'
  s.dependency 'Masonry' 
  s.dependency 'ReactiveCocoa', '~> 2.1' 
  s.dependency 'SDWebImage', '~> 3.7.5'
s.dependency 'SSKeychain', '~> 1.3.1'
end

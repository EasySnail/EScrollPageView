Pod::Spec.new do |s|
  s.name         = "EScrollPageView"
  s.version      = "0.0.1"
  s.ios.deployment_target = '8.0'
  s.summary      = "Scroll PageView"
  s.homepage     = "https://github.com/EasySnail/EScrollPageView"
  s.license      = "MIT"
  s.author             = { "EasySnail" => "944200885@qq.com" }
  s.source       = { :git => "https://github.com/EasySnail/EScrollPageView.git", :tag => s.version }
  s.source_files  = "EScrollPageView/EPageCore"
  s.frameworks = "UIKit","Foundation"
  s.requires_arc = true
end

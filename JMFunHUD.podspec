Pod::Spec.new do |s|
  s.name             = 'JMFunHUD'
  s.version          = '1.0.0'
  s.summary          = 'A creative and fun HUD'
  s.description      = <<-DESC
                       This is a a creative and fun HUD.
                         DESC
  s.homepage         = 'https://github.com/jiemi/JMFunHUD'
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { 'jiemi' => "594702537@qq.com" } 
  s.source           = { :git => 'https://github.com/jiemi/JMFunHUD.git', :tag => s.version }
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  
  s.source_files     = 'Class/**/*.{h,m}' 
  s.frameworks        = 'UIKit'
end
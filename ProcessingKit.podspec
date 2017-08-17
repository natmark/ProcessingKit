Pod::Spec.new do |s|
  s.name         = "ProcessingKit"
  s.version      = "0.1"
  s.summary      = "Visual Programming library for iOS."
  s.description  = <<-DESC
  ProcessingKit is a Visual Programming library for iOS.
  ProcessingKit written in Swift🐧  and you can write like processing.
                   DESC
  s.homepage     = "https://github.com/natmark/ProcessingKit"
  s.screenshots  = "https://github.com/natmark/ProcessingKit/blob/master/Resources/demo.gif?raw=true"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Atsuya Sato" => "natmark0918@gmail.com" }
  s.osx.deployment_target = "10.0"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/natmark/ProcessingKit.git", :tag => "#{s.version}" }
  s.source_files  = "ProcessingKit/**/*.{h,m}"
  s.requires_arc = true
end

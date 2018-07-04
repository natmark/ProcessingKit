Pod::Spec.new do |s|
  s.name         = "ProcessingKit"
  s.version      = "1.0.6"
  s.summary      = "Visual Designing library for iOS."
  s.description  = <<-DESC
  ProcessingKit is a Visual Designing library for iOS.
  ProcessingKit written in Swift🐧  and you can write like processing.
                   DESC
  s.homepage     = "https://github.com/natmark/ProcessingKit"
  s.screenshots  = "https://github.com/natmark/ProcessingKit/raw/master/Resources/ProcessingKit-Header.png?raw=true"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Atsuya Sato" => "natmark0918@gmail.com" }
  s.osx.deployment_target = "10.11"
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/natmark/ProcessingKit.git", :tag => "#{s.version}" }
  s.source_files  = "ProcessingKit/**/*.swift"
  s.exclude_files = "ProcessingKit/Demo.playground/*"
  s.ios.exclude_files = "ProcessingKit/Extensions/NSImage.swift", "ProcessingKit/Extensions/NSView.swift"
  s.requires_arc = true
end

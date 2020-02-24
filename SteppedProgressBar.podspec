Pod::Spec.new do |spec|

  spec.name         = "SteppedProgressBar"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
  a highly customizable stepped progressbar for showing step progress to users.
                   DESC

  spec.homepage     = "https://github.com/iD0N/SteppedProgressBar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Don" => "don@donstudio.io" }

  spec.ios.deployment_target = "12.1"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/iD0N/SteppedProgressBar.git", :tag => "#{spec.version}" }
  spec.source_files  = "SteppedProgressBar/**/*.{h,m,swift}"

end
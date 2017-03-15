Pod::Spec.new do |s|
          #1.
          s.name               = “FinalFramework”
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "Sort description of 'FinalFramework' framework"
          #4.
          s.homepage        = "https://github.com/CocoaPods/Specs.git"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = “Pranali”
          #7.
          s.platform            = :ios, “9.0”
          #8.
          s.source              = { :git => "https://github.com/pranaligatfane/AuthenticationFramework.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "FinalFramework", "FinalFramework/**/*.{swift}"
    end
Pod::Spec.new do |spec|

  spec.name         = "JustPopup"
  spec.version      = "0.0.6"
  spec.summary      = "A lightweight library used to display custom popups"
  spec.description  = "Show animated popups with just views (either UIKIt and SwiftUI) or view controllers."
  spec.homepage     = "http://github.com/glassomoss/JustPopup"
  spec.license      = { :type => "MIT" }
  spec.author       = { "Mefodiy" => "akatpod2@mail.ru" }
  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/glassomoss/JustPopup.git", :tag => spec.version }

#  spec.source_files = "JustPopup/Classes/**/*"
  spec.source_files  = 'JustPopup/*.{h,m}'


end

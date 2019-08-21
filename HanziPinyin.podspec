Pod::Spec.new do |s|

  s.name         = "HanziPinyin"
  s.version      = "1.0.0"
  s.summary      = "A lightweight Swift library supporting convertion between Chinese(both Simplified and Tranditional) characters and Pinyin."

  s.homepage     = "https://github.com/teambition/HanziPinyin"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "Xin Hong"

  s.source       = { :git => "https://github.com/teambition/HanziPinyin.git", :tag => s.version.to_s }
  s.source_files = "HanziPinyin/*.swift"
  s.resource_bundles = {
    'HanziPinyin' => ['HanziPinyin/Resources/*.txt'],
  }

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.frameworks   = "Foundation"
  s.swift_version = "5.0"

end

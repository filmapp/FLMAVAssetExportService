Pod::Spec.new do |s|
  s.name         = "FLMAVAssetExportService"
  s.version      = "0.1.0"
  s.summary      = "[iOS] FLMAVAssetExportService"
  s.homepage     = "https://github.com/filmapp/FLMAVAssetExportService"
  s.license      = "MIT"
  s.author       = { "kaiinui" => "lied.der.optik@gmail.com" }
  s.source       = { :git => "https://github.com/filmapp/FLMAVAssetExportService.git", :tag => "v0.1.0" }
  s.source_files  = "FLMAVAssetExportService/Classes/**/*.{h,m}"
  s.requires_arc = true
  s.platform = "ios", '7.0'
end

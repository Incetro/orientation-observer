Pod::Spec.new do |spec|
  spec.name          = 'orientation-observer'
  spec.module_name   = 'OrientationObserver'
  spec.version       = '0.1.0'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru' }
  spec.homepage      = "https://github.com/Incetro/orientation-observer.git"
  spec.summary       = 'Device orientation observer which works even for devices with orientation-lock turned on'
  spec.platform      = :ios, "12.0"
  spec.swift_version = '5.0'
  spec.source        = { git: "https://github.com/Incetro/orientation-observer.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/OrientationObserver/**/*.{h,swift}"
end
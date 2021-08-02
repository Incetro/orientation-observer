<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" />
    <a href="https://cocoapods.org/pods/OrientationObserver">
        <img src="https://img.shields.io/cocoapods/v/orientation-observer.svg?style=flat" alt="Pod Version">
    </a>
    <a href="">
        <img src="https://img.shields.io/badge/Licence-MIT-green.svg" alt="License">
    </a>
</p>

**OrientationObserver** is a CoreMotion-based library for tracking device orientation changes. It also works for devices with orientation-lock turned on. You can subscribe to orientation change notifications and react accordingly.

## Usage

To start device orientation tracking use `OrientationObserver` and `startDeviceOrientationTracking` method. You should add an observer for the `OrientationObserver.deviceOrientationChangedNotification` and react to orientation changes:

```swift
notificationCenter.addObserver(
    self, 
    selector: #selector(didChangeDeviceOrientation), 
    name: OrientationObserver.deviceOrientationChangedNotification,
    object: nil
)
```

You can access the current orientation using the `currentDeviceOrientation` property. To stop receiving notifications use the `stopDeviceOrientationTracking` method. If your app supports portrait mode only, you can use the `affineTransform` property to rotate views when the orientation changes:

```swift
UIView.animate(withDuration: 0.25) { [weak self] in
    self?.imageView.transform = self?.orientationObserver.affineTransform
}
```

## Requirements

- iOS 12.1+
- Xcode 12.5
- Swift 5.0

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate OrientationObserver into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'orientation-observer'
end
```

Then, run the following command:

```bash
$ pod install
```

## Author

incetro, incetro@ya.ru

## License

OrientationObserver is licensed under the MIT license. Check the [LICENSE](LICENSE) file for details.

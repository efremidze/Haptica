<p align="center">
    <img src="https://github.com/efremidze/Haptica/blob/master/Images/logo.png" width="890" alt="Haptica" />
</p>

<p align="center">
    <a href="https://swift.org" target="_blank">
        <img alt="Language" src="https://img.shields.io/badge/Swift-4-orange.svg?style=flat">
    </a>
    <a href="http://cocoapods.org/pods/Haptica" target="_blank">
        <img alt="Version" src="https://img.shields.io/cocoapods/v/Haptica.svg?style=flat">
    </a>
    <a href="http://cocoapods.org/pods/Haptica" target="_blank">
        <img alt="License" src="https://img.shields.io/cocoapods/l/Haptica.svg?style=flat">
    </a>
    <a href="http://cocoapods.org/pods/Haptica" target="_blank">
        <img alt="Platform" src="https://img.shields.io/cocoapods/p/Haptica.svg?style=flat">
    </a>
    <a href="https://github.com/Carthage/Carthage" target="_blank">
        <img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat">
    </a>
</p>

**Haptica** is an easy haptic feedback generator.

<img src="https://raw.githubusercontent.com/efremidze/Haptica/master/Images/demo.png" width="320">

```
$ pod try Haptica
```

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 4 (Haptica 2.x), Swift 3 (Haptica 1.x)

### Haptic Feedback Requirements:
- A device with a supported Taptic Engine (iPhone 7 and iPhone 7 Plus).
- App is running in the foreground.
- System Haptics setting is enabled.

## Usage

Generate using a haptic feedback type.

```swift
Haptic.impact(.light).generate()
```

### Feedback Types

* **Impact**: ([UIImpactFeedbackStyle](https://developer.apple.com/reference/uikit/uiimpactfeedbackstyle))
  * light
  * medium
  * heavy
* **Notification**: ([UINotificationFeedbackType](https://developer.apple.com/reference/uikit/uinotificationfeedbacktype))
  * success
  * warning
  * error
* **Selection**

### UIButton Extension

Use Haptica with UIButtons by setting `isHaptic` to true and setting the haptic feedback type (`hapticType`) to the desired type (`.impact(.light)`).

```swift
button.isHaptic = true
button.hapticType = .impact(.light)
```

#### Properties

```swift
var isHaptic: Bool // enables haptic feedback
var hapticType: Haptic? // haptic feedback type
var hapticControlEvents: UIControlEvents? // haptic feedback control events
```

### Sound Effects

Add sound effects to Haptica using [Peep](https://github.com/efremidze/Peep).

```swift
Peep.play(sound: KeyPress.tap)
```

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "Haptica"
```

### Carthage
To install with [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "efremidze/Haptica"
```

## Mentions

- [Fresh Swift](http://freshswift.net/post/-kj8ocn5j9lt_ljpffm4/)

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## License

Haptica is available under the MIT license. See the LICENSE file for more info.

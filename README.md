![Haptica](https://raw.githubusercontent.com/efremidze/Haptica/master/Images/logo.png)

[![CI](https://github.com/efremidze/Haptica/actions/workflows/ci.yml/badge.svg)](https://github.com/efremidze/Haptica/actions/workflows/ci.yml)
[![CocoaPods](https://img.shields.io/cocoapods/v/Haptica.svg)](https://cocoapods.org/pods/Haptica)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![License](https://img.shields.io/github/license/efremidze/Haptica.svg)](https://github.com/efremidze/Haptica/blob/master/LICENSE)

# Haptica

**Haptica** is a simple and expressive haptic feedback generator for iOS.

```bash
$ pod try Haptica
```

---

## 📱 Requirements

| Haptica Version | iOS | Swift | Xcode |
|-----------------|-----|-------|--------|
| 4.x             | 13+ | 5.x   | 11+     |
| 3.x             | 9+  | 5.x   | 8+      |
| 2.x             | 9+  | 4.x   | 8+      |
| 1.x             | 9+  | 3.x   | 8+      |

### Haptic Feedback Requirements

- Device with a supported Taptic Engine  
- App running in the foreground  
- System Haptics setting enabled  

---

## 🚀 Usage

Trigger a haptic feedback with a single line:

```swift
Haptic.impact(.light).generate()
```

### Feedback Types

- **Impact** (`.light`, `.medium`, `.heavy`, `.soft`, `.rigid`)  
  Use to indicate collision or snap-to-position.
- **Notification** (`.success`, `.warning`, `.error`)  
  Use to communicate task results.
- **Selection**  
  Use for navigation through discrete values.

### Semantic Types (New)

Use new expressive variants for common interactions:

```swift
Haptic.success.generate()
Haptic.warning.generate()
Haptic.start.generate()
Haptic.stop.generate()
Haptic.increase.generate()
Haptic.decrease.generate()
```

These semantic styles internally map to appropriate UIKit or Core Haptics-based effects.

### Custom Vibration Patterns

```swift
Haptic.play("..oO-Oo..", delay: 0.1)
```

| Symbol | Feedback Type   |
|--------|-----------------|
| `.`    | Light impact    |
| `o`    | Medium impact   |
| `O`    | Heavy impact    |
| `x`    | Soft impact     |
| `X`    | Rigid impact    |
| `-`    | 0.1s pause      |

Or use structured notes:

```swift
Haptic.play([
    .haptic(.impact(.light)),
    .haptic(.impact(.heavy)),
    .wait(0.1),
    .haptic(.impact(.heavy)),
    .haptic(.impact(.light))
])
```

### 🔧 Core Haptics Support

Haptica uses **Core Haptics** by default when available. To use the legacy API:

```swift
Haptic.play(notes, legacy: true)
```

### 📂 Play from Pattern File (New) - iOS 16+

Play a Core Haptics pattern from a bundled `.ahap` file:

```swift
Haptic.playPattern(named: "Feedback")
```

Make sure the file is included in your app bundle and contains a valid haptic pattern.

---

## 🧹 UIButton Extension

Enable haptics for buttons easily:

```swift
button.isHaptic = true
button.hapticType = .impact(.light)
```

Add or remove haptic feedback on control events:

```swift
button.addHaptic(.selection, forControlEvents: .touchDown)
button.removeHaptic(forControlEvents: .touchDown)
```

**API Summary:**

```swift
var isHaptic: Bool
var hapticType: Haptic?
var hapticControlEvents: UIControl.Event?

func addHaptic(_ haptic: Haptic, forControlEvents events: UIControl.Event)
func removeHaptic(forControlEvents events: UIControl.Event)
```

---

## 🔊 Sound Effects

Integrate sound feedback with [Peep](https://github.com/efremidze/Peep):

```swift
Peep.play(sound: KeyPress.tap)
```

---

## 📦 Installation

### Swift Package Manager

```swift
// For iOS 13+
.package(url: "https://github.com/efremidze/Haptica.git", from: "4.0.0")

// For iOS 9
.package(url: "https://github.com/efremidze/Haptica.git", from: "3.0.0")
```

### CocoaPods

```ruby
use_frameworks!
pod "Haptica"
```

### Carthage

```ruby
github "efremidze/Haptica"
```

---

## 💬 Communication

- Found a bug? → [Open an issue](https://github.com/efremidze/Haptica/issues)
- Have a feature request? → [Open an issue](https://github.com/efremidze/Haptica/issues)
- Want to contribute? → Submit a pull request

---

## 📰 Mentions

- [Fresh Swift](http://freshswift.net/post/-kj8ocn5j9lt_ljpffm4/)

---

## 📄 License

Haptica is available under the MIT license. See the [LICENSE](./LICENSE) file for details.

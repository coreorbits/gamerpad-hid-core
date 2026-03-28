# gamerpad-hid-core

Keyboard and mouse focused virtual input package using gamepad-style naming across the API.

## What This Is

This package currently provides high-level keyboard and mouse state classes and device identity helpers under a gamepad-style naming scheme.

## Features

- Manages key and modifier state with `VirtualGamepadKeyboard`
- Manages pointer movement, scroll, and buttons with `VirtualGamepadMouse`
- Generates device identity fields with `VirtualGamepadConfiguration`
- Does not include network, UI, or platform-specific OS injection code

## Requirements

- macOS 15.0 or later
- Xcode 16 or later
- Swift 6.0 or later

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/CoreOrbits/gamerpad-hid-core", from: "1.0.0")
]
```

## Usage

```swift
import GamerpadHIDCore

let keyboard = VirtualGamepadKeyboard()
let mouse = VirtualGamepadMouse()

await keyboard.connect()
try await keyboard.press(.a)
try await keyboard.setModifier(.leftShift, active: true)

await mouse.connect()
try await mouse.moveBy(x: 24, y: -8)
try await mouse.setButton(.left, pressed: true)
```

## License

MIT License — see [LICENSE](LICENSE) for details.

## Related

- [CoreOrbits Gamerpad](https://github.com/CoreOrbits/gamerpad_server_macos) — Full macOS server application

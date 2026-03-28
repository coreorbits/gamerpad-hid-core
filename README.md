# gamerpad-hid-core

CoreOrbits tabanında gamepad isimlendirmesiyle düzenlenmiş klavye ve fare odaklı sanal girdi paketi.

## What This Is

Bu paket şu anda gamepad adlandırma şeması altında klavye ve fare durumunu yöneten yüksek seviyeli sınıfları ve cihaz kimlik yardımcılarını içerir.

## Features

- `VirtualGamepadKeyboard` ile tuş ve modifier durumunu yönetir
- `VirtualGamepadMouse` ile konum, scroll ve buton durumunu yönetir
- `VirtualGamepadConfiguration` ile cihaz kimlik alanlarını üretir
- Ağ, UI ve platforma bağlı gerçek OS enjeksiyon kodu içermez

## Requirements

- macOS 15.0 veya sonrası
- Xcode 16 veya sonrası
- Swift 6.0 veya sonrası

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

- [CoreOrbits Gamerpad](https://github.com/CoreOrbits/gamerpad_server_macos) — Tam macOS sunucu uygulaması

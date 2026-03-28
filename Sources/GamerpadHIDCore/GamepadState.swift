// Copyright (c) 2026 CoreOrbits
// SPDX-License-Identifier: MIT

import Foundation

public struct GamepadState: Equatable, Sendable {
    public static let neutral = Self()

    public var leftX: Int8 = 0
    public var leftY: Int8 = 0
    public var rightX: Int8 = 0
    public var rightY: Int8 = 0
    public var leftTrigger: UInt8 = 0
    public var rightTrigger: UInt8 = 0
    public var buttons: UInt16 = 0

    public init() {}

    public mutating func setButton(_ index: Int, pressed: Bool) {
        let mask = UInt16(1 << index)
        if pressed {
            buttons |= mask
        } else {
            buttons &= ~mask
        }
    }

    public func isPressed(_ index: Int) -> Bool {
        (buttons & UInt16(1 << index)) != 0
    }
}

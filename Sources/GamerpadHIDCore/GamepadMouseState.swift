// Copyright (c) 2026 CoreOrbits
// SPDX-License-Identifier: MIT

import Foundation

public enum GamepadMouseButton: UInt8, CaseIterable, Sendable {
    case left = 0
    case right = 1
    case middle = 2
    case back = 3
    case forward = 4
}

public struct GamepadMouseState: Equatable, Sendable {
    public static let origin = Self()

    public var positionX: Int
    public var positionY: Int
    public var scrollX: Int
    public var scrollY: Int
    public var pressedButtons: Set<GamepadMouseButton>

    public init(
        positionX: Int = 0,
        positionY: Int = 0,
        scrollX: Int = 0,
        scrollY: Int = 0,
        pressedButtons: Set<GamepadMouseButton> = []
    ) {
        self.positionX = positionX
        self.positionY = positionY
        self.scrollX = scrollX
        self.scrollY = scrollY
        self.pressedButtons = pressedButtons
    }

    public mutating func moveBy(x: Int, y: Int) {
        positionX += x
        positionY += y
    }

    public mutating func scrollBy(x: Int, y: Int) {
        scrollX += x
        scrollY += y
    }

    public mutating func setButton(_ button: GamepadMouseButton, pressed: Bool) {
        if pressed {
            pressedButtons.insert(button)
        } else {
            pressedButtons.remove(button)
        }
    }

    public func isPressed(_ button: GamepadMouseButton) -> Bool {
        pressedButtons.contains(button)
    }

    public mutating func reset() {
        positionX = 0
        positionY = 0
        scrollX = 0
        scrollY = 0
        pressedButtons.removeAll()
    }
}

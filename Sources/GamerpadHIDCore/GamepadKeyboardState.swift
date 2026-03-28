// Copyright (c) 2026 CoreOrbits
// SPDX-License-Identifier: MIT

import Foundation

public enum GamepadKeyboardKey: UInt16, CaseIterable, Sendable {
    case a = 4
    case b = 5
    case c = 6
    case d = 7
    case e = 8
    case f = 9
    case g = 10
    case h = 11
    case i = 12
    case j = 13
    case k = 14
    case l = 15
    case m = 16
    case n = 17
    case o = 18
    case p = 19
    case q = 20
    case r = 21
    case s = 22
    case t = 23
    case u = 24
    case v = 25
    case w = 26
    case x = 27
    case y = 28
    case z = 29
    case one = 30
    case two = 31
    case three = 32
    case four = 33
    case five = 34
    case six = 35
    case seven = 36
    case eight = 37
    case nine = 38
    case zero = 39
    case returnOrEnter = 40
    case escape = 41
    case deleteOrBackspace = 42
    case tab = 43
    case space = 44
    case hyphen = 45
    case equalSign = 46
    case leftBracket = 47
    case rightBracket = 48
    case backslash = 49
    case semicolon = 51
    case quote = 52
    case graveAccent = 53
    case comma = 54
    case period = 55
    case slash = 56
    case capsLock = 57
    case f1 = 58
    case f2 = 59
    case f3 = 60
    case f4 = 61
    case f5 = 62
    case f6 = 63
    case f7 = 64
    case f8 = 65
    case f9 = 66
    case f10 = 67
    case f11 = 68
    case f12 = 69
    case rightArrow = 79
    case leftArrow = 80
    case downArrow = 81
    case upArrow = 82
}

public struct GamepadKeyboardModifiers: OptionSet, Sendable, Hashable {
    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public static let leftControl = GamepadKeyboardModifiers(rawValue: 1 << 0)
    public static let leftShift = GamepadKeyboardModifiers(rawValue: 1 << 1)
    public static let leftAlt = GamepadKeyboardModifiers(rawValue: 1 << 2)
    public static let leftCommand = GamepadKeyboardModifiers(rawValue: 1 << 3)
    public static let rightControl = GamepadKeyboardModifiers(rawValue: 1 << 4)
    public static let rightShift = GamepadKeyboardModifiers(rawValue: 1 << 5)
    public static let rightAlt = GamepadKeyboardModifiers(rawValue: 1 << 6)
    public static let rightCommand = GamepadKeyboardModifiers(rawValue: 1 << 7)
}

public struct GamepadKeyboardState: Equatable, Sendable {
    public static let empty = Self()

    public var pressedKeys: Set<GamepadKeyboardKey>
    public var modifiers: GamepadKeyboardModifiers

    public init(
        pressedKeys: Set<GamepadKeyboardKey> = [],
        modifiers: GamepadKeyboardModifiers = []
    ) {
        self.pressedKeys = pressedKeys
        self.modifiers = modifiers
    }

    public mutating func press(_ key: GamepadKeyboardKey) {
        pressedKeys.insert(key)
    }

    public mutating func release(_ key: GamepadKeyboardKey) {
        pressedKeys.remove(key)
    }

    public func isPressed(_ key: GamepadKeyboardKey) -> Bool {
        pressedKeys.contains(key)
    }

    public mutating func setModifier(_ modifier: GamepadKeyboardModifiers, active: Bool) {
        if active {
            modifiers.insert(modifier)
        } else {
            modifiers.remove(modifier)
        }
    }

    public mutating func reset() {
        pressedKeys.removeAll()
        modifiers = []
    }
}

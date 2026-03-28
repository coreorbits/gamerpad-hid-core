// Copyright (c) 2026 CoreOrbits
// SPDX-License-Identifier: MIT

import Foundation

public enum VirtualGamepadError: LocalizedError {
    case deviceNotConnected

    public var errorDescription: String? {
        switch self {
        case .deviceNotConnected:
            return "The virtual input device is not connected."
        }
    }
}

public final class VirtualGamepadKeyboard: Sendable {
    private let configuration: VirtualGamepadConfiguration
    private let storage = GamepadKeyboardStorage()

    public init(configuration: VirtualGamepadConfiguration = .keyboardDefault) {
        self.configuration = configuration.resolved()
    }

    public func connect() async {
        await storage.connect()
    }

    public func send(state: GamepadKeyboardState) async throws {
        try await storage.update(state: state)
    }

    public func press(_ key: GamepadKeyboardKey) async throws {
        try await storage.mutate { state in
            state.press(key)
        }
    }

    public func release(_ key: GamepadKeyboardKey) async throws {
        try await storage.mutate { state in
            state.release(key)
        }
    }

    public func setModifier(_ modifier: GamepadKeyboardModifiers, active: Bool) async throws {
        try await storage.mutate { state in
            state.setModifier(modifier, active: active)
        }
    }

    public func currentState() async -> GamepadKeyboardState {
        await storage.currentState()
    }

    public func resolvedConfiguration() -> VirtualGamepadConfiguration {
        configuration
    }

    public func isConnected() async -> Bool {
        await storage.isConnected()
    }

    public func disconnect() async {
        await storage.disconnect()
    }
}

private actor GamepadKeyboardStorage {
    private var connected = false
    private var state = GamepadKeyboardState.empty

    func connect() {
        connected = true
    }

    func update(state: GamepadKeyboardState) throws {
        guard connected else {
            throw VirtualGamepadError.deviceNotConnected
        }

        self.state = state
    }

    func mutate(_ body: (inout GamepadKeyboardState) -> Void) throws {
        guard connected else {
            throw VirtualGamepadError.deviceNotConnected
        }

        body(&state)
    }

    func currentState() -> GamepadKeyboardState {
        state
    }

    func isConnected() -> Bool {
        connected
    }

    func disconnect() {
        connected = false
        state.reset()
    }
}

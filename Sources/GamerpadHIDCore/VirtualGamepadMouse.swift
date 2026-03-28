// Copyright (c) 2026 CoreOrbits
// SPDX-License-Identifier: MIT

import Foundation

public final class VirtualGamepadMouse: Sendable {
    private let configuration: VirtualGamepadConfiguration
    private let storage = GamepadMouseStorage()

    public init(configuration: VirtualGamepadConfiguration = .mouseDefault) {
        self.configuration = configuration.resolved()
    }

    public func connect() async {
        await storage.connect()
    }

    public func send(state: GamepadMouseState) async throws {
        try await storage.update(state: state)
    }

    public func moveBy(x: Int, y: Int) async throws {
        try await storage.mutate { state in
            state.moveBy(x: x, y: y)
        }
    }

    public func scrollBy(x: Int, y: Int) async throws {
        try await storage.mutate { state in
            state.scrollBy(x: x, y: y)
        }
    }

    public func setButton(_ button: GamepadMouseButton, pressed: Bool) async throws {
        try await storage.mutate { state in
            state.setButton(button, pressed: pressed)
        }
    }

    public func currentState() async -> GamepadMouseState {
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

private actor GamepadMouseStorage {
    private var connected = false
    private var state = GamepadMouseState.origin

    func connect() {
        connected = true
    }

    func update(state: GamepadMouseState) throws {
        guard connected else {
            throw VirtualGamepadError.deviceNotConnected
        }

        self.state = state
    }

    func mutate(_ body: (inout GamepadMouseState) -> Void) throws {
        guard connected else {
            throw VirtualGamepadError.deviceNotConnected
        }

        body(&state)
    }

    func currentState() -> GamepadMouseState {
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

import Testing
@testable import GamerpadHIDCore

struct VirtualGamepadIOTests {

    @Test
    func keyboardTracksPressedKeysAndModifiers() async throws {
        let keyboard = VirtualGamepadKeyboard()
        await keyboard.connect()

        try await keyboard.press(.a)
        try await keyboard.setModifier(.leftShift, active: true)

        let state = await keyboard.currentState()

        #expect(state.isPressed(.a))
        #expect(state.modifiers.contains(.leftShift))
    }

    @Test
    func mouseTracksMovementScrollAndButtons() async throws {
        let mouse = VirtualGamepadMouse()
        await mouse.connect()

        try await mouse.moveBy(x: 12, y: -4)
        try await mouse.scrollBy(x: 0, y: 2)
        try await mouse.setButton(.left, pressed: true)

        let state = await mouse.currentState()

        #expect(state.positionX == 12)
        #expect(state.positionY == -4)
        #expect(state.scrollY == 2)
        #expect(state.isPressed(.left))
    }

    @Test
    func inputConfigurationDefaultsDifferPerDeviceType() {
        #expect(VirtualGamepadConfiguration.keyboardDefault.productID != VirtualGamepadConfiguration.mouseDefault.productID)
        #expect(VirtualGamepadConfiguration.keyboardDefault.productName != VirtualGamepadConfiguration.mouseDefault.productName)
    }
}

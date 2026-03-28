// Copyright (c) 2026 CoreOrbits
// SPDX-License-Identifier: MIT

import Foundation

public struct VirtualGamepadConfiguration: Sendable, Hashable {
    public let vendorID: Int
    public let productID: Int
    public let productName: String
    public let manufacturer: String
    public let modelNumber: String
    public let versionNumber: Int
    public let serialNumber: String?
    public let uniqueID: String?
    public let locationID: Int?
    public let idleTimeout: Duration?

    public init(
        vendorID: Int = 0x1D50,
        productID: Int = 0x6200,
        productName: String = "CoreOrbits Virtual Input",
        manufacturer: String = "CoreOrbits",
        modelNumber: String = "COVI-MAC-01",
        versionNumber: Int = 1,
        serialNumber: String? = nil,
        uniqueID: String? = nil,
        locationID: Int? = nil,
        idleTimeout: Duration? = nil
    ) {
        self.vendorID = vendorID
        self.productID = productID
        self.productName = productName
        self.manufacturer = manufacturer
        self.modelNumber = modelNumber
        self.versionNumber = versionNumber
        self.serialNumber = serialNumber
        self.uniqueID = uniqueID
        self.locationID = locationID
        self.idleTimeout = idleTimeout
    }

    public static let `default` = VirtualGamepadConfiguration()

    public static let keyboardDefault = VirtualGamepadConfiguration(
        productID: 0x6201,
        productName: "CoreOrbits Virtual Keyboard",
        modelNumber: "COVK-MAC-01"
    )

    public static let mouseDefault = VirtualGamepadConfiguration(
        productID: 0x6202,
        productName: "CoreOrbits Virtual Mouse",
        modelNumber: "COVM-MAC-01"
    )

    func resolved() -> VirtualGamepadConfiguration {
        if serialNumber != nil, uniqueID != nil, locationID != nil {
            return self
        }

        let seed = UUID().uuidString
        let digest = Self.stableIdentifierDigest(seed)

        return VirtualGamepadConfiguration(
            vendorID: vendorID,
            productID: productID,
            productName: productName,
            manufacturer: manufacturer,
            modelNumber: modelNumber,
            versionNumber: versionNumber,
            serialNumber: serialNumber ?? "COVI-\(digest)",
            uniqueID: uniqueID ?? "com.coreorbits.virtualinput.\(digest.lowercased())",
            locationID: locationID ?? Self.locationID(from: digest),
            idleTimeout: idleTimeout
        )
    }

    private static func stableIdentifierDigest(_ value: String) -> String {
        var hash: UInt64 = 0xcbf29ce484222325
        for byte in value.utf8 {
            hash ^= UInt64(byte)
            hash &*= 0x100000001b3
        }

        return String(format: "%016llX", hash)
    }

    private static func locationID(from digest: String) -> Int {
        let suffix = digest.suffix(8)
        let value = UInt32(suffix, radix: 16) ?? 1
        return Int(max(value, 1))
    }
}

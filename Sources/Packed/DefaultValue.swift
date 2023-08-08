import Foundation

protocol DefaultValue {
    static func defaultValue() -> Self
}

extension Int8: DefaultValue {
    static func defaultValue() -> Int8 { return 0 }
}

extension Int16: DefaultValue {
    static func defaultValue() -> Int16 { return 0 }
}

extension Int32: DefaultValue {
    static func defaultValue() -> Int32 { return 0 }
}

extension Int64: DefaultValue {
    static func defaultValue() -> Int64 { return 0 }
}

extension UInt8: DefaultValue {
    static func defaultValue() -> UInt8 { return 0 }
}

extension UInt16: DefaultValue {
    static func defaultValue() -> UInt16 { return 0 }
}

extension UInt32: DefaultValue {
    static func defaultValue() -> UInt32 { return 0 }
}

extension UInt64: DefaultValue {
    static func defaultValue() -> UInt64 { return 0 }
}

extension String: DefaultValue {
    static func defaultValue() -> String { return "" }
}

extension Bool: DefaultValue {
    static func defaultValue() -> Bool { return false }
}

extension Float: DefaultValue {
    static func defaultValue() -> Float { return 0.0 }
}

extension Double: DefaultValue {
    static func defaultValue() -> Double { return 0.0 }
}

extension UUID: DefaultValue {
    static func defaultValue() -> UUID { return UUID() }
}

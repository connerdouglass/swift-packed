import Foundation

public protocol DefaultValue {
    static func defaultValue() -> Self
}

extension Int8: DefaultValue {
    public static func defaultValue() -> Int8 { return 0 }
}

extension Int16: DefaultValue {
    public static func defaultValue() -> Int16 { return 0 }
}

extension Int32: DefaultValue {
    public static func defaultValue() -> Int32 { return 0 }
}

extension Int64: DefaultValue {
    public static func defaultValue() -> Int64 { return 0 }
}

extension UInt8: DefaultValue {
    public static func defaultValue() -> UInt8 { return 0 }
}

extension UInt16: DefaultValue {
    public static func defaultValue() -> UInt16 { return 0 }
}

extension UInt32: DefaultValue {
    public static func defaultValue() -> UInt32 { return 0 }
}

extension UInt64: DefaultValue {
    public static func defaultValue() -> UInt64 { return 0 }
}

extension String: DefaultValue {
    public static func defaultValue() -> String { return "" }
}

extension Bool: DefaultValue {
    public static func defaultValue() -> Bool { return false }
}

extension Float: DefaultValue {
    public static func defaultValue() -> Float { return 0.0 }
}

extension Double: DefaultValue {
    public static func defaultValue() -> Double { return 0.0 }
}

extension UUID: DefaultValue {
    public static func defaultValue() -> UUID { return UUID() }
}

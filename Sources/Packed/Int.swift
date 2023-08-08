import Foundation

public func PackedUInt8(_ value: inout UInt8) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: { return [ptr.pointee] },
            decode: { buf in
                if buf.count < 1 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = buf[buf.startIndex]
                return 1
            }
        )
    }
}

public func PackedUInt16(_ value: inout UInt16) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 2)
                LEPutUInt16(&buf[0...], value: ptr.pointee)
                return buf
            },
            decode: { buf in
                if buf.count < 2 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = LEGetUInt16(buf[buf.startIndex...])
                return 2
            }
        )
    }
}

public func PackedUInt32(_ value: inout UInt32) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 4)
                LEPutUInt32(&buf[0...], value: ptr.pointee)
                return buf
            },
            decode: { buf in
                if buf.count < 4 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = LEGetUInt32(buf[buf.startIndex...])
                return 4
            }
        )
    }
}

public func PackedUInt64(_ value: inout UInt64) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 8)
                LEPutUInt64(&buf[0...], value: ptr.pointee)
                return buf
            },
            decode: { buf in
                if buf.count < 8 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = LEGetUInt64(buf[buf.startIndex...])
                return 8
            }
        )
    }
}

public func PackedInt8(_ value: inout Int8) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: { return [UInt8(bitPattern: ptr.pointee)] },
            decode: { buf in
                if buf.count < 1 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Int8(bitPattern: buf[buf.startIndex])
                return 1
            }
        )
    }
}

public func PackedInt16(_ value: inout Int16) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 2)
                LEPutUInt16(&buf[0...], value: UInt16(bitPattern: ptr.pointee))
                return buf
            },
            decode: { buf in
                if buf.count < 2 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Int16(bitPattern: LEGetUInt16(buf[buf.startIndex...]))
                return 2
            }
        )
    }
}

public func PackedInt32(_ value: inout Int32) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 4)
                LEPutUInt32(&buf[0...], value: UInt32(bitPattern: ptr.pointee))
                return buf
            },
            decode: { buf in
                if buf.count < 4 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Int32(bitPattern: LEGetUInt32(buf[buf.startIndex...]))
                return 4
            }
        )
    }
}

public func PackedInt64(_ value: inout Int64) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 8)
                LEPutUInt64(&buf[0...], value: UInt64(bitPattern: ptr.pointee))
                return buf
            },
            decode: { buf in
                if buf.count < 8 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Int64(bitPattern: LEGetUInt64(buf[buf.startIndex...]))
                return 8
            }
        )
    }
}

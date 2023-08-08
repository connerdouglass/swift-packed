import Foundation

// PackedFloat32 represents a 32-bit Float value. The encoded value is the IEEE 754 binary representation of the Float.
public func PackedFloat32(_ value: inout Float) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 4)
                LEPutUInt32(&buf[0...], value: UInt32(littleEndian: ptr.pointee.bitPattern))
                return buf
            },
            decode: { buf in
                if buf.count < 4 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Float(bitPattern: LEGetUInt32(buf[buf.startIndex...]))
                return 4
            }
        )
    }
}

// PackedFloat64 represents a 64-bit Float value. The encoded value is the IEEE 754 binary representation of the Double.
public func PackedFloat64(_ value: inout Double) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 8)
                LEPutUInt64(&buf[0...], value: UInt64(littleEndian: ptr.pointee.bitPattern))
                return buf
            },
            decode: { buf in
                if buf.count < 8 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Double(bitPattern: LEGetUInt64(buf[buf.startIndex...]))
                return 8
            }
        )
    }
}

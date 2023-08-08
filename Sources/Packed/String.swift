import Foundation

// PackedString represents a string value. The first two bytes of an encoded string is the length
// of the string. The remaining bytes encode the string.
public func PackedString(_ value: inout String) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 2)
                LEPutUInt16(&buf[0...], value: UInt16(ptr.pointee.utf8.count))
                buf += ptr.pointee.utf8
                return buf
            },
            decode: { buf in
                if buf.count < 2 {
                    throw PackedError.InvalidLength
                }
                let strLen = Int(LEGetUInt16(buf[buf.startIndex...]))
                if buf.count < 2+strLen {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = String(
                    bytes: buf[(buf.startIndex+2)..<(buf.startIndex+2+strLen)],
                    encoding: .utf8
                )!
                return 2 + strLen
            }
        )
    }
}

// PackedString256 represents a string value up to 256 characters in length. The first byte of an encoded string is the length
// of the string. The remaining bytes encode the string.
public func PackedString256(_ value: inout String) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 1)
                buf[0] = UInt8(ptr.pointee.utf8.count)
                buf += ptr.pointee.utf8
                return buf
            },
            decode: { buf in
                if buf.count < 1 {
                    throw PackedError.InvalidLength
                }
                let strLen = Int(buf[buf.startIndex])
                if buf.count < 1+strLen {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = String(
                    bytes: buf[(buf.startIndex+1)..<(buf.startIndex+1+strLen)],
                    encoding: .utf8
                )!
                return 1 + strLen
            }
        )
    }
}

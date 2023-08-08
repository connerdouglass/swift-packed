import Foundation

// PackedBool represents a boolean value. The encoded value is 0 if false, and 1 if true.
public func PackedBool(_ value: inout Bool) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: { return [ptr.pointee ? 1 : 0] },
            decode: { buf in
                if buf.count < 1 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = buf[buf.startIndex] != 0
                return 1
            }
        )
    }
}

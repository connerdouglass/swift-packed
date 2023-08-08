import Foundation

public func PackedTime(_ value: inout Date) -> Packed {
    return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                var buf = [UInt8](repeating: 0, count: 8)
                LEPutUInt64(&buf[0...], value: UInt64(ptr.pointee.timeIntervalSince1970))
                return buf
            },
            decode: { buf in
                if buf.count < 8 {
                    throw PackedError.InvalidLength
                }
                ptr.pointee = Date(timeIntervalSince1970: TimeInterval(LEGetUInt64(buf[buf.startIndex...])))
                return 8
            }
        )
    }
}

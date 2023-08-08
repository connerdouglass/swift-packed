import Foundation

public func PackedUUID(_ value: inout UUID) -> Packed {
        return withUnsafeMutablePointer(to: &value) { ptr in
        return NewEncodeDecode(
            encode: {
                let (
                    b0, b1, b2, b3,
                    b4, b5, b6, b7,
                    b8, b9, b10, b11,
                    b12, b13, b14, b15
                ) = ptr.pointee.uuid
                return [
                    b0, b1, b2, b3,
                    b4, b5, b6, b7,
                    b8, b9, b10, b11,
                    b12, b13, b14, b15
                ]
            },
            decode: { buf in
                if buf.count < 16 {
                    throw PackedError.InvalidLength
                }
                let uuid_tValue = (
                    buf[0], buf[1], buf[2], buf[3],
                    buf[4], buf[5], buf[6], buf[7],
                    buf[8 ], buf[9], buf[10], buf[11],
                    buf[12], buf[13], buf[14], buf[15]
                )
                ptr.pointee = UUID(uuid: uuid_tValue)
                return 16
            }
        )
    }
}

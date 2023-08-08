import Foundation

// PackedSlice represents a slice of values. The first byte of an encoded slice is the length of the slice.
func PackedSlice<T: DefaultValue>(children: @escaping PackedType<T>) -> PackedType<[T]> {
    return { value in
        return withUnsafeMutablePointer(to: &value) { ptr in
            return NewEncodeDecode(
                encode: {
                    // Create the buffer with the number of entries
                    var buf = [UInt8](repeating: 0, count: 1)
                    buf[0] = UInt8(ptr.pointee.count)

                    // Encode the children
                    for item in ptr.pointee {
                        var child = item
                        buf += children(&child).encode()
                    }
                    return buf
                },
                decode: { buf in
                    if buf.count < 1 {
                        throw PackedError.InvalidLength
                    }

                    // Read the number of entries
                    var cursor = 0
                    let length = Int(buf[buf.startIndex])
                    cursor += 1

                    // Create the array
                    ptr.pointee = [T]()
                    for _ in 0..<length {
                        // Decode the child value
                        var val = T.defaultValue()
                        let n = try children(&val).decode(buf: buf[(buf.startIndex+cursor)...])
                        cursor += n

                        // Add the key and value to the map
                        ptr.pointee.append(val)
                    }

                    return cursor
                }
            )
        }
    }
}

// PackedArray represents an array of values. The encoded values are concatenated. Although this can technically be used
// with slices, you should only use it if the length is truly fixed, and known at compile time.
func PackedArray<T: DefaultValue>(children: @escaping PackedType<T>) -> PackedType<[T]> {
    return { value in
        let size = value.count
        return withUnsafeMutablePointer(to: &value) { ptr in
            return NewEncodeDecode(
                encode: {
                    // Create the empty buffer
                    var buf: [UInt8] = []

                    // Encode the children
                    for i in 0..<size {
                        buf += children(&ptr.pointee[i]).encode()
                    }
                    return buf
                },
                decode: { buf in
                    // Read the number of entries
                    var cursor = 0

                    // Create the array
                    ptr.pointee = [T](repeating: T.defaultValue(), count: size)
                    for i in 0..<size {
                        // Decode the child value
                        var val = T.defaultValue()
                        let n = try children(&val).decode(buf: buf[(buf.startIndex+cursor)...])
                        cursor += n

                        // Add the key and value to the map
                        ptr.pointee[i] = val
                    }

                    return cursor
                }
            )
        }
    }
}

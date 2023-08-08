import Foundation

// PackedMap represents a map. The encoded value is a sequence of key-value pairs, where each key and value
// is encoded using the provided key and value type encoders.
public func PackedMap<K: DefaultValue, V: DefaultValue>(keys: @escaping PackedType<K>, values: @escaping PackedType<V>) -> PackedType<[K: V]> {
    return { value in
        return withUnsafeMutablePointer(to: &value) { ptr in
            return NewEncodeDecode(
                encode: {
                    // Create the buffer with the number of entries
                    var buf = [UInt8](repeating: 0, count: 1)
                    buf[0] = UInt8(ptr.pointee.count)

                    // Encode the keys and values
                    for (k, v) in ptr.pointee {
                        var key = k
                        var val = v
                        buf += keys(&key).encode()
                        buf += values(&val).encode()
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

                    // Create the map
                    ptr.pointee = [K: V](minimumCapacity: length)
                    for _ in 0..<length {
                        // Decode the key
                        var k = K.defaultValue()
                        var n = try keys(&k).decode(buf: buf[(buf.startIndex+cursor)...])
                        cursor += n

                        // Decode the value
                        var v = V.defaultValue()
                        n = try values(&v).decode(buf: buf[(buf.startIndex+cursor)...])
                        cursor += n

                        // Add the key and value to the map
                        ptr.pointee[k] = v
                    }

                    return cursor
                }
            )
        }
    }
}
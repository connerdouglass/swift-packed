import Foundation

// PackedType is a function that can bind to a pointer and encode or decode it.
public typealias PackedType<T> = (inout T) -> Packed

// Packed is a value that can be encoded and decoded.
public protocol Packed {
    func encode() -> [UInt8]
    func decode(buf: ArraySlice<UInt8>) throws -> Int
}

// PackedSequence creates a Packed that can encode and decode sequences of values.
public func PackedSequence(_ fields: Packed...) -> Packed {
    return packedSequence(fields: fields)
}

class packedSequence: Packed {
    var fields: [Packed]
    init(fields: [Packed]) {
        self.fields = fields
    }
    func encode() -> [UInt8] {
        var buf = [UInt8]()
        for field in fields {
            buf += field.encode()
        }
        return buf
    }
    func decode(buf: ArraySlice<UInt8>) throws -> Int {
        var offset = 0
        for field in fields {
            offset += try field.decode(buf: buf[(buf.startIndex+offset)...])
        }
        return offset
    }
}

// NewEncodeDecode creates a Packed that can encode and decode values using the provided functions.
public func NewEncodeDecode(
    encode: @escaping () -> [UInt8],
    decode: @escaping (ArraySlice<UInt8>) throws -> Int
) -> Packed {
    return packedFuncs(encode: encode, decode: decode)
}

class packedFuncs: Packed {
    var encodeFunc: () -> [UInt8]
    var decodeFunc: (ArraySlice<UInt8>) throws -> Int
    init(
        encode: @escaping () -> [UInt8],
        decode: @escaping (ArraySlice<UInt8>) throws -> Int
    ) {
        self.encodeFunc = encode
        self.decodeFunc = decode
    }
    func encode() -> [UInt8] {
        return self.encodeFunc()
    }
    func decode(buf: ArraySlice<UInt8>) throws -> Int {
        return try self.decodeFunc(buf)
    }
}

# swift-packed

Swift library for packing and unpacking structured data to a binary format.


## Examples

For these examples, assume the following type:

```swift
class User {
    var firstName: String
    var lastName: String
    var age: UInt8
    var birthYear: UInt16
    var socialLinks: [String]

    init(...) {...}

    func packed() -> Packed {
        return PackedSequence(
            PackedString(&self.firstName),
            PackedString(&self.lastName),
            PackedUInt8(&self.age),
            PackedUInt16(&self.birthYear),
            PackedSlice(children: PackedString)(&self.socialLinks),
        )
    }
}
```

### Encode

```swift
var user = User(
    firstName: "John",
    lastName: "Doe",
    age: 32,
    birthYear: 1991,
    socialLinks: [
        "https://facebook.com/johndoe",
        "https://twitter.com/johndoe",
    ]
)

// Pack the user data to a byte array
let encodedBytes = user.packed().encode()
```

### Decode

```swift
var decodedUser = User(...)

// Unpack the encoded data to the user struct
try decodedUser.packed().decode(encodedBytes)

decodedUser.firstName // => "John"
decodedUser.lastName // => "Doe"
decodedUser.age // => 32
```

## Nesting Packed Types

You can encode and decode types that contain other types.

```swift
class Rectangle {
    var size: Size
    var color: Color

    init(...) {...}

    func packed() -> Packed {
        return PackedSequence(
            self.size.packed(),
            self.color.packed(),
        )
    }
}

class Size {
    var width: Int32
    var height: Int32

    init(...) {...}

    func packed() -> Packed {
        return PackedSequence(
            PackedInt32(&self.width),
            PackedInt32(&self.height),
        )
    }
}

class Color {
    var r: UInt8
    var g: UInt8
    var b: UInt8
    var a: UInt8

    init(...) {...}

    func packed() -> Packed {
        return PackedSequence(
            PackedUInt8(&self.r),
            PackedUInt8(&self.g),
            PackedUInt8(&self.b),
            PackedUInt8(&self.a),
        )
    }
}
``` 

## Why use this?

This packed format is smaller and faster to encode and decode than JSON. If you're sending messages rapidly over the network, such as in a multiplayer video game or other realtime application, it can be useful to use a packed format to reduce latency.

## Why shouldn't you use this?

There are drawbacks. When transmitting packed data, both the sender and recipient need to be aware of the structure of the data. There's no metadata embedded in the encoded data. If the sender and recipient don't agree on the format, the recipient will not be able to make sense of the data.

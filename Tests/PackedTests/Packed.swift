import XCTest
@testable import Packed

final class PackedTests: XCTestCase {

    func testEncodeDecode() {
        let input = ExampleMessage()
        let encoded = input.packed().encode()

        let output = ExampleMessage()
        var n: Int?
        XCTAssertNoThrow(n = try output.packed().decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)

        XCTAssertEqual(output.value, input.value)
    }

    func testNestedTypes() {
        let input = Rectangle(
            size: Size(width: 100, height: 200),
            color: Color(red: 255, green: 127, blue: 0, alpha: 255)
        )
        let encoded = input.packed().encode()

        let output = Rectangle()
        var n: Int?
        XCTAssertNoThrow(n = try output.packed().decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)

        XCTAssertEqual(output.size.width, input.size.width)
        XCTAssertEqual(output.size.height, input.size.height)

        XCTAssertEqual(output.color.red, input.color.red)
        XCTAssertEqual(output.color.green, input.color.green)
        XCTAssertEqual(output.color.blue, input.color.blue)
        XCTAssertEqual(output.color.alpha, input.color.alpha)
    }

}

private class ExampleMessage {
    var value: UInt16 = 1234

    func packed() -> Packed {
        return PackedSequence(
            PackedUInt16(&self.value)
        )
    }
}

private class Rectangle {
    var size: Size
    var color: Color

    init() {
        self.size = Size()
        self.color = Color()
    }

    init(size: Size, color: Color) {
        self.size = size
        self.color = color
    }

    func packed() -> Packed {
        return PackedSequence(
            self.size.packed(),
            self.color.packed()
        )
    }
}

private class Color {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    var alpha: UInt8

    init() {
        self.red = 0
        self.green = 0
        self.blue = 0
        self.alpha = 0
    }

    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    func packed() -> Packed {
        return PackedSequence(
            PackedUInt8(&self.red),
            PackedUInt8(&self.green),
            PackedUInt8(&self.blue),
            PackedUInt8(&self.alpha)
        )
    }
}

private class Size {
    var width: Int32
    var height: Int32

    init() {
        self.width = 0
        self.height = 0
    }

    init(width: Int32, height: Int32) {
        self.width = width
        self.height = height
    }

    func packed() -> Packed {
        return PackedSequence(
            PackedInt32(&self.width),
            PackedInt32(&self.height)
        )
    }
}



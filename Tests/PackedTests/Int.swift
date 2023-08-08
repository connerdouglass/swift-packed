import XCTest
@testable import Packed

final class IntTests: XCTestCase {

    func testPackedUInt8() {
        var input: UInt8 = 0x12
        let encoded = PackedUInt8(&input).encode()
        XCTAssertEqual(encoded.count, 1)
        XCTAssertEqual(encoded, [0x12])

        var output: UInt8 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedUInt8(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x12)
    }

    func testPackedUInt16() {
        var input: UInt16 = 0x1234
        let encoded = PackedUInt16(&input).encode()
        XCTAssertEqual(encoded.count, 2)
        XCTAssertEqual(encoded, [0x34, 0x12])

        var output: UInt16 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedUInt16(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x1234)
    }

    func testPackedUInt32() {
        var input: UInt32 = 0x12345678
        let encoded = PackedUInt32(&input).encode()
        XCTAssertEqual(encoded.count, 4)
        XCTAssertEqual(encoded, [0x78, 0x56, 0x34, 0x12])

        var output: UInt32 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedUInt32(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x12345678)
    }

    func testPackedUInt64() {
        var input: UInt64 = 0x0123456789ABCDEF
        let encoded = PackedUInt64(&input).encode()
        XCTAssertEqual(encoded.count, 8)
        XCTAssertEqual(encoded, [0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01])

        var output: UInt64 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedUInt64(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x0123456789ABCDEF)
    }

    func testPackedInt8() {
        var input: Int8 = 0x12
        let encoded = PackedInt8(&input).encode()
        XCTAssertEqual(encoded.count, 1)
        XCTAssertEqual(encoded, [0x12])

        var output: Int8 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt8(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x12)
    }

    func testPackedInt16() {
        var input: Int16 = 0x1234
        let encoded = PackedInt16(&input).encode()
        XCTAssertEqual(encoded.count, 2)
        XCTAssertEqual(encoded, [0x34, 0x12])

        var output: Int16 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt16(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x1234)
    }

    func testPackedInt32() {
        var input: Int32 = 0x12345678
        let encoded = PackedInt32(&input).encode()
        XCTAssertEqual(encoded.count, 4)
        XCTAssertEqual(encoded, [0x78, 0x56, 0x34, 0x12])

        var output: Int32 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt32(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x12345678)
    }

    func testPackedInt64() {
        var input: Int64 = 0x0123456789ABCDEF
        let encoded = PackedInt64(&input).encode()
        XCTAssertEqual(encoded.count, 8)
        XCTAssertEqual(encoded, [0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01])

        var output: Int64 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt64(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 0x0123456789ABCDEF)
    }

    func testPackedInt8Negative() {
        var input: Int8 = -0x12
        let encoded = PackedInt8(&input).encode()
        XCTAssertEqual(encoded.count, 1)
        // XCTAssertEqual(encoded, [0x12])

        var output: Int8 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt8(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, -0x12)
    }

    func testPackedInt16Negative() {
        var input: Int16 = -0x1234
        let encoded = PackedInt16(&input).encode()
        XCTAssertEqual(encoded.count, 2)
        // XCTAssertEqual(encoded, [0x34, 0x12])

        var output: Int16 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt16(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, -0x1234)
    }

    func testPackedInt32Negative() {
        var input: Int32 = -0x12345678
        let encoded = PackedInt32(&input).encode()
        XCTAssertEqual(encoded.count, 4)
        // XCTAssertEqual(encoded, [0x78, 0x56, 0x34, 0x12])

        var output: Int32 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt32(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, -0x12345678)
    }

    func testPackedInt64Negative() {
        var input: Int64 = -0x0123456789ABCDEF
        let encoded = PackedInt64(&input).encode()
        XCTAssertEqual(encoded.count, 8)
        // XCTAssertEqual(encoded, [0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01])

        var output: Int64 = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedInt64(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, -0x0123456789ABCDEF)
    }

}

import XCTest
@testable import Packed

final class ArrayTests: XCTestCase {

    func testSlice() {
        var input: [UInt16] = [1, 2, 3]
        let encoded = PackedSlice(children: PackedUInt16)(&input).encode()
        XCTAssertEqual(encoded.count, 7)

        var output: [UInt16] = []
        var n: Int?
        XCTAssertNoThrow(n = try PackedSlice(children: PackedUInt16)(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output.count, 3)
        XCTAssertEqual(output, [1, 2, 3])
    }

    func testSliceEmpty() {
        var input: [UInt16] = []
        let encoded = PackedSlice(children: PackedUInt16)(&input).encode()
        XCTAssertEqual(encoded.count, 1)

        var output: [UInt16] = [1, 2, 3, 4, 5]
        var n: Int?
        XCTAssertNoThrow(n = try PackedSlice(children: PackedUInt16)(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output.count, 0)
        XCTAssertEqual(output, [])
    }

    func testArray() {
        var input: [UInt16] = [1, 2, 3, 4, 5]
        let encoded = PackedArray(children: PackedUInt16)(&input).encode()
        XCTAssertEqual(encoded.count, 10)

        var output: [UInt16] = [0, 0, 0, 0, 0]
        var n: Int?
        XCTAssertNoThrow(n = try PackedArray(children: PackedUInt16)(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output.count, 5)
        XCTAssertEqual(output, [1, 2, 3, 4, 5])
    }

}

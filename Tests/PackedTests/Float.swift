import XCTest
@testable import Packed

final class FloatTests: XCTestCase {

    func testFloat32() {
        var input: Float = 123.456
        let encoded = PackedFloat32(&input).encode()
        XCTAssertEqual(encoded.count, 4)

        var output: Float = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedFloat32(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 123.456)
    }

    func testFloat64() {
        var input: Double = 123.456
        let encoded = PackedFloat64(&input).encode()
        XCTAssertEqual(encoded.count, 8)

        var output: Double = 0
        var n: Int?
        XCTAssertNoThrow(n = try PackedFloat64(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, 123.456)
    }

}

import XCTest
@testable import Packed

final class BoolTests: XCTestCase {

    func testTrue() {
        var input = true
        let encoded = PackedBool(&input).encode()
        XCTAssertEqual(encoded.count, 1)

        var output = false
        var n: Int?
        XCTAssertNoThrow(n = try PackedBool(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, true)
    }

    func testFalse() {
        var input = false
        let encoded = PackedBool(&input).encode()
        XCTAssertEqual(encoded.count, 1)

        var output = true
        var n: Int?
        XCTAssertNoThrow(n = try PackedBool(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, false)
    }

}

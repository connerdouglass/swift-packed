import XCTest
@testable import Packed

final class StringTests: XCTestCase {

    func testString() {
        var input = "Hello World!"
        let encoded = PackedString(&input).encode()
        XCTAssertEqual(encoded.count, 2+input.utf8.count)
        XCTAssertEqual(encoded, [UInt8(input.utf8.count), 0] + input.utf8)

        var output: String = ""
        var n: Int?
        XCTAssertNoThrow(n = try PackedString(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, "Hello World!")
    }

    func testString256() {
        var input = "Hello World! Test 256"
        let encoded = PackedString256(&input).encode()
        XCTAssertEqual(encoded.count, 1+input.utf8.count)
        XCTAssertEqual(encoded, [UInt8(input.utf8.count)] + input.utf8)

        var output: String = ""
        var n: Int?
        XCTAssertNoThrow(n = try PackedString256(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, "Hello World! Test 256")
    }

}

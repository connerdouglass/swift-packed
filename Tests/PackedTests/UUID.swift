import XCTest
@testable import Packed

final class UUIDTests: XCTestCase {

    func testUUID() {
        var input = UUID()
        let encoded = PackedUUID(&input).encode()
        XCTAssertEqual(encoded.count, 16)

        var output = UUID()
        var n: Int?
        XCTAssertNoThrow(n = try PackedUUID(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output, input)
    }

}

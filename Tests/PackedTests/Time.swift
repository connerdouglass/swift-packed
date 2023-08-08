import XCTest
@testable import Packed

final class TimeTests: XCTestCase {

    func testTime() {
        var input = Date()
        let encoded = PackedTime(&input).encode()
        XCTAssertEqual(encoded.count, 8)

        var output = Date().addingTimeInterval(3600)
        var n: Int?
        XCTAssertNoThrow(n = try PackedTime(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(UInt64(output.timeIntervalSince1970), UInt64(input.timeIntervalSince1970))
    }

}

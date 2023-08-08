import XCTest
@testable import Packed

final class MapTests: XCTestCase {

    func testMap() {
        var input = [String: Int32]()
        input["A"] = 123
        input["B"] = 456
        input["C"] = 789
        let encoded = PackedMap(keys: PackedString, values: PackedInt32)(&input).encode()
        XCTAssertEqual(encoded.count, 1+3*(2+1)+3*(4))

        var output = [String: Int32]()
        var n: Int?
        XCTAssertNoThrow(n = try PackedMap(keys: PackedString, values: PackedInt32)(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output["A"], 123)
        XCTAssertEqual(output["B"], 456)
        XCTAssertEqual(output["C"], 789)
    }

    func testMapEmpty() {
        var input = [String: Int32]()
        let encoded = PackedMap(keys: PackedString, values: PackedInt32)(&input).encode()
        XCTAssertEqual(encoded.count, 1)

        var output = [String: Int32]()
        var n: Int?
        XCTAssertNoThrow(n = try PackedMap(keys: PackedString, values: PackedInt32)(&output).decode(buf: encoded[...]))
        XCTAssertEqual(n, encoded.count)
        XCTAssertEqual(output.count, 0)
    }

}

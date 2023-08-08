import XCTest
@testable import Packed

final class LittleEndianTests: XCTestCase {

    func testLEGetUInt16() {
        let bytes: [UInt8] = [0x34, 0x12]
        let value = LEGetUInt16(bytes[...])
        XCTAssertEqual(value, 0x1234)
    }

    func testLEPutUInt16() {
        var bytes = [UInt8](repeating: 0, count: 2)
        LEPutUInt16(&bytes[...], value: 0x1234)
        XCTAssertEqual(bytes, [0x34, 0x12])
    }

    func testLEGetUInt32() {
        let bytes: [UInt8] = [0x78, 0x56, 0x34, 0x12]
        let value = LEGetUInt32(bytes[...])
        XCTAssertEqual(value, 0x12345678)
    }

    func testLEPutUInt32() {
        var bytes = [UInt8](repeating: 0, count: 4)
        LEPutUInt32(&bytes[...], value: 0x12345678)
        XCTAssertEqual(bytes, [0x78, 0x56, 0x34, 0x12])
    }

    func testLEGetUInt64() {
        let bytes: [UInt8] = [0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01]
        let value = LEGetUInt64(bytes[...])
        XCTAssertEqual(value, 0x0123456789ABCDEF)
    }

    func testLEPutUInt64() {
        var bytes = [UInt8](repeating: 0, count: 8)
        LEPutUInt64(&bytes[...], value: 0x0123456789ABCDEF)
        XCTAssertEqual(bytes, [0xEF, 0xCD, 0xAB, 0x89, 0x67, 0x45, 0x23, 0x01])
    }
}

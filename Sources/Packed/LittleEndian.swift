import Foundation

// Little endian

func LEGetUInt16(_ arr: ArraySlice<UInt8>) -> UInt16 {
    return UInt16(arr[arr.startIndex]) | (UInt16(arr[arr.startIndex+1]) << 8)
}

func LEPutUInt16(_ arr: inout ArraySlice<UInt8>, value: UInt16) {
    arr[arr.startIndex] = UInt8(value & 0xFF)
    arr[arr.startIndex+1] = UInt8((value >> 8) & 0xFF)
}

func LEGetUInt32(_ arr: ArraySlice<UInt8>) -> UInt32 {
    var value = UInt32(arr[arr.startIndex])
    value |= UInt32(arr[arr.startIndex+1]) << 8
    value |= UInt32(arr[arr.startIndex+2]) << 16
    value |= UInt32(arr[arr.startIndex+3]) << 24
    return value
}

func LEPutUInt32(_ arr: inout ArraySlice<UInt8>, value: UInt32) {
    arr[arr.startIndex] = UInt8(value & 0xFF)
    arr[arr.startIndex+1] = UInt8((value >> 8) & 0xFF)
    arr[arr.startIndex+2] = UInt8((value >> 16) & 0xFF)
    arr[arr.startIndex+3] = UInt8((value >> 24) & 0xFF)
}

func LEGetUInt64(_ arr: ArraySlice<UInt8>) -> UInt64 {
    var value = UInt64(arr[arr.startIndex])
    value |= UInt64(arr[arr.startIndex+1]) << 8
    value |= UInt64(arr[arr.startIndex+2]) << 16
    value |= UInt64(arr[arr.startIndex+3]) << 24
    value |= UInt64(arr[arr.startIndex+4]) << 32
    value |= UInt64(arr[arr.startIndex+5]) << 40
    value |= UInt64(arr[arr.startIndex+6]) << 48
    value |= UInt64(arr[arr.startIndex+7]) << 56
    return value
}

func LEPutUInt64(_ arr: inout ArraySlice<UInt8>, value: UInt64) {
    arr[arr.startIndex] = UInt8(value & 0xFF)
    arr[arr.startIndex+1] = UInt8((value >> 8) & 0xFF)
    arr[arr.startIndex+2] = UInt8((value >> 16) & 0xFF)
    arr[arr.startIndex+3] = UInt8((value >> 24) & 0xFF)
    arr[arr.startIndex+4] = UInt8((value >> 32) & 0xFF)
    arr[arr.startIndex+5] = UInt8((value >> 40) & 0xFF)
    arr[arr.startIndex+6] = UInt8((value >> 48) & 0xFF)
    arr[arr.startIndex+7] = UInt8((value >> 56) & 0xFF)
}

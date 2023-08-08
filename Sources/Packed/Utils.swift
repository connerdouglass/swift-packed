import Foundation

func Copy(_ dest: inout ArraySlice<UInt8>, _ src: ArraySlice<UInt8>) -> Int {
    let length = min(dest.count, src.count)
    for i in 0..<length {
        dest[dest.startIndex+i] = src[src.startIndex+i]
    }
    return length
}

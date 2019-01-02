//
//  CShims.swift
//  SwiftTulipIndicators
//
//  Created by Tim Storey on 20/12/2018.
//

import Foundation

/// Compute the prefix sum of `seq`.
/// used to create an array of arrays for string functions
/// copied direct from the Swift project itself
/// see https://github.com/apple/swift/blob/c3b7709a7c4789f1ad7249d357f69509fb8be731/stdlib/private/SwiftPrivate/SwiftPrivate.swift
/// explained further in the following article where it is used
/// https://oleb.net/blog/2016/10/swift-array-of-c-strings/
internal func scan<
    S : Sequence, U
    >(_ seq: S, _ initial: U, _ combine: (U, S.Iterator.Element) -> U) -> [U] {
    var result: [U] = []
    result.reserveCapacity(seq.underestimatedCount)
    var runningResult = initial
    for element in seq {
        runningResult = combine(runningResult, element)
        result.append(runningResult)
    }
    return result
}

internal func getArrayCounts<C: Collection>(_ seq: [C]) -> [Int] {
    assert(seq.count > 0)
    let counts = Array(seq.map {
        $0.count
    })
    return counts
}

internal func getOffsets<S: SignedNumeric>(_ seq: [S]) -> [S] {
    var seq = [0] + scan(seq, 0, +)
    _ = seq.popLast()
    return seq
}


import XCTest
@testable import SwiftTulipIndicators

final class SwiftTulipIndicatorsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftTulipIndicators().text, "Hello, World!")
    }

    func testInitialisation() {
        let sut = SwiftTulipIndicators.init()
        sut.text
        print("foo")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

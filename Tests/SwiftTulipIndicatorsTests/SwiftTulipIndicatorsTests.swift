import XCTest
import Nimble

@testable import SwiftTulipIndicators

final class SwiftTulipIndicatorsTests: XCTestCase {

    func testInitialisationForMACD() {
        let sut = TulipIndicatorInfo.init("macd")
        expect(sut).toNot(beNil())
        expect(sut?.name).to(equal("Moving Average Convergence/Divergence"))
    }
}

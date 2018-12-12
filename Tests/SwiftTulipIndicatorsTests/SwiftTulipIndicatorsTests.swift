import XCTest
import Nimble

@testable import SwiftTulipIndicators

final class SwiftTulipIndicatorsTests: XCTestCase {

    var sut:TulipIndicatorInfo?

    override class func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitialisationForMACD() {
        let sut = TulipIndicatorInfo.init("macd")
        expect(sut?.name).to(equal("macd"))
        expect(sut?.fullName).to(equal("Moving Average Convergence/Divergence"))
    }

    func testInitialsationForEMA() {
        let sut = TulipIndicatorInfo.init("ema")
        expect(sut?.name).to(equal("ema"))
        expect(sut?.fullName).to(equal("Exponential Moving Average"))
    }

    func testNumberOfOutputs() {
        let sut = TulipIndicatorInfo.init("macd")
        expect(sut?.numberOfOutputs).to(equal(3))
    }

    func testNumberOfInputs() {
        let sut = TulipIndicatorInfo.init("macd")
        expect(sut?.numberOfInputs).to(equal(1))
    }

    func testNumberOfOptions() {
        let sut = TulipIndicatorInfo.init("macd")
        expect(sut?.numberOfOptions).to(equal(3))
    }

}

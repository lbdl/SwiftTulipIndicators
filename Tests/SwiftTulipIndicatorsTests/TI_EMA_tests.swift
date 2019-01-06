import Quick
import Nimble

@testable import SwiftTulipIndicators

class TI_EMA_tests: QuickSpec {
    override func spec() {

        describe("TIIndicator enum's") {
            var sut: TIndicator?

            context("initialisation") {
                var options: [Double]?
                describe("successful initialisation") {
                    it("it inits") {
                        options = [5]
                        let sut = TIndicator.ema(options: options!)
                        expect(sut).toNot(beNil())
                    }
                }
            }
        }

        describe("EMA indicator class") {
            var sut: Indicator!
            var indicatorType: TIndicator!
            var inputs: [[Double]]!
            var options: [Double]!

            context("initialisation") {

                beforeEach {
                    options = [5]
                    indicatorType = TIndicator.ema(options: options)
                }

                describe("with TIIndicator") {
                    it("returns a valid instance") {
                        sut = Indicator(indicatorType)
                        expect(sut).toNot(beNil())
                    }
                }
            }
        }

    }
}

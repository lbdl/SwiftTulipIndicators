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

            context("functionality") {
                beforeEach {
                    options = [5]
                    indicatorType = TIndicator.ema(options: options)
                    inputs = [[11.48,12.56,69.8,70.3,69.8,69.4,68.9,
                               69.2,70.1,69.7,69.1,68.6,69.1,68.8,69.8,
                               69.7,69.1,68.8,68.6,68.7,68.8,68.4,68.8,
                               68.4,68.2,67.9,68.3,68.4,68.5,68.5,68.2,
                               68,67.6,68.1,68.1,69.4,68.4,68.5,68,68,
                               68.3,67.5,67.3,67.5,67.3,67.4,67,67.2,
                               66.4,66.4,66.5
                        ]]
                }
            }
        }

    }
}

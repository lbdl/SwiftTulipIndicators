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
                describe("EMA calculations, with inputs") {
                    
                    it("it returns 1 output array") {
                        expect(sut.tulipInfo.numberOfOutputs).to(equal(1))
                    }
                    
                    it("with options set to 5 the delta is 0") {
                        expect(sut.tulipInfo.delta(options)).to(equal(0))
                    }
                    
                    it("the output array is the same size as the inputs array") {
                        let actual = sut.doFunction(inputs)
                        expect(actual?.count).to(equal(inputs.count))
                        expect(actual?[0].count).to(equal(inputs[0].count))
                    }
                    
                    it("correctly calculates ema over a range of input bars") {
                        let actual = sut.doFunction(inputs)
                        expect(actual?[0][0]).to(beCloseTo(11.48))
                        expect(actual?[0][1]).to(beCloseTo(11.84))
                        expect(actual?[0][2]).to(beCloseTo(31.16))
                        expect(actual?[0][3]).to(beCloseTo(44.2067))
                        expect(actual?[0][4]).to(beCloseTo(52.7378))
                        expect(actual?[0][5]).to(beCloseTo(58.2919))
                        expect(actual?[0][6]).to(beCloseTo(61.8279))
                        expect(actual?[0][7]).to(beCloseTo(64.2853))
                        expect(actual?[0][8]).to(beCloseTo(66.2235))
                        expect(actual?[0][9]).to(beCloseTo(67.3823))
                        expect(actual?[0][10]).to(beCloseTo(67.9549))
                        expect(actual?[0][11]).to(beCloseTo(68.1699))
                    }
                }
            }
        }

    }
}

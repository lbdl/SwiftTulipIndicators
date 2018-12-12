//
//  TulipIndicatorTests.swift
//  SwiftTulipIndicators
//
//  Created by Timothy Storey on 2018-12-12.
//
//

import Quick
import Nimble

@testable import SwiftTulipIndicators

class TulipIndicatorTests: QuickSpec {
    override func spec() {

        describe("'TIIndicator' enum's") {
            var sut: TIndicator?
            var inputs: [[Double]]?

            context("initialisation") {
                var macdOptions: [Double]?
                describe("successful initialisation") {
                    it("it inits") {
                        macdOptions = [1, 2, 3]
                        inputs = []
                        let sut = TIndicator.macd(options: macdOptions!, inputs: inputs!)
                        expect(sut).toNot(beNil())
                    }
                }
            }
        }

        describe("'Indicator' class") {

            var sut: Indicator?
            var tInd: TIndicator?
            var options: [Double]?
            var inputs: [[Double]]?

            context("initialisation for 'macd'") {

                describe("GIVEN valid params") {
                    beforeEach {
                        options = [1, 2, 3]
                        inputs = [[2, 3, 4, 5, ]]
                        tInd = TIndicator.macd(options: options!, inputs: inputs!)
                    }

                    it("it is the correct type") {
                        sut = Indicator(tInd!)
                        expect(sut).to(beAKindOf(Indicator.self))
                    }

                    it("return the correct identifier") {
                        sut = Indicator(tInd!)
                        expect(sut?.id).to(equal("macd"))
                    }

                }

                describe("GIVEN invalid params") {

                    beforeEach {
                        options = [1]
                        inputs = [[2, 3, 4, 5, ]]
                        tInd = TIndicator.macd(options: options!, inputs: inputs!)
                    }

                    it("it does not create an object") {
                        sut = Indicator(tInd!)
                        expect(sut).to(beNil())
                    }


                }
            }

            context("'ema'") {
                describe("successful initialisation") {

                }
                describe("failing initialisation") {

                }

            }

        }

    }
}

//
//  TulipIndicatorTests.swift
//  SwiftTulipIndicators
//
//  Created by Timothy Storey on 2018-12-12.
//
//

import Quick
import Nimble

import Foundation

@testable import SwiftTulipIndicators

class TulipIndicatorTests: QuickSpec {
    override func spec() {

        describe("TIIndicator enum's") {
            var sut: TIndicator?
            var inputs: [[Double]]?

            context("initialisation") {
                var macdOptions: [Double]?
                describe("successful initialisation") {
                    it("it inits") {
                        macdOptions = [1, 2, 3]
                        inputs = []
                        let sut = TIndicator.macd(options: macdOptions!)
                        expect(sut).toNot(beNil())
                    }
                }
            }
        }

        describe("Indicator class") {

            var sut: Indicator?
            var tInd: TIndicator?
            var options: [Double]?
            var inputs: [[Double]]?

            context("initialisation for 'macd'") {

                describe("GIVEN valid params") {
                    beforeEach {
                        options = [1, 2, 3]
                        inputs = [[2, 3, 4, 5, ]]
                        tInd = TIndicator.macd(options: options!)
                        sut = Indicator(tInd!)
                    }

                    it("it is the correct type") {
                        expect(sut).to(beAKindOf(Indicator.self))
                    }

                    it("it returns the correct identifier") {
                        expect(sut?.id).to(equal("macd"))
                    }

                    it("has the correct set of inputs and options") {
                        expect(sut?.options?.count).to(equal(3))
                    }

                    context("MACD with options 12, 26, 9") {

                        beforeEach {
                            options = [12, 26, 9]
                            let barsArray: [Double] = [81.85,81.2,81.55,82.91,83.1,83.41,82.71,82.7,84.2,84.25,84.03,85.45,86.18,88,87.323,87.321,87.333,87.32,87.3,87.3,87.1,87.2,87.4,87.5,87.4,86.234,81.85,81.2,81.55,82.91,83.1,83.41,82.71,82.7,84.2,84.25,84.03,85.45,86.18,88,87.323,87.321,87.333,87.32,87.3,87.3,87.1,87.2,87.4,87.5,87.4,86.234]
                            inputs = [barsArray]
                            tInd = TIndicator.macd(options: options!)
                            sut = Indicator(tInd!)
                            sut?.doFunction(inputs!)
                        }

                        it("calculates the delta needed for results array as long period - 1 ") {
                            expect(sut?.resultsSizeDelta()).to(equal(25))
                        }

                        it("creates a return array of the correct count") {
                            expect(sut?.resultsArray().count).to(equal(3))
                        }

                        it("creates arrays with the required capacity") {
                            sut?.resultsArray().map { arr in
                                expect(arr.capacity).to(beGreaterThan(3))
                            }
                        }
                        
                        it("runs the macd function and returns") {
                            let res = sut?.doFunction(inputs!)
                            expect(res?.count).to(equal(3))
                            expect(res?[0].count).to(equal(27))
                        }
                        
                        it("calculates the correct macd"){
                            let res = sut?.doFunction(inputs!)
                            expect(res?[0][0]).to(beCloseTo(1.0525))
                            expect(res?[0][1]).to(beCloseTo(0.6051))
                            expect(res?[0][2]).to(beCloseTo(0.1978))
                        }
                        
                        it("calculates the correct macd signal"){
                            let res = sut?.doFunction(inputs!)
                            expect(res?[1][0]).to(beCloseTo(1.0525))
                            expect(res?[1][1]).to(beCloseTo(0.9630))
                            expect(res?[1][2]).to(beCloseTo(0.8100))
                        }
                        
                        it("calculates the correct macd histogram"){
                            let res = sut?.doFunction(inputs!)
                            expect(res?[2][0]).to(beCloseTo(0))
                            expect(res?[2][1]).to(beCloseTo(-0.3579))
                            expect(res?[2][2]).to(beCloseTo(-0.6122))
                        }

                    }


                }

                describe("GIVEN invalid params") {
                    context("macd indicator") {
                        beforeEach {
                            options = [1]
                            inputs = [[2, 3, 4, 5]]
                            tInd = TIndicator.macd(options: options!)
                        }
                        
                        it("it does not create an object") {
                            sut = Indicator(tInd!)
                            expect(sut).to(beNil())
                        }
                    }
                }
            }

            context("ema") {
                describe("successful initialisation") {

                }
                describe("failing initialisation") {

                }

            }

        }

    }
}

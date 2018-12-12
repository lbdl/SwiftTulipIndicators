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
            var options: [Double]?
            var inputs: [[Double]]?

            context("'macd'") {
                describe("successful initialisation") {

                }
                describe("failing initialisation") {

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

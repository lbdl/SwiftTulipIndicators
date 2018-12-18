//
// Created by Timothy Storey on 2018-12-12.
//

import Foundation

public enum TIndicator {
    case ema(options: [Double], inputs: [[Double]])
    case macd(options: [Double], inputs: [[Double]])
}

extension TIndicator {
    func stringValue() -> String {
        switch self {
        case .ema:
            return "ema"
        case .macd:
            return "macd"
        }
    }
}

public final class Indicator {

    internal var tulipInfo: TulipIndicatorInfo!

    internal var inputs: [[Double]]?

    internal var outputs: [Double]?

    internal var options: [Double]?

    lazy var id: String = {
        return tulipInfo.name ?? ""
    }()

    internal func resultsSizeDelta() -> Int {
        guard let optionsArray = options else {
            fatalError("Class must have an options array")
        }
        return tulipInfo.delta(optionsArray)
    }

    internal func resultsArray() -> [Double] {
        guard let inputsArray = inputs?.first else {
            fatalError("Class must have an input array")
        }
        let newSize = inputsArray.count - resultsSizeDelta()
        var newArray: [Double] = []
        newArray.reserveCapacity(newSize)
        return newArray
    }

    init?(_ indicator: TIndicator) {
        switch indicator {
        case .ema(let o, let i):
            if o.count == 1 && i.count == 1 {
                guard let info = TulipIndicatorInfo.init(indicator.stringValue()) else {
                    return nil
                }
                tulipInfo = info
                inputs = i
                options = o
            } else {
                return nil
            }
        case .macd(let o, let i):
            if o.count == 3 && i.count == 1 {
                guard let info = TulipIndicatorInfo.init(indicator.stringValue()) else {
                    return nil
                }
                tulipInfo = info
                inputs = i
                options = o
            } else {
                return nil
            }
        }
    }

}

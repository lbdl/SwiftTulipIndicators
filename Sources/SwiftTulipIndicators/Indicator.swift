//
// Created by Timothy Storey on 2018-12-12.
//

import Foundation

public enum TIndicator {
    case ema(options:[Double], inputs: [[Double]])
    case macd(options:[Double], inputs: [[Double]])
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

    internal var tulipInfo: TulipIndicatorInfo?

    internal var inputs: [[Double]]?

    internal var outputs: [Double]?

    internal var options: [Double]?

    init?(_ indicator: TIndicator) {
        switch indicator {
        case .ema(let o, let i):
            if o.count == 1 && i.count == 1 {
                guard let info = TulipIndicatorInfo.init(indicator.stringValue()) else { return nil }
                tulipInfo = info
                inputs = i
                options = o
            }
        case .macd(let o, let i):
            if o.count == 3 && i.count == 1 {
                guard let info = TulipIndicatorInfo.init(indicator.stringValue()) else { return nil }
                tulipInfo = info
                inputs = i
                options = o
            }
        }
    }

}

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

    internal func resultsArray() -> [[Double]] {
        
        guard let inputsArray = inputs?.first else {
            fatalError("Class must have an input array")
        }
        
        var results: [[Double]] = []
        let newSize = inputsArray.count - resultsSizeDelta()

        for _ in 0..<tulipInfo.numberOfOutputs {
            let tmpArray: [Double] = Array(repeating: 0, count: newSize)
            results.append(tmpArray)
        }
        
        return results
    }
    
    /*
     *      Imported function signatures
     *
     *      public typealias ti_indicator_start_function = @convention(c) (UnsafePointer<Double>?) -> Int32
     *      public typealias ti_indicator_function = @convention(c) (Int32, UnsafePointer<UnsafePointer<Double>?>?, UnsafePointer<Double>?, UnsafePointer<UnsafeMutablePointer<Double>?>?) -> Int32
     */
    
    public func doFunction() -> [[Double]]? {
        var resArray = resultsArray()
        guard let input = inputs, let opts = options else { fatalError("no inputs to function") }
        return tulipInfo.indicatorWithArrays(inputs: input, options: opts, outputs: resArray) { (input, opts, outputs) in
            let sz = inputs?.first?.count ?? 0
            let ret = tulipInfo.info.pointee.indicator(Int32(sz), input, opts, outputs)
            return [[1],[1]]
        }
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

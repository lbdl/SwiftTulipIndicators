//
// Created by Timothy Storey on 2018-12-12.
//

import Foundation

public enum TIndicator {
    case ema(options: [Double])
    case macd(options: [Double])
}

private enum TIReturnType: Int32 {
    case ti_okay = 0
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

    var options: [Double]?

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
    
    public func doFunction(_ bars: [[Double]]) -> [[Double]]? {
        inputs = bars
        var resArray = resultsArray()
        guard let input = inputs, let opts = options else { fatalError("no inputs to function") }
        
        return indicatorWithArrays(inputs: input, options: opts, outputs: resArray) { (input, opts, outputs) in
            let sz = inputs?.first?.count ?? 0
            switch TIReturnType(rawValue: tulipInfo.info.pointee.indicator(Int32(sz), input, opts, outputs)) {
            case .ti_okay?:
                for (index, item) in outputs.enumerated() {
                    let buff = UnsafeBufferPointer(start: item, count: resArray[index].count)
                    resArray[index] = Array(buff)
                }
                return resArray
            case nil:
                return nil
            }
        }
    }
    
    internal func indicatorWithArrays<R>(inputs ins:[[Double]],
                                         options opts: [Double],
                                         outputs out: [[Double]],
                                         ti body: ([UnsafePointer<Double>?], UnsafePointer<Double>?, [UnsafeMutablePointer<Double>?]) -> R) -> R {
        
        return ins.withUnsafeBufferPointer { (inputsBuffer) in
            let inPuts: [UnsafePointer<Double>?] = inputsBuffer.map { UnsafePointer($0) }
            return out.withUnsafeBufferPointer { (outputsBuffer) in
                let outPtrPtr: [UnsafeMutablePointer<Double>?] = outputsBuffer.map { UnsafeMutablePointer(mutating: $0) }
                return body(inPuts, opts, outPtrPtr)
            }
        }
    }

    init?(_ indicator: TIndicator) {
        switch indicator {
        case .ema(let o):
            if o.count == 1 {
                guard let info = TulipIndicatorInfo.init(indicator.stringValue()) else {
                    return nil
                }
                tulipInfo = info
                options = o
            } else {
                return nil
            }
        case .macd(let o):
            if o.count == 3 {
                guard let info = TulipIndicatorInfo.init(indicator.stringValue()) else {
                    return nil
                }
                tulipInfo = info
                options = o
            } else {
                return nil
            }
        }
    }

}

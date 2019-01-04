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
        return indicatorWithArrays(inputs: input, options: opts, outputs: resArray) { (input, opts, outputs) in
            let sz = inputs?.first?.count ?? 0
            let ret = tulipInfo.info.pointee.indicator(Int32(sz), input, opts, outputs)
            
            for (index, item) in input.enumerated() {
                let buff = UnsafeBufferPointer(start: item, count: resArray[index].count)
                buff.map { val in
                    let newVal = Double(val)
                    print("TI IN ptr: \(val)")
                }
            }
            for (index, item) in outputs.enumerated() {
                let buff = UnsafeBufferPointer(start: item, count: resArray[index].count)
                buff.map { val in
                    let newVal = Double(val)
                    print("TI OUT ptr: \(val)")
                }
                resArray[index] = Array(buff)
            }
            return resArray
        }
    }
    
    internal func indicatorWithArrays<R>(inputs ins:[[Double]],
                                         options opts: [Double],
                                         outputs out: [[Double]],
                                         ti body: ([UnsafePointer<Double>?], UnsafePointer<Double>?, [UnsafeMutablePointer<Double>?]) -> R) -> R {
        
        guard let sz = ins.first?.count else {fatalError("Must supply a [[Double]] input param")}
        
        let inputCounts = getArrayCounts(ins)
        var inputOffsets = getOffsets(inputCounts)
        
        let outputCounts = getArrayCounts(out)
        var outputOffsets = getOffsets(outputCounts)
        
        var inputBuffer: [[Double]] = []
        inputBuffer.reserveCapacity(inputOffsets.last!)
        for arr in ins {
            inputBuffer.append(arr)
        }
        
        var outputBuffer: [[Double]] = []
        outputBuffer.reserveCapacity(outputOffsets.last!)
        for arr in out {
            outputBuffer.append(arr)
        }
        
//        var inBuff = UnsafeBufferPointer(start: inputBuffer, count: inputBuffer.count)
//        var outBuff = UnsafeBufferPointer(start: outputBuffer, count: outputBuffer.count)
//
//        let inPtr = UnsafeRawPointer(inBuff.baseAddress!).bindMemory(to: Double.self, capacity: inBuff.count)
//        _ = inputOffsets.popLast()
//
//        var inPuts: [UnsafePointer<Double>?] = inputOffsets.map {
//            inPtr + $0
//        }
//
//        let outPtr = UnsafeMutableRawPointer(mutating: outBuff.baseAddress!).bindMemory(to: Double.self, capacity: outBuff.count)
//        _ = outputOffsets.popLast()
//        var outPtrPtr: [UnsafeMutablePointer<Double>?] = outputOffsets.map { outPtr + $0 }
        
//        return body(inPuts, opts, outPtrPtr)
        
        return inputBuffer.withUnsafeBufferPointer { (inputsBuffer) in
            let inPtr = UnsafePointer(inputsBuffer.baseAddress!)//.bindMemory(to: Double.self, capacity: inputsBuffer.count)
            _ = inputOffsets.popLast()
            var inPuts: [UnsafePointer<Double>?] = inputsBuffer.map { UnsafePointer($0) }


            return outputBuffer.withUnsafeBufferPointer { (outputsBuffer) in
                let outPtr = UnsafeMutableRawPointer(mutating: outputsBuffer.baseAddress!).bindMemory(to: Double.self, capacity: outputsBuffer.count)
                _ = outputOffsets.popLast()
                var outPtrPtr: [UnsafeMutablePointer<Double>?] = outputBuffer.map { val in
                    let ptr = UnsafeMutablePointer(mutating: val)
                    return ptr
                }
                return body(inPuts, opts, outPtrPtr)
            }
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

import CTulipIndicators

struct TulipIndicatorInfo {

    private let info: UnsafePointer<ti_indicator_info>

    var name: String? {
        guard let str = info.pointee.name else {
            return nil
        }
        return String(cString: str)
    }

    var fullName: String? {
        guard let str = info.pointee.full_name else {
            return nil
        }
        return String(cString: str)
    }

    var numberOfInputs: Int {
        return Int(info.pointee.inputs)
    }

    var numberOfOutputs: Int {
        return Int(info.pointee.outputs)
    }

    var numberOfOptions: Int {
        return Int(info.pointee.options)
    }

    internal func delta(_ options: [Double]) -> Int {
       return Int(info.pointee.start(options))
    }
    
//    internal func indicatorFunc(Int32, UnsafePointer<UnsafePointer<Double>?>?, UnsafePointer<Double>?, _: UnsafePointer<UnsafeMutablePointer<Double>?>?) -> Int32 {
//        return 1
//    }

    internal func pointerToMutablePointers<U>(_ seq:[[U]]) -> UnsafePointer<UnsafeMutablePointer<U>?>? {

        let counts = getArrayCounts(seq)
        let offsets = getOffsets(counts)

        return seq.withUnsafeBufferPointer { (buffer) in
            let ptr = UnsafeMutableRawPointer(mutating: buffer.baseAddress!).bindMemory(
                to: U.self, capacity: buffer.count)

            var ptrPtrs: [UnsafeMutablePointer<U>?] = offsets.map { ptr + $0 }
            ptrPtrs[ptrPtrs.count - 1] = nil

            return nil
        }
    }

    internal func pointerToPointers(_ seq: [[Double]]) -> UnsafePointer<UnsafePointer<Double>?>? {

        return seq.withUnsafeBufferPointer { (buffer) in
            return nil
        }
    }

    internal func calculateIndicator(options opts: [Double], input inputs: [[Double]], output outPuts: inout [[Double]]) -> [[Double]]? {
        guard let sz = inputs.first?.count else {fatalError("Must supply a [[Double]] input param")}

        let inputCounts = getArrayCounts(inputs)
        let outputCounts = getArrayCounts(outPuts)

        return outPuts.withUnsafeBufferPointer { (buffer) in
            return nil
        }

        let inputPointer = UnsafePointer<[Double]>(inputs)
        let optionsPointer = UnsafePointer<Double>(opts)
        var outputPointer = UnsafeMutablePointer<[Double]>(&outPuts)

//        let val = info.pointee.indicator(Int32(sz), inputPointer, optionsPointer, outputPointer)
        return nil
    }


    init?(_ indicator: String) {
        if let info = ti_find_indicator(indicator) {
            self.info = info
        } else {
            return nil
        }
    }

}









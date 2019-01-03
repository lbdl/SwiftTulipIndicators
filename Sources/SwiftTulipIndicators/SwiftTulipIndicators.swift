import CTulipIndicators

struct TulipIndicatorInfo {

    internal let info: UnsafePointer<ti_indicator_info>

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
        
    internal func indicatorWithArrays<R>(inputs ins:[[Double]],
                                         options opts: [Double],
                                         outputs out: [[Double]],
                                         body ti: ([UnsafePointer<Double>?], UnsafePointer<Double>?, [UnsafeMutablePointer<Double>?]) -> R) -> R {
        
        guard let sz = ins.first?.count else {fatalError("Must supply a [[Double]] input param")}

        let inputCounts = getArrayCounts(ins)
        let inputOffsets = getOffsets(inputCounts)
        
        //TODO remove this outputs stuff
        let outputCounts = getArrayCounts(out)
        let outPutOffsets = getOffsets(outputCounts)
        
        return ins.withUnsafeBufferPointer { (inputsBuffer) in
            let inPtr = UnsafeRawPointer(inputsBuffer.baseAddress!).bindMemory(to: Double.self, capacity: inputsBuffer.count)
            var inPuts: [UnsafePointer<Double>?] = inputOffsets.map { inPtr + $0 }
            
            defer {
                inPuts.forEach{
                    var ptr = UnsafeMutableRawPointer(mutating: $0)
                    free(ptr)}
            }
            
            
            
//            let outBuffPtr = UnsafeMutablePointer<Double>.allocate(capacity: )
//            outBuffPtr.map { dbl in
//
//            }
            //TODO: remove this as this is escaping the inputs pointers and causing crashes.
            return out.withUnsafeBufferPointer { (outputsBuffer) in
                let outPtr = UnsafeMutableRawPointer(mutating: outputsBuffer.baseAddress!).bindMemory(to: Double.self, capacity: outputsBuffer.count)
                var outPtrPtr: [UnsafeMutablePointer<Double>?] = outPutOffsets.map { outPtr + $0 }
                return ti(inPuts, opts, outPtrPtr)
            }
        }
    }


    init?(_ indicator: String) {
        if let info = ti_find_indicator(indicator) {
            self.info = info
        } else {
            return nil
        }
    }

}









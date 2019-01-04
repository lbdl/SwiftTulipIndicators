import CTulipIndicators

class TulipIndicatorInfo {

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
    
    init?(_ indicator: String) {
        if let info = ti_find_indicator(indicator) {
            self.info = info
        } else {
            return nil
        }
    }

}


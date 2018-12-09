import CTulipIndicators

struct TulipIndicatorInfo {
    
    let _info: UnsafePointer<ti_indicator_info>!
    
    var name: String? {
        guard let str = _info.pointee.full_name else {return nil}
        return String(cString: str)
    }
    
    init?(_ indicator: String) {
        _info = ti_find_indicator(indicator)
    }
}

struct SwiftTulipIndicators {
    var text = "Hello, World!"
}





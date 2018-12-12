import CTulipIndicators


struct TulipIndicatorInfo {
    
   private let info: UnsafePointer<ti_indicator_info>
    
    var name: String? {
        guard let str = info.pointee.name else {return nil}
        return String(cString: str)
    }
    
    var fullName: String? {
        guard let str = info.pointee.full_name else { return nil}
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
    
    init?(_ indicator: String) {
        if let info = ti_find_indicator(indicator) {
            self.info = info
        } else {
            return nil
        }
    }
}

//#define TI_REAL double
//
//#define TI_INDICATOR_COUNT 104 /* Total number of indicators. */
//
//#define TI_OKAY                    0
//#define TI_INVALID_OPTION          1
//
//#define TI_TYPE_OVERLAY            1 /* These have roughly the same range as the input data. */
//#define TI_TYPE_INDICATOR          2 /* Everything else (e.g. oscillators). */
//#define TI_TYPE_MATH               3 /* These aren't so good for plotting, but are useful with formulas. */
//#define TI_TYPE_SIMPLE             4 /* These apply a simple operator (e.g. addition, sin, sqrt). */
//#define TI_TYPE_COMPARATIVE        5 /* These are designed to take inputs from different securities. i.e. compare stock A to stock B.*/
//
//#define TI_MAXINDPARAMS 10 /* No indicator will use more than this many inputs, options, or outputs. */
//
//
//typedef int (*ti_indicator_start_function)(TI_REAL const *options);
//typedef int (*ti_indicator_function)(int size,
//TI_REAL const *const *inputs,
//TI_REAL const *options,
//TI_REAL *const *outputs);
//
//typedef struct ti_indicator_info {
//    char *name;
//    char *full_name;
//    ti_indicator_start_function start;
//    ti_indicator_function indicator;
//    int type, inputs, options, outputs;
//    char *input_names[TI_MAXINDPARAMS];
//    char *option_names[TI_MAXINDPARAMS];
//    char *output_names[TI_MAXINDPARAMS];
//} ti_indicator_info;







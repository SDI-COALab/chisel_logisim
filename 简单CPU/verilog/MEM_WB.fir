circuit MEM_WB :
  module MEM_WB :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip flushStageWB : UInt<1>, flip stallStageWB : UInt<1>, flip reset : UInt<1>, flip wRegData_MEM : UInt<32>, flip wRegAddr_MEM : UInt<5>, flip weReg_ctrl_uWB_MEM : UInt<1>, wRegData_WB : UInt<32>, wRegAddr_WB : UInt<5>, weReg_ctrl_uWB_WB : UInt<1>}

    reg wRegData : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[MEM_WB.scala 19:27]
    reg wRegAddr : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[MEM_WB.scala 20:27]
    reg weReg_ctrl_uWB : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[MEM_WB.scala 21:33]
    node _wRegData_T = mux(io.flushStageWB, UInt<1>("h0"), io.wRegData_MEM) @[Mux.scala 101:16]
    node _wRegData_T_1 = mux(io.reset, UInt<1>("h0"), _wRegData_T) @[Mux.scala 101:16]
    node _wRegData_T_2 = mux(io.stallStageWB, wRegData, _wRegData_T_1) @[Mux.scala 101:16]
    wRegData <= _wRegData_T_2 @[MEM_WB.scala 26:14]
    node _wRegAddr_T = mux(io.flushStageWB, UInt<1>("h0"), io.wRegAddr_MEM) @[Mux.scala 101:16]
    node _wRegAddr_T_1 = mux(io.reset, UInt<1>("h0"), _wRegAddr_T) @[Mux.scala 101:16]
    node _wRegAddr_T_2 = mux(io.stallStageWB, wRegAddr, _wRegAddr_T_1) @[Mux.scala 101:16]
    wRegAddr <= _wRegAddr_T_2 @[MEM_WB.scala 31:14]
    node _weReg_ctrl_uWB_T = mux(io.flushStageWB, UInt<1>("h0"), io.weReg_ctrl_uWB_MEM) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_T_1 = mux(io.reset, UInt<1>("h0"), _weReg_ctrl_uWB_T) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_T_2 = mux(io.stallStageWB, weReg_ctrl_uWB, _weReg_ctrl_uWB_T_1) @[Mux.scala 101:16]
    weReg_ctrl_uWB <= _weReg_ctrl_uWB_T_2 @[MEM_WB.scala 36:20]
    io.wRegData_WB <= wRegData @[MEM_WB.scala 42:20]
    io.wRegAddr_WB <= wRegAddr @[MEM_WB.scala 43:20]
    io.weReg_ctrl_uWB_WB <= weReg_ctrl_uWB @[MEM_WB.scala 44:26]


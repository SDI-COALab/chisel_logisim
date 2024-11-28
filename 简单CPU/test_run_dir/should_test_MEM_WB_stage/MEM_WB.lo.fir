circuit MEM_WB :
  module MEM_WB :
    input clock : Clock
    input reset : UInt<1>
    input io_flushStageWB : UInt<1>
    input io_stallStageWB : UInt<1>
    input io_reset : UInt<1>
    input io_wRegData_MEM : UInt<32>
    input io_wRegAddr_MEM : UInt<5>
    input io_weReg_ctrl_uWB_MEM : UInt<1>
    output io_wRegData_WB : UInt<32>
    output io_wRegAddr_WB : UInt<5>
    output io_weReg_ctrl_uWB_WB : UInt<1>

    reg wRegData : UInt<32>, clock with :
      reset => (UInt<1>("h0"), wRegData) @[MEM_WB.scala 19:27]
    reg wRegAddr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), wRegAddr) @[MEM_WB.scala 20:27]
    reg weReg_ctrl_uWB : UInt<1>, clock with :
      reset => (UInt<1>("h0"), weReg_ctrl_uWB) @[MEM_WB.scala 21:33]
    node _wRegData_T = mux(io_flushStageWB, UInt<1>("h0"), io_wRegData_MEM) @[Mux.scala 101:16]
    node _wRegData_T_1 = mux(io_reset, UInt<1>("h0"), _wRegData_T) @[Mux.scala 101:16]
    node _wRegData_T_2 = mux(io_stallStageWB, wRegData, _wRegData_T_1) @[Mux.scala 101:16]
    node _wRegAddr_T = mux(io_flushStageWB, UInt<1>("h0"), io_wRegAddr_MEM) @[Mux.scala 101:16]
    node _wRegAddr_T_1 = mux(io_reset, UInt<1>("h0"), _wRegAddr_T) @[Mux.scala 101:16]
    node _wRegAddr_T_2 = mux(io_stallStageWB, wRegAddr, _wRegAddr_T_1) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_T = mux(io_flushStageWB, UInt<1>("h0"), io_weReg_ctrl_uWB_MEM) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_T_1 = mux(io_reset, UInt<1>("h0"), _weReg_ctrl_uWB_T) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_T_2 = mux(io_stallStageWB, weReg_ctrl_uWB, _weReg_ctrl_uWB_T_1) @[Mux.scala 101:16]
    io_wRegData_WB <= wRegData @[MEM_WB.scala 42:20]
    io_wRegAddr_WB <= wRegAddr @[MEM_WB.scala 43:20]
    io_weReg_ctrl_uWB_WB <= weReg_ctrl_uWB @[MEM_WB.scala 44:26]
    wRegData <= mux(reset, UInt<32>("h0"), _wRegData_T_2) @[MEM_WB.scala 19:{27,27} 26:14]
    wRegAddr <= mux(reset, UInt<5>("h0"), _wRegAddr_T_2) @[MEM_WB.scala 20:{27,27} 31:14]
    weReg_ctrl_uWB <= mux(reset, UInt<1>("h0"), _weReg_ctrl_uWB_T_2) @[MEM_WB.scala 21:{33,33} 36:20]

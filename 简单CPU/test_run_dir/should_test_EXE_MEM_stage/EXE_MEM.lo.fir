circuit EXE_MEM :
  module EXE_MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_aluResult_EXE : UInt<32>
    input io_wRegAddr_EXE : UInt<5>
    input io_wMemData_EXE : UInt<32>
    input io_weMEM_ctrl_uMEM_EXE : UInt<1>
    input io_wRegDataSrc_ctrl_uMEM_EXE : UInt<1>
    input io_wrMemByteSelScr_ctrl_uMEM_EXE : UInt<2>
    input io_memReadDataExt_ctrl_uMEM_EXE : UInt<1>
    input io_weReg_ctrl_uWB_EXE : UInt<1>
    output io_aluResult_MEM : UInt<32>
    output io_wRegAddr_MEM : UInt<5>
    output io_wMemData_MEM : UInt<32>
    output io_weMEM_ctrl_uMEM_MEM : UInt<1>
    output io_wRegDataSrc_ctrl_uMEM_MEM : UInt<1>
    output io_wrMemByteSelScr_ctrl_uMEM_MEM : UInt<2>
    output io_memReadDataExt_ctrl_uMEM_MEM : UInt<1>
    output io_weReg_ctrl_uWB_MEM : UInt<1>
    input io_flushStageMEM : UInt<1>
    input io_stallStageMEM : UInt<1>
    input io_reset : UInt<1>

    reg aluResult_MEM : UInt<32>, clock with :
      reset => (UInt<1>("h0"), aluResult_MEM) @[EXE_MEM.scala 29:32]
    reg wRegAddr_MEM : UInt<5>, clock with :
      reset => (UInt<1>("h0"), wRegAddr_MEM) @[EXE_MEM.scala 30:31]
    reg wMemData_MEM : UInt<32>, clock with :
      reset => (UInt<1>("h0"), wMemData_MEM) @[EXE_MEM.scala 31:31]
    reg weMEM_ctrl_uMEM_MEM : UInt<1>, clock with :
      reset => (UInt<1>("h0"), weMEM_ctrl_uMEM_MEM) @[EXE_MEM.scala 32:38]
    reg wRegDataSrc_ctrl_uMEM_MEM : UInt<1>, clock with :
      reset => (UInt<1>("h0"), wRegDataSrc_ctrl_uMEM_MEM) @[EXE_MEM.scala 33:44]
    reg wrMemByteSelScr_ctrl_uMEM_MEM : UInt<2>, clock with :
      reset => (UInt<1>("h0"), wrMemByteSelScr_ctrl_uMEM_MEM) @[EXE_MEM.scala 34:48]
    reg memReadDataExt_ctrl_uMEM_MEM : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memReadDataExt_ctrl_uMEM_MEM) @[EXE_MEM.scala 35:47]
    reg weReg_ctrl_uWB_MEM : UInt<1>, clock with :
      reset => (UInt<1>("h0"), weReg_ctrl_uWB_MEM) @[EXE_MEM.scala 36:37]
    node _aluResult_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_aluResult_EXE) @[Mux.scala 101:16]
    node _aluResult_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _aluResult_MEM_T) @[Mux.scala 101:16]
    node _aluResult_MEM_T_2 = mux(io_stallStageMEM, aluResult_MEM, _aluResult_MEM_T_1) @[Mux.scala 101:16]
    node _wRegAddr_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_wRegAddr_EXE) @[Mux.scala 101:16]
    node _wRegAddr_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _wRegAddr_MEM_T) @[Mux.scala 101:16]
    node _wRegAddr_MEM_T_2 = mux(io_stallStageMEM, wRegAddr_MEM, _wRegAddr_MEM_T_1) @[Mux.scala 101:16]
    node _wMemData_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_wMemData_EXE) @[Mux.scala 101:16]
    node _wMemData_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _wMemData_MEM_T) @[Mux.scala 101:16]
    node _wMemData_MEM_T_2 = mux(io_stallStageMEM, wMemData_MEM, _wMemData_MEM_T_1) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_weMEM_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _weMEM_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_MEM_T_2 = mux(io_stallStageMEM, weMEM_ctrl_uMEM_MEM, _weMEM_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_wRegDataSrc_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _wRegDataSrc_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_MEM_T_2 = mux(io_stallStageMEM, wRegDataSrc_ctrl_uMEM_MEM, _wRegDataSrc_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_wrMemByteSelScr_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _wrMemByteSelScr_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_MEM_T_2 = mux(io_stallStageMEM, wrMemByteSelScr_ctrl_uMEM_MEM, _wrMemByteSelScr_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_memReadDataExt_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _memReadDataExt_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_MEM_T_2 = mux(io_stallStageMEM, memReadDataExt_ctrl_uMEM_MEM, _memReadDataExt_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_MEM_T = mux(io_flushStageMEM, UInt<1>("h0"), io_weReg_ctrl_uWB_EXE) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_MEM_T_1 = mux(io_reset, UInt<1>("h0"), _weReg_ctrl_uWB_MEM_T) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_MEM_T_2 = mux(io_stallStageMEM, weReg_ctrl_uWB_MEM, _weReg_ctrl_uWB_MEM_T_1) @[Mux.scala 101:16]
    io_aluResult_MEM <= aluResult_MEM @[EXE_MEM.scala 80:22]
    io_wRegAddr_MEM <= wRegAddr_MEM @[EXE_MEM.scala 81:21]
    io_wMemData_MEM <= wMemData_MEM @[EXE_MEM.scala 82:21]
    io_weMEM_ctrl_uMEM_MEM <= weMEM_ctrl_uMEM_MEM @[EXE_MEM.scala 83:28]
    io_wRegDataSrc_ctrl_uMEM_MEM <= wRegDataSrc_ctrl_uMEM_MEM @[EXE_MEM.scala 84:34]
    io_wrMemByteSelScr_ctrl_uMEM_MEM <= wrMemByteSelScr_ctrl_uMEM_MEM @[EXE_MEM.scala 85:38]
    io_memReadDataExt_ctrl_uMEM_MEM <= memReadDataExt_ctrl_uMEM_MEM @[EXE_MEM.scala 86:37]
    io_weReg_ctrl_uWB_MEM <= weReg_ctrl_uWB_MEM @[EXE_MEM.scala 87:27]
    aluResult_MEM <= mux(reset, UInt<32>("h0"), _aluResult_MEM_T_2) @[EXE_MEM.scala 29:{32,32} 40:19]
    wRegAddr_MEM <= mux(reset, UInt<5>("h0"), _wRegAddr_MEM_T_2) @[EXE_MEM.scala 30:{31,31} 45:18]
    wMemData_MEM <= mux(reset, UInt<32>("h0"), _wMemData_MEM_T_2) @[EXE_MEM.scala 31:{31,31} 50:18]
    weMEM_ctrl_uMEM_MEM <= mux(reset, UInt<1>("h0"), _weMEM_ctrl_uMEM_MEM_T_2) @[EXE_MEM.scala 32:{38,38} 55:25]
    wRegDataSrc_ctrl_uMEM_MEM <= mux(reset, UInt<1>("h0"), _wRegDataSrc_ctrl_uMEM_MEM_T_2) @[EXE_MEM.scala 33:{44,44} 60:31]
    wrMemByteSelScr_ctrl_uMEM_MEM <= mux(reset, UInt<2>("h0"), _wrMemByteSelScr_ctrl_uMEM_MEM_T_2) @[EXE_MEM.scala 34:{48,48} 65:35]
    memReadDataExt_ctrl_uMEM_MEM <= mux(reset, UInt<1>("h0"), _memReadDataExt_ctrl_uMEM_MEM_T_2) @[EXE_MEM.scala 35:{47,47} 70:34]
    weReg_ctrl_uWB_MEM <= mux(reset, UInt<1>("h0"), _weReg_ctrl_uWB_MEM_T_2) @[EXE_MEM.scala 36:{37,37} 75:24]

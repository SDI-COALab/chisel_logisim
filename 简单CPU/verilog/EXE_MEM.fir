circuit EXE_MEM :
  module EXE_MEM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip aluResult_EXE : UInt<32>, flip wRegAddr_EXE : UInt<5>, flip wMenData_EXE : UInt<32>, flip weMEM_ctrl_uMEM_EXE : UInt<1>, flip wRegDataSrc_ctrl_uMEM_EXE : UInt<1>, flip wrMemByteSelScr_ctrl_uMEM_EXE : UInt<2>, flip memReadDataExt_ctrl_uMEM_EXE : UInt<1>, flip weReg_ctrl_uWB_EXE : UInt<1>, aluResult_MEM : UInt<32>, wRegAddr_MEM : UInt<5>, wMenData_MEM : UInt<32>, weMEM_ctrl_uMEM_MEM : UInt<1>, wRegDataSrc_ctrl_uMEM_MEM : UInt<1>, wrMemByteSelScr_ctrl_uMEM_MEM : UInt<2>, memReadDataExt_ctrl_uMEM_MEM : UInt<1>, weReg_ctrl_uWB_MEM : UInt<1>, flip flushStageMEM : UInt<1>, flip stallStageMEM : UInt<1>, flip reset : UInt<1>}

    reg aluResult_MEM : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[EXE_MEM.scala 29:32]
    reg wRegAddr_MEM : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[EXE_MEM.scala 30:31]
    reg wMenData_MEM : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[EXE_MEM.scala 31:31]
    reg weMEM_ctrl_uMEM_MEM : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[EXE_MEM.scala 32:38]
    reg wRegDataSrc_ctrl_uMEM_MEM : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[EXE_MEM.scala 33:44]
    reg wrMemByteSelScr_ctrl_uMEM_MEM : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[EXE_MEM.scala 34:48]
    reg memReadDataExt_ctrl_uMEM_MEM : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[EXE_MEM.scala 35:47]
    reg weReg_ctrl_uWB_MEM : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[EXE_MEM.scala 36:37]
    node _aluResult_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.aluResult_EXE) @[Mux.scala 101:16]
    node _aluResult_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _aluResult_MEM_T) @[Mux.scala 101:16]
    node _aluResult_MEM_T_2 = mux(io.stallStageMEM, aluResult_MEM, _aluResult_MEM_T_1) @[Mux.scala 101:16]
    aluResult_MEM <= _aluResult_MEM_T_2 @[EXE_MEM.scala 40:19]
    node _wRegAddr_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.wRegAddr_EXE) @[Mux.scala 101:16]
    node _wRegAddr_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _wRegAddr_MEM_T) @[Mux.scala 101:16]
    node _wRegAddr_MEM_T_2 = mux(io.stallStageMEM, wRegAddr_MEM, _wRegAddr_MEM_T_1) @[Mux.scala 101:16]
    wRegAddr_MEM <= _wRegAddr_MEM_T_2 @[EXE_MEM.scala 45:18]
    node _wMenData_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.wMenData_EXE) @[Mux.scala 101:16]
    node _wMenData_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _wMenData_MEM_T) @[Mux.scala 101:16]
    node _wMenData_MEM_T_2 = mux(io.stallStageMEM, wMenData_MEM, _wMenData_MEM_T_1) @[Mux.scala 101:16]
    wMenData_MEM <= _wMenData_MEM_T_2 @[EXE_MEM.scala 50:18]
    node _weMEM_ctrl_uMEM_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.weMEM_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _weMEM_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_MEM_T_2 = mux(io.stallStageMEM, weMEM_ctrl_uMEM_MEM, _weMEM_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    weMEM_ctrl_uMEM_MEM <= _weMEM_ctrl_uMEM_MEM_T_2 @[EXE_MEM.scala 55:25]
    node _wRegDataSrc_ctrl_uMEM_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.wRegDataSrc_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _wRegDataSrc_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_MEM_T_2 = mux(io.stallStageMEM, wRegDataSrc_ctrl_uMEM_MEM, _wRegDataSrc_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    wRegDataSrc_ctrl_uMEM_MEM <= _wRegDataSrc_ctrl_uMEM_MEM_T_2 @[EXE_MEM.scala 60:31]
    node _wrMemByteSelScr_ctrl_uMEM_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.wrMemByteSelScr_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _wrMemByteSelScr_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_MEM_T_2 = mux(io.stallStageMEM, wrMemByteSelScr_ctrl_uMEM_MEM, _wrMemByteSelScr_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    wrMemByteSelScr_ctrl_uMEM_MEM <= _wrMemByteSelScr_ctrl_uMEM_MEM_T_2 @[EXE_MEM.scala 65:35]
    node _memReadDataExt_ctrl_uMEM_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.memReadDataExt_ctrl_uMEM_EXE) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _memReadDataExt_ctrl_uMEM_MEM_T) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_MEM_T_2 = mux(io.stallStageMEM, memReadDataExt_ctrl_uMEM_MEM, _memReadDataExt_ctrl_uMEM_MEM_T_1) @[Mux.scala 101:16]
    memReadDataExt_ctrl_uMEM_MEM <= _memReadDataExt_ctrl_uMEM_MEM_T_2 @[EXE_MEM.scala 70:34]
    node _weReg_ctrl_uWB_MEM_T = mux(io.flushStageMEM, UInt<1>("h0"), io.weReg_ctrl_uWB_EXE) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_MEM_T_1 = mux(io.reset, UInt<1>("h0"), _weReg_ctrl_uWB_MEM_T) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_MEM_T_2 = mux(io.stallStageMEM, weReg_ctrl_uWB_MEM, _weReg_ctrl_uWB_MEM_T_1) @[Mux.scala 101:16]
    weReg_ctrl_uWB_MEM <= _weReg_ctrl_uWB_MEM_T_2 @[EXE_MEM.scala 75:24]
    io.aluResult_MEM <= aluResult_MEM @[EXE_MEM.scala 80:22]
    io.wRegAddr_MEM <= wRegAddr_MEM @[EXE_MEM.scala 81:21]
    io.wMenData_MEM <= wMenData_MEM @[EXE_MEM.scala 82:21]
    io.weMEM_ctrl_uMEM_MEM <= weMEM_ctrl_uMEM_MEM @[EXE_MEM.scala 83:28]
    io.wRegDataSrc_ctrl_uMEM_MEM <= wRegDataSrc_ctrl_uMEM_MEM @[EXE_MEM.scala 84:34]
    io.wrMemByteSelScr_ctrl_uMEM_MEM <= wrMemByteSelScr_ctrl_uMEM_MEM @[EXE_MEM.scala 85:38]
    io.memReadDataExt_ctrl_uMEM_MEM <= memReadDataExt_ctrl_uMEM_MEM @[EXE_MEM.scala 86:37]
    io.weReg_ctrl_uWB_MEM <= weReg_ctrl_uWB_MEM @[EXE_MEM.scala 87:27]


circuit ID_EXE :
  module ID_EXE :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip flushStageID : UInt<1>, flip stallStageID : UInt<1>, flip reset : UInt<1>, flip aluOP_ctrl_uEXE_ID : UInt<4>, flip data1_ID : UInt<32>, flip data2_ID : UInt<32>, flip wRegAddr_ID : UInt<5>, flip wMenData_ID : UInt<32>, flip weMEM_ctrl_uMEM_ID : UInt<1>, flip wRegDataSrc_ctrl_uMEM_ID : UInt<1>, flip wrMemByteSelScr_ctrl_uMEM_ID : UInt<2>, flip memReadDataExt_ctrl_uMEM_ID : UInt<1>, flip weReg_ctrl_uWB_ID : UInt<1>, aluOP_ctrl_uID_EXE : UInt<4>, data1_EXE : UInt<32>, data2_EXE : UInt<32>, wRegAddr_EXE : UInt<5>, wMenData_EXE : UInt<32>, weMEM_ctrl_uMEM_EXE : UInt<1>, wRegDataSrc_ctrl_uMEM_EXE : UInt<1>, wrMemByteSelScr_ctrl_uMEM_EXE : UInt<2>, memReadDataExt_ctrl_uMEM_EXE : UInt<1>, weReg_ctrl_uWB_EXE : UInt<1>}

    reg aluOP_ctrl_uEXE_ID : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[ID_EXE.scala 35:35]
    reg data1_ID : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ID_EXE.scala 36:25]
    reg data2_ID : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ID_EXE.scala 37:25]
    reg wRegAddr_ID : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[ID_EXE.scala 38:28]
    reg wMenData_ID : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ID_EXE.scala 39:28]
    reg weMEM_ctrl_uMEM_ID : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ID_EXE.scala 40:35]
    reg wRegDataSrc_ctrl_uMEM_ID : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ID_EXE.scala 41:41]
    reg wrMemByteSelScr_ctrl_uMEM_ID : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[ID_EXE.scala 42:45]
    reg memReadDataExt_ctrl_uMEM_ID : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ID_EXE.scala 43:44]
    reg weReg_ctrl_uWB_ID : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ID_EXE.scala 44:34]
    node _aluOP_ctrl_uEXE_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.aluOP_ctrl_uEXE_ID) @[Mux.scala 101:16]
    node _aluOP_ctrl_uEXE_ID_T_1 = mux(io.reset, UInt<1>("h0"), _aluOP_ctrl_uEXE_ID_T) @[Mux.scala 101:16]
    node _aluOP_ctrl_uEXE_ID_T_2 = mux(io.stallStageID, aluOP_ctrl_uEXE_ID, _aluOP_ctrl_uEXE_ID_T_1) @[Mux.scala 101:16]
    aluOP_ctrl_uEXE_ID <= _aluOP_ctrl_uEXE_ID_T_2 @[ID_EXE.scala 46:22]
    node _data1_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.data1_ID) @[Mux.scala 101:16]
    node _data1_ID_T_1 = mux(io.reset, UInt<1>("h0"), _data1_ID_T) @[Mux.scala 101:16]
    node _data1_ID_T_2 = mux(io.stallStageID, data1_ID, _data1_ID_T_1) @[Mux.scala 101:16]
    data1_ID <= _data1_ID_T_2 @[ID_EXE.scala 51:12]
    node _data2_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.data2_ID) @[Mux.scala 101:16]
    node _data2_ID_T_1 = mux(io.reset, UInt<1>("h0"), _data2_ID_T) @[Mux.scala 101:16]
    node _data2_ID_T_2 = mux(io.stallStageID, data2_ID, _data2_ID_T_1) @[Mux.scala 101:16]
    data2_ID <= _data2_ID_T_2 @[ID_EXE.scala 56:12]
    node _wRegAddr_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.wRegAddr_ID) @[Mux.scala 101:16]
    node _wRegAddr_ID_T_1 = mux(io.reset, UInt<1>("h0"), _wRegAddr_ID_T) @[Mux.scala 101:16]
    node _wRegAddr_ID_T_2 = mux(io.stallStageID, wRegAddr_ID, _wRegAddr_ID_T_1) @[Mux.scala 101:16]
    wRegAddr_ID <= _wRegAddr_ID_T_2 @[ID_EXE.scala 61:15]
    node _wMenData_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.wMenData_ID) @[Mux.scala 101:16]
    node _wMenData_ID_T_1 = mux(io.reset, UInt<1>("h0"), _wMenData_ID_T) @[Mux.scala 101:16]
    node _wMenData_ID_T_2 = mux(io.stallStageID, wMenData_ID, _wMenData_ID_T_1) @[Mux.scala 101:16]
    wMenData_ID <= _wMenData_ID_T_2 @[ID_EXE.scala 66:15]
    node _weMEM_ctrl_uMEM_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.weMEM_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_ID_T_1 = mux(io.reset, UInt<1>("h0"), _weMEM_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_ID_T_2 = mux(io.stallStageID, weMEM_ctrl_uMEM_ID, _weMEM_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    weMEM_ctrl_uMEM_ID <= _weMEM_ctrl_uMEM_ID_T_2 @[ID_EXE.scala 71:22]
    node _wRegDataSrc_ctrl_uMEM_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.wRegDataSrc_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_ID_T_1 = mux(io.reset, UInt<1>("h0"), _wRegDataSrc_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_ID_T_2 = mux(io.stallStageID, wRegDataSrc_ctrl_uMEM_ID, _wRegDataSrc_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    wRegDataSrc_ctrl_uMEM_ID <= _wRegDataSrc_ctrl_uMEM_ID_T_2 @[ID_EXE.scala 76:28]
    node _wrMemByteSelScr_ctrl_uMEM_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.wrMemByteSelScr_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_ID_T_1 = mux(io.reset, UInt<1>("h0"), _wrMemByteSelScr_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_ID_T_2 = mux(io.stallStageID, wrMemByteSelScr_ctrl_uMEM_ID, _wrMemByteSelScr_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    wrMemByteSelScr_ctrl_uMEM_ID <= _wrMemByteSelScr_ctrl_uMEM_ID_T_2 @[ID_EXE.scala 81:32]
    node _memReadDataExt_ctrl_uMEM_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.memReadDataExt_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_ID_T_1 = mux(io.reset, UInt<1>("h0"), _memReadDataExt_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_ID_T_2 = mux(io.stallStageID, memReadDataExt_ctrl_uMEM_ID, _memReadDataExt_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    memReadDataExt_ctrl_uMEM_ID <= _memReadDataExt_ctrl_uMEM_ID_T_2 @[ID_EXE.scala 86:31]
    node _weReg_ctrl_uWB_ID_T = mux(io.flushStageID, UInt<1>("h0"), io.weReg_ctrl_uWB_ID) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_ID_T_1 = mux(io.reset, UInt<1>("h0"), _weReg_ctrl_uWB_ID_T) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_ID_T_2 = mux(io.stallStageID, weReg_ctrl_uWB_ID, _weReg_ctrl_uWB_ID_T_1) @[Mux.scala 101:16]
    weReg_ctrl_uWB_ID <= _weReg_ctrl_uWB_ID_T_2 @[ID_EXE.scala 91:21]
    io.aluOP_ctrl_uID_EXE <= aluOP_ctrl_uEXE_ID @[ID_EXE.scala 96:25]
    io.data1_EXE <= data1_ID @[ID_EXE.scala 97:16]
    io.data2_EXE <= data2_ID @[ID_EXE.scala 98:16]
    io.wRegAddr_EXE <= wRegAddr_ID @[ID_EXE.scala 99:19]
    io.wMenData_EXE <= wMenData_ID @[ID_EXE.scala 100:19]
    io.weMEM_ctrl_uMEM_EXE <= weMEM_ctrl_uMEM_ID @[ID_EXE.scala 101:26]
    io.wRegDataSrc_ctrl_uMEM_EXE <= wRegDataSrc_ctrl_uMEM_ID @[ID_EXE.scala 102:32]
    io.wrMemByteSelScr_ctrl_uMEM_EXE <= wrMemByteSelScr_ctrl_uMEM_ID @[ID_EXE.scala 103:36]
    io.memReadDataExt_ctrl_uMEM_EXE <= memReadDataExt_ctrl_uMEM_ID @[ID_EXE.scala 104:35]
    io.weReg_ctrl_uWB_EXE <= weReg_ctrl_uWB_ID @[ID_EXE.scala 105:25]


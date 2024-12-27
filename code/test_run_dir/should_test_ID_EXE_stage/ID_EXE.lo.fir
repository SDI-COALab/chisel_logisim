circuit ID_EXE :
  module ID_EXE :
    input clock : Clock
    input reset : UInt<1>
    input io_flushStageID : UInt<1>
    input io_stallStageID : UInt<1>
    input io_reset : UInt<1>
    input io_aluOP_ctrl_uEXE_ID : UInt<4>
    input io_data1_ID : UInt<32>
    input io_data2_ID : UInt<32>
    input io_wRegAddr_ID : UInt<5>
    input io_wMemData_ID : UInt<32>
    input io_weMEM_ctrl_uMEM_ID : UInt<1>
    input io_wRegDataSrc_ctrl_uMEM_ID : UInt<1>
    input io_wrMemByteSelScr_ctrl_uMEM_ID : UInt<2>
    input io_memReadDataExt_ctrl_uMEM_ID : UInt<1>
    input io_weReg_ctrl_uWB_ID : UInt<1>
    output io_aluOP_ctrl_uID_EXE : UInt<4>
    output io_data1_EXE : UInt<32>
    output io_data2_EXE : UInt<32>
    output io_wRegAddr_EXE : UInt<5>
    output io_wMemData_EXE : UInt<32>
    output io_weMEM_ctrl_uMEM_EXE : UInt<1>
    output io_wRegDataSrc_ctrl_uMEM_EXE : UInt<1>
    output io_wrMemByteSelScr_ctrl_uMEM_EXE : UInt<2>
    output io_memReadDataExt_ctrl_uMEM_EXE : UInt<1>
    output io_weReg_ctrl_uWB_EXE : UInt<1>

    reg aluOP_ctrl_uEXE_ID : UInt<4>, clock with :
      reset => (UInt<1>("h0"), aluOP_ctrl_uEXE_ID) @[ID_EXE.scala 35:35]
    reg data1_ID : UInt<32>, clock with :
      reset => (UInt<1>("h0"), data1_ID) @[ID_EXE.scala 36:25]
    reg data2_ID : UInt<32>, clock with :
      reset => (UInt<1>("h0"), data2_ID) @[ID_EXE.scala 37:25]
    reg wRegAddr_ID : UInt<5>, clock with :
      reset => (UInt<1>("h0"), wRegAddr_ID) @[ID_EXE.scala 38:28]
    reg wMemData_ID : UInt<32>, clock with :
      reset => (UInt<1>("h0"), wMemData_ID) @[ID_EXE.scala 39:28]
    reg weMEM_ctrl_uMEM_ID : UInt<1>, clock with :
      reset => (UInt<1>("h0"), weMEM_ctrl_uMEM_ID) @[ID_EXE.scala 40:35]
    reg wRegDataSrc_ctrl_uMEM_ID : UInt<1>, clock with :
      reset => (UInt<1>("h0"), wRegDataSrc_ctrl_uMEM_ID) @[ID_EXE.scala 41:41]
    reg wrMemByteSelScr_ctrl_uMEM_ID : UInt<2>, clock with :
      reset => (UInt<1>("h0"), wrMemByteSelScr_ctrl_uMEM_ID) @[ID_EXE.scala 42:45]
    reg memReadDataExt_ctrl_uMEM_ID : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memReadDataExt_ctrl_uMEM_ID) @[ID_EXE.scala 43:44]
    reg weReg_ctrl_uWB_ID : UInt<1>, clock with :
      reset => (UInt<1>("h0"), weReg_ctrl_uWB_ID) @[ID_EXE.scala 44:34]
    node _aluOP_ctrl_uEXE_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_aluOP_ctrl_uEXE_ID) @[Mux.scala 101:16]
    node _aluOP_ctrl_uEXE_ID_T_1 = mux(io_reset, UInt<1>("h0"), _aluOP_ctrl_uEXE_ID_T) @[Mux.scala 101:16]
    node _aluOP_ctrl_uEXE_ID_T_2 = mux(io_stallStageID, aluOP_ctrl_uEXE_ID, _aluOP_ctrl_uEXE_ID_T_1) @[Mux.scala 101:16]
    node _data1_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_data1_ID) @[Mux.scala 101:16]
    node _data1_ID_T_1 = mux(io_reset, UInt<1>("h0"), _data1_ID_T) @[Mux.scala 101:16]
    node _data1_ID_T_2 = mux(io_stallStageID, data1_ID, _data1_ID_T_1) @[Mux.scala 101:16]
    node _data2_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_data2_ID) @[Mux.scala 101:16]
    node _data2_ID_T_1 = mux(io_reset, UInt<1>("h0"), _data2_ID_T) @[Mux.scala 101:16]
    node _data2_ID_T_2 = mux(io_stallStageID, data2_ID, _data2_ID_T_1) @[Mux.scala 101:16]
    node _wRegAddr_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_wRegAddr_ID) @[Mux.scala 101:16]
    node _wRegAddr_ID_T_1 = mux(io_reset, UInt<1>("h0"), _wRegAddr_ID_T) @[Mux.scala 101:16]
    node _wRegAddr_ID_T_2 = mux(io_stallStageID, wRegAddr_ID, _wRegAddr_ID_T_1) @[Mux.scala 101:16]
    node _wMemData_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_wMemData_ID) @[Mux.scala 101:16]
    node _wMemData_ID_T_1 = mux(io_reset, UInt<1>("h0"), _wMemData_ID_T) @[Mux.scala 101:16]
    node _wMemData_ID_T_2 = mux(io_stallStageID, wMemData_ID, _wMemData_ID_T_1) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_weMEM_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_ID_T_1 = mux(io_reset, UInt<1>("h0"), _weMEM_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _weMEM_ctrl_uMEM_ID_T_2 = mux(io_stallStageID, weMEM_ctrl_uMEM_ID, _weMEM_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_wRegDataSrc_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_ID_T_1 = mux(io_reset, UInt<1>("h0"), _wRegDataSrc_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _wRegDataSrc_ctrl_uMEM_ID_T_2 = mux(io_stallStageID, wRegDataSrc_ctrl_uMEM_ID, _wRegDataSrc_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_wrMemByteSelScr_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_ID_T_1 = mux(io_reset, UInt<1>("h0"), _wrMemByteSelScr_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _wrMemByteSelScr_ctrl_uMEM_ID_T_2 = mux(io_stallStageID, wrMemByteSelScr_ctrl_uMEM_ID, _wrMemByteSelScr_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_memReadDataExt_ctrl_uMEM_ID) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_ID_T_1 = mux(io_reset, UInt<1>("h0"), _memReadDataExt_ctrl_uMEM_ID_T) @[Mux.scala 101:16]
    node _memReadDataExt_ctrl_uMEM_ID_T_2 = mux(io_stallStageID, memReadDataExt_ctrl_uMEM_ID, _memReadDataExt_ctrl_uMEM_ID_T_1) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_ID_T = mux(io_flushStageID, UInt<1>("h0"), io_weReg_ctrl_uWB_ID) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_ID_T_1 = mux(io_reset, UInt<1>("h0"), _weReg_ctrl_uWB_ID_T) @[Mux.scala 101:16]
    node _weReg_ctrl_uWB_ID_T_2 = mux(io_stallStageID, weReg_ctrl_uWB_ID, _weReg_ctrl_uWB_ID_T_1) @[Mux.scala 101:16]
    io_aluOP_ctrl_uID_EXE <= aluOP_ctrl_uEXE_ID @[ID_EXE.scala 96:25]
    io_data1_EXE <= data1_ID @[ID_EXE.scala 97:16]
    io_data2_EXE <= data2_ID @[ID_EXE.scala 98:16]
    io_wRegAddr_EXE <= wRegAddr_ID @[ID_EXE.scala 99:19]
    io_wMemData_EXE <= wMemData_ID @[ID_EXE.scala 100:19]
    io_weMEM_ctrl_uMEM_EXE <= weMEM_ctrl_uMEM_ID @[ID_EXE.scala 101:26]
    io_wRegDataSrc_ctrl_uMEM_EXE <= wRegDataSrc_ctrl_uMEM_ID @[ID_EXE.scala 102:32]
    io_wrMemByteSelScr_ctrl_uMEM_EXE <= wrMemByteSelScr_ctrl_uMEM_ID @[ID_EXE.scala 103:36]
    io_memReadDataExt_ctrl_uMEM_EXE <= memReadDataExt_ctrl_uMEM_ID @[ID_EXE.scala 104:35]
    io_weReg_ctrl_uWB_EXE <= weReg_ctrl_uWB_ID @[ID_EXE.scala 105:25]
    aluOP_ctrl_uEXE_ID <= mux(reset, UInt<4>("h0"), _aluOP_ctrl_uEXE_ID_T_2) @[ID_EXE.scala 35:{35,35} 46:22]
    data1_ID <= mux(reset, UInt<32>("h0"), _data1_ID_T_2) @[ID_EXE.scala 36:{25,25} 51:12]
    data2_ID <= mux(reset, UInt<32>("h0"), _data2_ID_T_2) @[ID_EXE.scala 37:{25,25} 56:12]
    wRegAddr_ID <= mux(reset, UInt<5>("h0"), _wRegAddr_ID_T_2) @[ID_EXE.scala 38:{28,28} 61:15]
    wMemData_ID <= mux(reset, UInt<32>("h0"), _wMemData_ID_T_2) @[ID_EXE.scala 39:{28,28} 66:15]
    weMEM_ctrl_uMEM_ID <= mux(reset, UInt<1>("h0"), _weMEM_ctrl_uMEM_ID_T_2) @[ID_EXE.scala 40:{35,35} 71:22]
    wRegDataSrc_ctrl_uMEM_ID <= mux(reset, UInt<1>("h0"), _wRegDataSrc_ctrl_uMEM_ID_T_2) @[ID_EXE.scala 41:{41,41} 76:28]
    wrMemByteSelScr_ctrl_uMEM_ID <= mux(reset, UInt<2>("h0"), _wrMemByteSelScr_ctrl_uMEM_ID_T_2) @[ID_EXE.scala 42:{45,45} 81:32]
    memReadDataExt_ctrl_uMEM_ID <= mux(reset, UInt<1>("h0"), _memReadDataExt_ctrl_uMEM_ID_T_2) @[ID_EXE.scala 43:{44,44} 86:31]
    weReg_ctrl_uWB_ID <= mux(reset, UInt<1>("h0"), _weReg_ctrl_uWB_ID_T_2) @[ID_EXE.scala 44:{34,34} 91:21]

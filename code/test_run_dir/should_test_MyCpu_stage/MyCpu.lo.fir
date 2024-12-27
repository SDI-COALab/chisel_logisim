circuit MyCpu :
  module IF :
    input clock : Clock
    input reset : UInt<1>
    input io_stallStageIF : UInt<1>
    input io_branchTarget_ID : UInt<32>
    input io_branchFlag_ID : UInt<1>
    input io_reset : UInt<1>
    output io_PC_IF : UInt<32>
    output io_instr_IF : UInt<32>

    mem mem : @[IF.scala 22:18]
      data-type => UInt<8>
      depth => 128
      read-latency => 0
      write-latency => 1
      reader => instr_IF_MPORT
      reader => instr_IF_MPORT_1
      reader => instr_IF_MPORT_2
      reader => instr_IF_MPORT_3
      read-under-write => undefined
    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[IF.scala 24:21]
    node _nextPC_T = add(PC, UInt<32>("h4")) @[IF.scala 28:32]
    node _nextPC_T_1 = tail(_nextPC_T, 1) @[IF.scala 28:32]
    node nextPC = mux(io_branchFlag_ID, io_branchTarget_ID, _nextPC_T_1) @[Mux.scala 101:16]
    node _PC_T = mux(io_branchFlag_ID, io_branchTarget_ID, nextPC) @[Mux.scala 101:16]
    node _PC_T_1 = mux(io_reset, UInt<32>("h0"), _PC_T) @[Mux.scala 101:16]
    node _PC_T_2 = mux(io_stallStageIF, PC, _PC_T_1) @[Mux.scala 101:16]
    node _instr_IF_T = add(PC, UInt<32>("h3")) @[IF.scala 38:31]
    node _instr_IF_T_1 = tail(_instr_IF_T, 1) @[IF.scala 38:31]
    node _instr_IF_T_2 = bits(_instr_IF_T_1, 6, 0) @[IF.scala 38:27]
    node _instr_IF_T_3 = add(PC, UInt<32>("h2")) @[IF.scala 38:58]
    node _instr_IF_T_4 = tail(_instr_IF_T_3, 1) @[IF.scala 38:58]
    node _instr_IF_T_5 = bits(_instr_IF_T_4, 6, 0) @[IF.scala 38:54]
    node _instr_IF_T_6 = add(PC, UInt<32>("h1")) @[IF.scala 38:85]
    node _instr_IF_T_7 = tail(_instr_IF_T_6, 1) @[IF.scala 38:85]
    node _instr_IF_T_8 = bits(_instr_IF_T_7, 6, 0) @[IF.scala 38:81]
    node _instr_IF_T_9 = bits(PC, 6, 0) @[IF.scala 38:108]
    node instr_IF_lo = cat(mem.instr_IF_MPORT_2.data, mem.instr_IF_MPORT_3.data) @[Cat.scala 31:58]
    node instr_IF_hi = cat(mem.instr_IF_MPORT.data, mem.instr_IF_MPORT_1.data) @[Cat.scala 31:58]
    node instr_IF = cat(instr_IF_hi, instr_IF_lo) @[Cat.scala 31:58]
    io_PC_IF <= PC @[IF.scala 40:14]
    io_instr_IF <= instr_IF @[IF.scala 41:17]
    mem.instr_IF_MPORT.addr <= _instr_IF_T_2 @[IF.scala 38:27]
    mem.instr_IF_MPORT.en <= UInt<1>("h1") @[IF.scala 38:27]
    mem.instr_IF_MPORT.clk <= clock @[IF.scala 38:27]
    mem.instr_IF_MPORT_1.addr <= _instr_IF_T_5 @[IF.scala 38:54]
    mem.instr_IF_MPORT_1.en <= UInt<1>("h1") @[IF.scala 38:54]
    mem.instr_IF_MPORT_1.clk <= clock @[IF.scala 38:54]
    mem.instr_IF_MPORT_2.addr <= _instr_IF_T_8 @[IF.scala 38:81]
    mem.instr_IF_MPORT_2.en <= UInt<1>("h1") @[IF.scala 38:81]
    mem.instr_IF_MPORT_2.clk <= clock @[IF.scala 38:81]
    mem.instr_IF_MPORT_3.addr <= _instr_IF_T_9 @[IF.scala 38:108]
    mem.instr_IF_MPORT_3.en <= UInt<1>("h1") @[IF.scala 38:108]
    mem.instr_IF_MPORT_3.clk <= clock @[IF.scala 38:108]
    PC <= mux(reset, UInt<32>("h0"), _PC_T_2) @[IF.scala 24:{21,21} 32:8]

  module IF_ID :
    input clock : Clock
    input reset : UInt<1>
    input io_PC_IF : UInt<32>
    input io_instr_IF : UInt<32>
    input io_flushStageID : UInt<1>
    input io_stallStageID : UInt<1>
    input io_reset : UInt<1>
    output io_PC_ID : UInt<32>
    output io_instr_ID : UInt<32>

    reg PC_ID_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC_ID_reg) @[IF_ID.scala 18:28]
    reg instr_ID_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instr_ID_reg) @[IF_ID.scala 19:31]
    node _PC_ID_reg_T = mux(io_flushStageID, UInt<1>("h0"), io_PC_IF) @[Mux.scala 101:16]
    node _PC_ID_reg_T_1 = mux(io_reset, UInt<32>("h0"), _PC_ID_reg_T) @[Mux.scala 101:16]
    node _PC_ID_reg_T_2 = mux(io_stallStageID, PC_ID_reg, _PC_ID_reg_T_1) @[Mux.scala 101:16]
    node _instr_ID_reg_T = mux(io_flushStageID, UInt<1>("h0"), io_instr_IF) @[Mux.scala 101:16]
    node _instr_ID_reg_T_1 = mux(io_reset, UInt<32>("h0"), _instr_ID_reg_T) @[Mux.scala 101:16]
    node _instr_ID_reg_T_2 = mux(io_stallStageID, instr_ID_reg, _instr_ID_reg_T_1) @[Mux.scala 101:16]
    io_PC_ID <= PC_ID_reg @[IF_ID.scala 37:14]
    io_instr_ID <= instr_ID_reg @[IF_ID.scala 38:17]
    PC_ID_reg <= mux(reset, UInt<32>("h0"), _PC_ID_reg_T_2) @[IF_ID.scala 18:{28,28} 24:15]
    instr_ID_reg <= mux(reset, UInt<32>("h0"), _instr_ID_reg_T_2) @[IF_ID.scala 19:{31,31} 31:18]

  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_PC_ID : UInt<32>
    input io_instr_ID : UInt<32>
    input io_reset : UInt<1>
    input io_wRegAddr_EXE : UInt<5>
    input io_wRegAddr_MEM : UInt<5>
    input io_aluResult_EXE : UInt<32>
    input io_wRegData_MEM : UInt<32>
    input io_wRegDataSrc_ctrl_uMEM_EXE : UInt<1>
    input io_wReg_ctrl_WB : UInt<1>
    input io_wRegaddr_WB : UInt<5>
    input io_wRegData_WB : UInt<32>
    output io_data1_ID : UInt<32>
    output io_data2_ID : UInt<32>
    output io_wRegAddr_ID : UInt<5>
    output io_wMemData_ID : UInt<32>
    output io_branchTarge_ID : UInt<32>
    output io_branchFlag_ID : UInt<1>
    output io_stallReqOfID_ID : UInt<1>
    output io_flushReqOfID_ID : UInt<1>
    output io_weReg_ctrl_uWB_ID : UInt<1>
    output io_memReadDataExt_ctrl_uMEM_ID : UInt<1>
    output io_wrMemByteSelScr_ctrl_uMEM_ID : UInt<2>
    output io_wRegDataSrc_ctrl_uMEM_ID : UInt<1>
    output io_weMEM_ctrl_uMEM_ID : UInt<1>
    output io_aluOP_ctrl_uEXE_ID : UInt<4>

    mem regfile : @[ID.scala 37:22]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => data1_MPORT
      reader => data2_MPORT
      reader => wMemData_MPORT
      reader => wMemData_MPORT_1
      reader => wMemData_MPORT_2
      writer => MPORT
      read-under-write => undefined
    node _T = eq(io_wReg_ctrl_WB, UInt<1>("h1")) @[ID.scala 39:26]
    node _GEN_0 = validif(_T, io_wRegaddr_WB) @[ID.scala 39:35 40:16]
    node _GEN_1 = validif(_T, clock) @[ID.scala 39:35 40:16]
    node _GEN_2 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[ID.scala 39:35 40:16 37:22]
    node _GEN_3 = validif(_T, UInt<1>("h1")) @[ID.scala 39:35 40:33]
    node _GEN_4 = validif(_T, io_wRegData_WB) @[ID.scala 39:35 40:33]
    node si12 = bits(io_instr_ID, 21, 10) @[ID.scala 43:27]
    node _ext_si12_T = bits(si12, 11, 11) @[ID.scala 44:37]
    node _ext_si12_T_1 = bits(_ext_si12_T, 0, 0) @[Bitwise.scala 74:15]
    node _ext_si12_T_2 = mux(_ext_si12_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node ext_si12 = cat(_ext_si12_T_2, si12) @[Cat.scala 31:58]
    node o16 = bits(io_instr_ID, 25, 10) @[ID.scala 45:26]
    node _ext_o16_T = bits(o16, 15, 15) @[ID.scala 47:35]
    node _ext_o16_T_1 = bits(_ext_o16_T, 0, 0) @[Bitwise.scala 74:15]
    node _ext_o16_T_2 = mux(_ext_o16_T_1, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _ext_o16_T_3 = dshl(o16, UInt<2>("h2")) @[ID.scala 47:46]
    node ext_o16 = cat(_ext_o16_T_2, _ext_o16_T_3) @[Cat.scala 31:58]
    node si20 = bits(io_instr_ID, 24, 5) @[ID.scala 49:27]
    node _ext_si20_T = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node ext_si20 = cat(si20, _ext_si20_T) @[Cat.scala 31:58]
    node _o26_T = bits(io_instr_ID, 9, 0) @[ID.scala 51:30]
    node _o26_T_1 = bits(io_instr_ID, 25, 10) @[ID.scala 51:49]
    node o26 = cat(_o26_T, _o26_T_1) @[Cat.scala 31:58]
    node _ext_o26_T = bits(o26, 25, 25) @[ID.scala 52:34]
    node _ext_o26_T_1 = bits(_ext_o26_T, 0, 0) @[Bitwise.scala 74:15]
    node _ext_o26_T_2 = mux(_ext_o26_T_1, UInt<6>("h3f"), UInt<6>("h0")) @[Bitwise.scala 74:12]
    node _ext_o26_T_3 = dshl(o26, UInt<2>("h2")) @[ID.scala 52:45]
    node ext_o26 = cat(_ext_o26_T_2, _ext_o26_T_3) @[Cat.scala 31:58]
    node rj_addr = bits(io_instr_ID, 9, 5) @[ID.scala 53:30]
    node rk_addr = bits(io_instr_ID, 14, 10) @[ID.scala 54:30]
    node ui5_addr = bits(io_instr_ID, 14, 10) @[ID.scala 55:31]
    node rd_addr = bits(io_instr_ID, 4, 0) @[ID.scala 56:30]
    node _csignals_T = and(io_instr_ID, UInt<32>("hffff8000")) @[Lookup.scala 31:38]
    node _csignals_T_1 = eq(UInt<21>("h100000"), _csignals_T) @[Lookup.scala 31:38]
    node _csignals_T_2 = and(io_instr_ID, UInt<32>("hffff8000")) @[Lookup.scala 31:38]
    node _csignals_T_3 = eq(UInt<21>("h178000"), _csignals_T_2) @[Lookup.scala 31:38]
    node _csignals_T_4 = and(io_instr_ID, UInt<32>("hffff8000")) @[Lookup.scala 31:38]
    node _csignals_T_5 = eq(UInt<21>("h180000"), _csignals_T_4) @[Lookup.scala 31:38]
    node _csignals_T_6 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_7 = eq(UInt<26>("h2800000"), _csignals_T_6) @[Lookup.scala 31:38]
    node _csignals_T_8 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_9 = eq(UInt<30>("h28000000"), _csignals_T_8) @[Lookup.scala 31:38]
    node _csignals_T_10 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_11 = eq(UInt<30>("h28400000"), _csignals_T_10) @[Lookup.scala 31:38]
    node _csignals_T_12 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_13 = eq(UInt<30>("h28800000"), _csignals_T_12) @[Lookup.scala 31:38]
    node _csignals_T_14 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_15 = eq(UInt<30>("h29000000"), _csignals_T_14) @[Lookup.scala 31:38]
    node _csignals_T_16 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_17 = eq(UInt<30>("h29400000"), _csignals_T_16) @[Lookup.scala 31:38]
    node _csignals_T_18 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_19 = eq(UInt<30>("h29800000"), _csignals_T_18) @[Lookup.scala 31:38]
    node _csignals_T_20 = and(io_instr_ID, UInt<32>("hfe000000")) @[Lookup.scala 31:38]
    node _csignals_T_21 = eq(UInt<29>("h14000000"), _csignals_T_20) @[Lookup.scala 31:38]
    node _csignals_T_22 = and(io_instr_ID, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _csignals_T_23 = eq(UInt<31>("h54000000"), _csignals_T_22) @[Lookup.scala 31:38]
    node _csignals_T_24 = and(io_instr_ID, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _csignals_T_25 = eq(UInt<31>("h4c000000"), _csignals_T_24) @[Lookup.scala 31:38]
    node _csignals_T_26 = and(io_instr_ID, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _csignals_T_27 = eq(UInt<31>("h58000000"), _csignals_T_26) @[Lookup.scala 31:38]
    node _csignals_T_28 = and(io_instr_ID, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _csignals_T_29 = eq(UInt<31>("h64000000"), _csignals_T_28) @[Lookup.scala 31:38]
    node _csignals_T_30 = and(io_instr_ID, UInt<32>("hfc000000")) @[Lookup.scala 31:38]
    node _csignals_T_31 = eq(UInt<31>("h68000000"), _csignals_T_30) @[Lookup.scala 31:38]
    node _csignals_T_32 = and(io_instr_ID, UInt<32>("hffc00000")) @[Lookup.scala 31:38]
    node _csignals_T_33 = eq(UInt<26>("h2000000"), _csignals_T_32) @[Lookup.scala 31:38]
    node _csignals_T_34 = and(io_instr_ID, UInt<32>("hffff8000")) @[Lookup.scala 31:38]
    node _csignals_T_35 = eq(UInt<23>("h488000"), _csignals_T_34) @[Lookup.scala 31:38]
    node _csignals_T_36 = mux(_csignals_T_35, UInt<4>("h2"), UInt<4>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_37 = mux(_csignals_T_33, UInt<4>("h9"), _csignals_T_36) @[Lookup.scala 34:39]
    node _csignals_T_38 = mux(_csignals_T_31, UInt<4>("h6"), _csignals_T_37) @[Lookup.scala 34:39]
    node _csignals_T_39 = mux(_csignals_T_29, UInt<4>("h5"), _csignals_T_38) @[Lookup.scala 34:39]
    node _csignals_T_40 = mux(_csignals_T_27, UInt<4>("h4"), _csignals_T_39) @[Lookup.scala 34:39]
    node _csignals_T_41 = mux(_csignals_T_25, UInt<4>("h1"), _csignals_T_40) @[Lookup.scala 34:39]
    node _csignals_T_42 = mux(_csignals_T_23, UInt<4>("h7"), _csignals_T_41) @[Lookup.scala 34:39]
    node _csignals_T_43 = mux(_csignals_T_21, UInt<4>("h0"), _csignals_T_42) @[Lookup.scala 34:39]
    node _csignals_T_44 = mux(_csignals_T_19, UInt<4>("h1"), _csignals_T_43) @[Lookup.scala 34:39]
    node _csignals_T_45 = mux(_csignals_T_17, UInt<4>("h1"), _csignals_T_44) @[Lookup.scala 34:39]
    node _csignals_T_46 = mux(_csignals_T_15, UInt<4>("h1"), _csignals_T_45) @[Lookup.scala 34:39]
    node _csignals_T_47 = mux(_csignals_T_13, UInt<4>("h1"), _csignals_T_46) @[Lookup.scala 34:39]
    node _csignals_T_48 = mux(_csignals_T_11, UInt<4>("h1"), _csignals_T_47) @[Lookup.scala 34:39]
    node _csignals_T_49 = mux(_csignals_T_9, UInt<4>("h1"), _csignals_T_48) @[Lookup.scala 34:39]
    node _csignals_T_50 = mux(_csignals_T_7, UInt<4>("h1"), _csignals_T_49) @[Lookup.scala 34:39]
    node _csignals_T_51 = mux(_csignals_T_5, UInt<4>("h3"), _csignals_T_50) @[Lookup.scala 34:39]
    node _csignals_T_52 = mux(_csignals_T_3, UInt<4>("h2"), _csignals_T_51) @[Lookup.scala 34:39]
    node csignals_0 = mux(_csignals_T_1, UInt<4>("h1"), _csignals_T_52) @[Lookup.scala 34:39]
    node _csignals_T_53 = mux(_csignals_T_35, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_54 = mux(_csignals_T_33, UInt<1>("h1"), _csignals_T_53) @[Lookup.scala 34:39]
    node _csignals_T_55 = mux(_csignals_T_31, UInt<1>("h1"), _csignals_T_54) @[Lookup.scala 34:39]
    node _csignals_T_56 = mux(_csignals_T_29, UInt<1>("h1"), _csignals_T_55) @[Lookup.scala 34:39]
    node _csignals_T_57 = mux(_csignals_T_27, UInt<1>("h1"), _csignals_T_56) @[Lookup.scala 34:39]
    node _csignals_T_58 = mux(_csignals_T_25, UInt<1>("h1"), _csignals_T_57) @[Lookup.scala 34:39]
    node _csignals_T_59 = mux(_csignals_T_23, UInt<1>("h0"), _csignals_T_58) @[Lookup.scala 34:39]
    node _csignals_T_60 = mux(_csignals_T_21, UInt<1>("h0"), _csignals_T_59) @[Lookup.scala 34:39]
    node _csignals_T_61 = mux(_csignals_T_19, UInt<1>("h1"), _csignals_T_60) @[Lookup.scala 34:39]
    node _csignals_T_62 = mux(_csignals_T_17, UInt<1>("h1"), _csignals_T_61) @[Lookup.scala 34:39]
    node _csignals_T_63 = mux(_csignals_T_15, UInt<1>("h1"), _csignals_T_62) @[Lookup.scala 34:39]
    node _csignals_T_64 = mux(_csignals_T_13, UInt<1>("h1"), _csignals_T_63) @[Lookup.scala 34:39]
    node _csignals_T_65 = mux(_csignals_T_11, UInt<1>("h1"), _csignals_T_64) @[Lookup.scala 34:39]
    node _csignals_T_66 = mux(_csignals_T_9, UInt<1>("h1"), _csignals_T_65) @[Lookup.scala 34:39]
    node _csignals_T_67 = mux(_csignals_T_7, UInt<1>("h1"), _csignals_T_66) @[Lookup.scala 34:39]
    node _csignals_T_68 = mux(_csignals_T_5, UInt<1>("h1"), _csignals_T_67) @[Lookup.scala 34:39]
    node _csignals_T_69 = mux(_csignals_T_3, UInt<1>("h1"), _csignals_T_68) @[Lookup.scala 34:39]
    node csignals_1 = mux(_csignals_T_1, UInt<1>("h1"), _csignals_T_69) @[Lookup.scala 34:39]
    node _csignals_T_70 = mux(_csignals_T_35, UInt<2>("h3"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_71 = mux(_csignals_T_33, UInt<2>("h0"), _csignals_T_70) @[Lookup.scala 34:39]
    node _csignals_T_72 = mux(_csignals_T_31, UInt<2>("h2"), _csignals_T_71) @[Lookup.scala 34:39]
    node _csignals_T_73 = mux(_csignals_T_29, UInt<2>("h2"), _csignals_T_72) @[Lookup.scala 34:39]
    node _csignals_T_74 = mux(_csignals_T_27, UInt<2>("h2"), _csignals_T_73) @[Lookup.scala 34:39]
    node _csignals_T_75 = mux(_csignals_T_25, UInt<2>("h0"), _csignals_T_74) @[Lookup.scala 34:39]
    node _csignals_T_76 = mux(_csignals_T_23, UInt<2>("h0"), _csignals_T_75) @[Lookup.scala 34:39]
    node _csignals_T_77 = mux(_csignals_T_21, UInt<2>("h0"), _csignals_T_76) @[Lookup.scala 34:39]
    node _csignals_T_78 = mux(_csignals_T_19, UInt<2>("h2"), _csignals_T_77) @[Lookup.scala 34:39]
    node _csignals_T_79 = mux(_csignals_T_17, UInt<2>("h2"), _csignals_T_78) @[Lookup.scala 34:39]
    node _csignals_T_80 = mux(_csignals_T_15, UInt<2>("h2"), _csignals_T_79) @[Lookup.scala 34:39]
    node _csignals_T_81 = mux(_csignals_T_13, UInt<2>("h0"), _csignals_T_80) @[Lookup.scala 34:39]
    node _csignals_T_82 = mux(_csignals_T_11, UInt<2>("h0"), _csignals_T_81) @[Lookup.scala 34:39]
    node _csignals_T_83 = mux(_csignals_T_9, UInt<2>("h0"), _csignals_T_82) @[Lookup.scala 34:39]
    node _csignals_T_84 = mux(_csignals_T_7, UInt<2>("h0"), _csignals_T_83) @[Lookup.scala 34:39]
    node _csignals_T_85 = mux(_csignals_T_5, UInt<2>("h1"), _csignals_T_84) @[Lookup.scala 34:39]
    node _csignals_T_86 = mux(_csignals_T_3, UInt<2>("h1"), _csignals_T_85) @[Lookup.scala 34:39]
    node csignals_2 = mux(_csignals_T_1, UInt<2>("h1"), _csignals_T_86) @[Lookup.scala 34:39]
    node _csignals_T_87 = mux(_csignals_T_35, UInt<2>("h1"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_88 = mux(_csignals_T_33, UInt<2>("h1"), _csignals_T_87) @[Lookup.scala 34:39]
    node _csignals_T_89 = mux(_csignals_T_31, UInt<2>("h1"), _csignals_T_88) @[Lookup.scala 34:39]
    node _csignals_T_90 = mux(_csignals_T_29, UInt<2>("h1"), _csignals_T_89) @[Lookup.scala 34:39]
    node _csignals_T_91 = mux(_csignals_T_27, UInt<2>("h1"), _csignals_T_90) @[Lookup.scala 34:39]
    node _csignals_T_92 = mux(_csignals_T_25, UInt<2>("h2"), _csignals_T_91) @[Lookup.scala 34:39]
    node _csignals_T_93 = mux(_csignals_T_23, UInt<2>("h0"), _csignals_T_92) @[Lookup.scala 34:39]
    node _csignals_T_94 = mux(_csignals_T_21, UInt<2>("h0"), _csignals_T_93) @[Lookup.scala 34:39]
    node _csignals_T_95 = mux(_csignals_T_19, UInt<2>("h1"), _csignals_T_94) @[Lookup.scala 34:39]
    node _csignals_T_96 = mux(_csignals_T_17, UInt<2>("h1"), _csignals_T_95) @[Lookup.scala 34:39]
    node _csignals_T_97 = mux(_csignals_T_15, UInt<2>("h1"), _csignals_T_96) @[Lookup.scala 34:39]
    node _csignals_T_98 = mux(_csignals_T_13, UInt<2>("h1"), _csignals_T_97) @[Lookup.scala 34:39]
    node _csignals_T_99 = mux(_csignals_T_11, UInt<2>("h1"), _csignals_T_98) @[Lookup.scala 34:39]
    node _csignals_T_100 = mux(_csignals_T_9, UInt<2>("h1"), _csignals_T_99) @[Lookup.scala 34:39]
    node _csignals_T_101 = mux(_csignals_T_7, UInt<2>("h1"), _csignals_T_100) @[Lookup.scala 34:39]
    node _csignals_T_102 = mux(_csignals_T_5, UInt<2>("h1"), _csignals_T_101) @[Lookup.scala 34:39]
    node _csignals_T_103 = mux(_csignals_T_3, UInt<2>("h1"), _csignals_T_102) @[Lookup.scala 34:39]
    node csignals_3 = mux(_csignals_T_1, UInt<2>("h1"), _csignals_T_103) @[Lookup.scala 34:39]
    node _csignals_T_104 = mux(_csignals_T_35, UInt<2>("h1"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_105 = mux(_csignals_T_33, UInt<2>("h2"), _csignals_T_104) @[Lookup.scala 34:39]
    node _csignals_T_106 = mux(_csignals_T_31, UInt<2>("h1"), _csignals_T_105) @[Lookup.scala 34:39]
    node _csignals_T_107 = mux(_csignals_T_29, UInt<2>("h1"), _csignals_T_106) @[Lookup.scala 34:39]
    node _csignals_T_108 = mux(_csignals_T_27, UInt<2>("h1"), _csignals_T_107) @[Lookup.scala 34:39]
    node _csignals_T_109 = mux(_csignals_T_25, UInt<2>("h3"), _csignals_T_108) @[Lookup.scala 34:39]
    node _csignals_T_110 = mux(_csignals_T_23, UInt<2>("h0"), _csignals_T_109) @[Lookup.scala 34:39]
    node _csignals_T_111 = mux(_csignals_T_21, UInt<2>("h2"), _csignals_T_110) @[Lookup.scala 34:39]
    node _csignals_T_112 = mux(_csignals_T_19, UInt<2>("h2"), _csignals_T_111) @[Lookup.scala 34:39]
    node _csignals_T_113 = mux(_csignals_T_17, UInt<2>("h2"), _csignals_T_112) @[Lookup.scala 34:39]
    node _csignals_T_114 = mux(_csignals_T_15, UInt<2>("h2"), _csignals_T_113) @[Lookup.scala 34:39]
    node _csignals_T_115 = mux(_csignals_T_13, UInt<2>("h2"), _csignals_T_114) @[Lookup.scala 34:39]
    node _csignals_T_116 = mux(_csignals_T_11, UInt<2>("h2"), _csignals_T_115) @[Lookup.scala 34:39]
    node _csignals_T_117 = mux(_csignals_T_9, UInt<2>("h2"), _csignals_T_116) @[Lookup.scala 34:39]
    node _csignals_T_118 = mux(_csignals_T_7, UInt<2>("h2"), _csignals_T_117) @[Lookup.scala 34:39]
    node _csignals_T_119 = mux(_csignals_T_5, UInt<2>("h1"), _csignals_T_118) @[Lookup.scala 34:39]
    node _csignals_T_120 = mux(_csignals_T_3, UInt<2>("h1"), _csignals_T_119) @[Lookup.scala 34:39]
    node csignals_4 = mux(_csignals_T_1, UInt<2>("h1"), _csignals_T_120) @[Lookup.scala 34:39]
    node _csignals_T_121 = mux(_csignals_T_35, UInt<2>("h2"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_122 = mux(_csignals_T_33, UInt<2>("h2"), _csignals_T_121) @[Lookup.scala 34:39]
    node _csignals_T_123 = mux(_csignals_T_31, UInt<2>("h0"), _csignals_T_122) @[Lookup.scala 34:39]
    node _csignals_T_124 = mux(_csignals_T_29, UInt<2>("h0"), _csignals_T_123) @[Lookup.scala 34:39]
    node _csignals_T_125 = mux(_csignals_T_27, UInt<2>("h0"), _csignals_T_124) @[Lookup.scala 34:39]
    node _csignals_T_126 = mux(_csignals_T_25, UInt<2>("h2"), _csignals_T_125) @[Lookup.scala 34:39]
    node _csignals_T_127 = mux(_csignals_T_23, UInt<2>("h1"), _csignals_T_126) @[Lookup.scala 34:39]
    node _csignals_T_128 = mux(_csignals_T_21, UInt<2>("h2"), _csignals_T_127) @[Lookup.scala 34:39]
    node _csignals_T_129 = mux(_csignals_T_19, UInt<2>("h0"), _csignals_T_128) @[Lookup.scala 34:39]
    node _csignals_T_130 = mux(_csignals_T_17, UInt<2>("h0"), _csignals_T_129) @[Lookup.scala 34:39]
    node _csignals_T_131 = mux(_csignals_T_15, UInt<2>("h0"), _csignals_T_130) @[Lookup.scala 34:39]
    node _csignals_T_132 = mux(_csignals_T_13, UInt<2>("h2"), _csignals_T_131) @[Lookup.scala 34:39]
    node _csignals_T_133 = mux(_csignals_T_11, UInt<2>("h2"), _csignals_T_132) @[Lookup.scala 34:39]
    node _csignals_T_134 = mux(_csignals_T_9, UInt<2>("h2"), _csignals_T_133) @[Lookup.scala 34:39]
    node _csignals_T_135 = mux(_csignals_T_7, UInt<2>("h2"), _csignals_T_134) @[Lookup.scala 34:39]
    node _csignals_T_136 = mux(_csignals_T_5, UInt<2>("h2"), _csignals_T_135) @[Lookup.scala 34:39]
    node _csignals_T_137 = mux(_csignals_T_3, UInt<2>("h2"), _csignals_T_136) @[Lookup.scala 34:39]
    node csignals_5 = mux(_csignals_T_1, UInt<2>("h2"), _csignals_T_137) @[Lookup.scala 34:39]
    node _csignals_T_138 = mux(_csignals_T_35, UInt<2>("h0"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_139 = mux(_csignals_T_33, UInt<2>("h0"), _csignals_T_138) @[Lookup.scala 34:39]
    node _csignals_T_140 = mux(_csignals_T_31, UInt<2>("h0"), _csignals_T_139) @[Lookup.scala 34:39]
    node _csignals_T_141 = mux(_csignals_T_29, UInt<2>("h0"), _csignals_T_140) @[Lookup.scala 34:39]
    node _csignals_T_142 = mux(_csignals_T_27, UInt<2>("h0"), _csignals_T_141) @[Lookup.scala 34:39]
    node _csignals_T_143 = mux(_csignals_T_25, UInt<2>("h0"), _csignals_T_142) @[Lookup.scala 34:39]
    node _csignals_T_144 = mux(_csignals_T_23, UInt<2>("h0"), _csignals_T_143) @[Lookup.scala 34:39]
    node _csignals_T_145 = mux(_csignals_T_21, UInt<2>("h0"), _csignals_T_144) @[Lookup.scala 34:39]
    node _csignals_T_146 = mux(_csignals_T_19, UInt<2>("h0"), _csignals_T_145) @[Lookup.scala 34:39]
    node _csignals_T_147 = mux(_csignals_T_17, UInt<2>("h0"), _csignals_T_146) @[Lookup.scala 34:39]
    node _csignals_T_148 = mux(_csignals_T_15, UInt<2>("h0"), _csignals_T_147) @[Lookup.scala 34:39]
    node _csignals_T_149 = mux(_csignals_T_13, UInt<2>("h3"), _csignals_T_148) @[Lookup.scala 34:39]
    node _csignals_T_150 = mux(_csignals_T_11, UInt<2>("h2"), _csignals_T_149) @[Lookup.scala 34:39]
    node _csignals_T_151 = mux(_csignals_T_9, UInt<2>("h1"), _csignals_T_150) @[Lookup.scala 34:39]
    node _csignals_T_152 = mux(_csignals_T_7, UInt<2>("h0"), _csignals_T_151) @[Lookup.scala 34:39]
    node _csignals_T_153 = mux(_csignals_T_5, UInt<2>("h0"), _csignals_T_152) @[Lookup.scala 34:39]
    node _csignals_T_154 = mux(_csignals_T_3, UInt<2>("h0"), _csignals_T_153) @[Lookup.scala 34:39]
    node csignals_6 = mux(_csignals_T_1, UInt<2>("h0"), _csignals_T_154) @[Lookup.scala 34:39]
    node _csignals_T_155 = mux(_csignals_T_35, UInt<2>("h0"), UInt<2>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_156 = mux(_csignals_T_33, UInt<2>("h0"), _csignals_T_155) @[Lookup.scala 34:39]
    node _csignals_T_157 = mux(_csignals_T_31, UInt<2>("h0"), _csignals_T_156) @[Lookup.scala 34:39]
    node _csignals_T_158 = mux(_csignals_T_29, UInt<2>("h0"), _csignals_T_157) @[Lookup.scala 34:39]
    node _csignals_T_159 = mux(_csignals_T_27, UInt<2>("h0"), _csignals_T_158) @[Lookup.scala 34:39]
    node _csignals_T_160 = mux(_csignals_T_25, UInt<2>("h0"), _csignals_T_159) @[Lookup.scala 34:39]
    node _csignals_T_161 = mux(_csignals_T_23, UInt<2>("h0"), _csignals_T_160) @[Lookup.scala 34:39]
    node _csignals_T_162 = mux(_csignals_T_21, UInt<2>("h0"), _csignals_T_161) @[Lookup.scala 34:39]
    node _csignals_T_163 = mux(_csignals_T_19, UInt<2>("h3"), _csignals_T_162) @[Lookup.scala 34:39]
    node _csignals_T_164 = mux(_csignals_T_17, UInt<2>("h2"), _csignals_T_163) @[Lookup.scala 34:39]
    node _csignals_T_165 = mux(_csignals_T_15, UInt<2>("h1"), _csignals_T_164) @[Lookup.scala 34:39]
    node _csignals_T_166 = mux(_csignals_T_13, UInt<2>("h0"), _csignals_T_165) @[Lookup.scala 34:39]
    node _csignals_T_167 = mux(_csignals_T_11, UInt<2>("h0"), _csignals_T_166) @[Lookup.scala 34:39]
    node _csignals_T_168 = mux(_csignals_T_9, UInt<2>("h0"), _csignals_T_167) @[Lookup.scala 34:39]
    node _csignals_T_169 = mux(_csignals_T_7, UInt<2>("h0"), _csignals_T_168) @[Lookup.scala 34:39]
    node _csignals_T_170 = mux(_csignals_T_5, UInt<2>("h0"), _csignals_T_169) @[Lookup.scala 34:39]
    node _csignals_T_171 = mux(_csignals_T_3, UInt<2>("h0"), _csignals_T_170) @[Lookup.scala 34:39]
    node csignals_7 = mux(_csignals_T_1, UInt<2>("h0"), _csignals_T_171) @[Lookup.scala 34:39]
    node _csignals_T_172 = mux(_csignals_T_35, UInt<3>("h0"), UInt<3>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_173 = mux(_csignals_T_33, UInt<3>("h1"), _csignals_T_172) @[Lookup.scala 34:39]
    node _csignals_T_174 = mux(_csignals_T_31, UInt<3>("h3"), _csignals_T_173) @[Lookup.scala 34:39]
    node _csignals_T_175 = mux(_csignals_T_29, UInt<3>("h3"), _csignals_T_174) @[Lookup.scala 34:39]
    node _csignals_T_176 = mux(_csignals_T_27, UInt<3>("h3"), _csignals_T_175) @[Lookup.scala 34:39]
    node _csignals_T_177 = mux(_csignals_T_25, UInt<3>("h3"), _csignals_T_176) @[Lookup.scala 34:39]
    node _csignals_T_178 = mux(_csignals_T_23, UInt<3>("h4"), _csignals_T_177) @[Lookup.scala 34:39]
    node _csignals_T_179 = mux(_csignals_T_21, UInt<3>("h2"), _csignals_T_178) @[Lookup.scala 34:39]
    node _csignals_T_180 = mux(_csignals_T_19, UInt<3>("h1"), _csignals_T_179) @[Lookup.scala 34:39]
    node _csignals_T_181 = mux(_csignals_T_17, UInt<3>("h1"), _csignals_T_180) @[Lookup.scala 34:39]
    node _csignals_T_182 = mux(_csignals_T_15, UInt<3>("h1"), _csignals_T_181) @[Lookup.scala 34:39]
    node _csignals_T_183 = mux(_csignals_T_13, UInt<3>("h1"), _csignals_T_182) @[Lookup.scala 34:39]
    node _csignals_T_184 = mux(_csignals_T_11, UInt<3>("h1"), _csignals_T_183) @[Lookup.scala 34:39]
    node _csignals_T_185 = mux(_csignals_T_9, UInt<3>("h1"), _csignals_T_184) @[Lookup.scala 34:39]
    node _csignals_T_186 = mux(_csignals_T_7, UInt<3>("h1"), _csignals_T_185) @[Lookup.scala 34:39]
    node _csignals_T_187 = mux(_csignals_T_5, UInt<3>("h0"), _csignals_T_186) @[Lookup.scala 34:39]
    node _csignals_T_188 = mux(_csignals_T_3, UInt<3>("h0"), _csignals_T_187) @[Lookup.scala 34:39]
    node csignals_8 = mux(_csignals_T_1, UInt<3>("h0"), _csignals_T_188) @[Lookup.scala 34:39]
    node _csignals_T_189 = mux(_csignals_T_35, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_190 = mux(_csignals_T_33, UInt<1>("h0"), _csignals_T_189) @[Lookup.scala 34:39]
    node _csignals_T_191 = mux(_csignals_T_31, UInt<1>("h0"), _csignals_T_190) @[Lookup.scala 34:39]
    node _csignals_T_192 = mux(_csignals_T_29, UInt<1>("h0"), _csignals_T_191) @[Lookup.scala 34:39]
    node _csignals_T_193 = mux(_csignals_T_27, UInt<1>("h0"), _csignals_T_192) @[Lookup.scala 34:39]
    node _csignals_T_194 = mux(_csignals_T_25, UInt<1>("h0"), _csignals_T_193) @[Lookup.scala 34:39]
    node _csignals_T_195 = mux(_csignals_T_23, UInt<1>("h0"), _csignals_T_194) @[Lookup.scala 34:39]
    node _csignals_T_196 = mux(_csignals_T_21, UInt<1>("h0"), _csignals_T_195) @[Lookup.scala 34:39]
    node _csignals_T_197 = mux(_csignals_T_19, UInt<1>("h1"), _csignals_T_196) @[Lookup.scala 34:39]
    node _csignals_T_198 = mux(_csignals_T_17, UInt<1>("h1"), _csignals_T_197) @[Lookup.scala 34:39]
    node _csignals_T_199 = mux(_csignals_T_15, UInt<1>("h1"), _csignals_T_198) @[Lookup.scala 34:39]
    node _csignals_T_200 = mux(_csignals_T_13, UInt<1>("h0"), _csignals_T_199) @[Lookup.scala 34:39]
    node _csignals_T_201 = mux(_csignals_T_11, UInt<1>("h0"), _csignals_T_200) @[Lookup.scala 34:39]
    node _csignals_T_202 = mux(_csignals_T_9, UInt<1>("h0"), _csignals_T_201) @[Lookup.scala 34:39]
    node _csignals_T_203 = mux(_csignals_T_7, UInt<1>("h0"), _csignals_T_202) @[Lookup.scala 34:39]
    node _csignals_T_204 = mux(_csignals_T_5, UInt<1>("h0"), _csignals_T_203) @[Lookup.scala 34:39]
    node _csignals_T_205 = mux(_csignals_T_3, UInt<1>("h0"), _csignals_T_204) @[Lookup.scala 34:39]
    node csignals_9 = mux(_csignals_T_1, UInt<1>("h0"), _csignals_T_205) @[Lookup.scala 34:39]
    node _csignals_T_206 = mux(_csignals_T_35, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_207 = mux(_csignals_T_33, UInt<1>("h1"), _csignals_T_206) @[Lookup.scala 34:39]
    node _csignals_T_208 = mux(_csignals_T_31, UInt<1>("h0"), _csignals_T_207) @[Lookup.scala 34:39]
    node _csignals_T_209 = mux(_csignals_T_29, UInt<1>("h0"), _csignals_T_208) @[Lookup.scala 34:39]
    node _csignals_T_210 = mux(_csignals_T_27, UInt<1>("h0"), _csignals_T_209) @[Lookup.scala 34:39]
    node _csignals_T_211 = mux(_csignals_T_25, UInt<1>("h1"), _csignals_T_210) @[Lookup.scala 34:39]
    node _csignals_T_212 = mux(_csignals_T_23, UInt<1>("h1"), _csignals_T_211) @[Lookup.scala 34:39]
    node _csignals_T_213 = mux(_csignals_T_21, UInt<1>("h1"), _csignals_T_212) @[Lookup.scala 34:39]
    node _csignals_T_214 = mux(_csignals_T_19, UInt<1>("h0"), _csignals_T_213) @[Lookup.scala 34:39]
    node _csignals_T_215 = mux(_csignals_T_17, UInt<1>("h0"), _csignals_T_214) @[Lookup.scala 34:39]
    node _csignals_T_216 = mux(_csignals_T_15, UInt<1>("h0"), _csignals_T_215) @[Lookup.scala 34:39]
    node _csignals_T_217 = mux(_csignals_T_13, UInt<1>("h1"), _csignals_T_216) @[Lookup.scala 34:39]
    node _csignals_T_218 = mux(_csignals_T_11, UInt<1>("h1"), _csignals_T_217) @[Lookup.scala 34:39]
    node _csignals_T_219 = mux(_csignals_T_9, UInt<1>("h1"), _csignals_T_218) @[Lookup.scala 34:39]
    node _csignals_T_220 = mux(_csignals_T_7, UInt<1>("h1"), _csignals_T_219) @[Lookup.scala 34:39]
    node _csignals_T_221 = mux(_csignals_T_5, UInt<1>("h1"), _csignals_T_220) @[Lookup.scala 34:39]
    node _csignals_T_222 = mux(_csignals_T_3, UInt<1>("h1"), _csignals_T_221) @[Lookup.scala 34:39]
    node csignals_10 = mux(_csignals_T_1, UInt<1>("h1"), _csignals_T_222) @[Lookup.scala 34:39]
    node _csignals_T_223 = mux(_csignals_T_35, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_224 = mux(_csignals_T_33, UInt<1>("h0"), _csignals_T_223) @[Lookup.scala 34:39]
    node _csignals_T_225 = mux(_csignals_T_31, UInt<1>("h0"), _csignals_T_224) @[Lookup.scala 34:39]
    node _csignals_T_226 = mux(_csignals_T_29, UInt<1>("h0"), _csignals_T_225) @[Lookup.scala 34:39]
    node _csignals_T_227 = mux(_csignals_T_27, UInt<1>("h0"), _csignals_T_226) @[Lookup.scala 34:39]
    node _csignals_T_228 = mux(_csignals_T_25, UInt<1>("h0"), _csignals_T_227) @[Lookup.scala 34:39]
    node _csignals_T_229 = mux(_csignals_T_23, UInt<1>("h0"), _csignals_T_228) @[Lookup.scala 34:39]
    node _csignals_T_230 = mux(_csignals_T_21, UInt<1>("h0"), _csignals_T_229) @[Lookup.scala 34:39]
    node _csignals_T_231 = mux(_csignals_T_19, UInt<1>("h0"), _csignals_T_230) @[Lookup.scala 34:39]
    node _csignals_T_232 = mux(_csignals_T_17, UInt<1>("h0"), _csignals_T_231) @[Lookup.scala 34:39]
    node _csignals_T_233 = mux(_csignals_T_15, UInt<1>("h0"), _csignals_T_232) @[Lookup.scala 34:39]
    node _csignals_T_234 = mux(_csignals_T_13, UInt<1>("h1"), _csignals_T_233) @[Lookup.scala 34:39]
    node _csignals_T_235 = mux(_csignals_T_11, UInt<1>("h1"), _csignals_T_234) @[Lookup.scala 34:39]
    node _csignals_T_236 = mux(_csignals_T_9, UInt<1>("h1"), _csignals_T_235) @[Lookup.scala 34:39]
    node _csignals_T_237 = mux(_csignals_T_7, UInt<1>("h0"), _csignals_T_236) @[Lookup.scala 34:39]
    node _csignals_T_238 = mux(_csignals_T_5, UInt<1>("h0"), _csignals_T_237) @[Lookup.scala 34:39]
    node _csignals_T_239 = mux(_csignals_T_3, UInt<1>("h0"), _csignals_T_238) @[Lookup.scala 34:39]
    node csignals_11 = mux(_csignals_T_1, UInt<1>("h0"), _csignals_T_239) @[Lookup.scala 34:39]
    node _csignals_T_240 = mux(_csignals_T_35, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 34:39]
    node _csignals_T_241 = mux(_csignals_T_33, UInt<1>("h0"), _csignals_T_240) @[Lookup.scala 34:39]
    node _csignals_T_242 = mux(_csignals_T_31, UInt<1>("h0"), _csignals_T_241) @[Lookup.scala 34:39]
    node _csignals_T_243 = mux(_csignals_T_29, UInt<1>("h0"), _csignals_T_242) @[Lookup.scala 34:39]
    node _csignals_T_244 = mux(_csignals_T_27, UInt<1>("h0"), _csignals_T_243) @[Lookup.scala 34:39]
    node _csignals_T_245 = mux(_csignals_T_25, UInt<1>("h0"), _csignals_T_244) @[Lookup.scala 34:39]
    node _csignals_T_246 = mux(_csignals_T_23, UInt<1>("h0"), _csignals_T_245) @[Lookup.scala 34:39]
    node _csignals_T_247 = mux(_csignals_T_21, UInt<1>("h0"), _csignals_T_246) @[Lookup.scala 34:39]
    node _csignals_T_248 = mux(_csignals_T_19, UInt<1>("h0"), _csignals_T_247) @[Lookup.scala 34:39]
    node _csignals_T_249 = mux(_csignals_T_17, UInt<1>("h0"), _csignals_T_248) @[Lookup.scala 34:39]
    node _csignals_T_250 = mux(_csignals_T_15, UInt<1>("h0"), _csignals_T_249) @[Lookup.scala 34:39]
    node _csignals_T_251 = mux(_csignals_T_13, UInt<1>("h1"), _csignals_T_250) @[Lookup.scala 34:39]
    node _csignals_T_252 = mux(_csignals_T_11, UInt<1>("h1"), _csignals_T_251) @[Lookup.scala 34:39]
    node _csignals_T_253 = mux(_csignals_T_9, UInt<1>("h1"), _csignals_T_252) @[Lookup.scala 34:39]
    node _csignals_T_254 = mux(_csignals_T_7, UInt<1>("h0"), _csignals_T_253) @[Lookup.scala 34:39]
    node _csignals_T_255 = mux(_csignals_T_5, UInt<1>("h0"), _csignals_T_254) @[Lookup.scala 34:39]
    node _csignals_T_256 = mux(_csignals_T_3, UInt<1>("h0"), _csignals_T_255) @[Lookup.scala 34:39]
    node csignals_12 = mux(_csignals_T_1, UInt<1>("h0"), _csignals_T_256) @[Lookup.scala 34:39]
    node _raddr_1_T = eq(csignals_1, UInt<1>("h1")) @[ID.scala 86:19]
    node raddr_1 = mux(_raddr_1_T, rj_addr, UInt<5>("h0")) @[Mux.scala 101:16]
    node _raddr_2_T = eq(csignals_2, UInt<2>("h1")) @[ID.scala 89:19]
    node _raddr_2_T_1 = eq(csignals_2, UInt<2>("h2")) @[ID.scala 90:19]
    node _raddr_2_T_2 = eq(csignals_2, UInt<2>("h3")) @[ID.scala 91:19]
    node _raddr_2_T_3 = mux(_raddr_2_T_2, ui5_addr, UInt<5>("h0")) @[Mux.scala 101:16]
    node _raddr_2_T_4 = mux(_raddr_2_T_1, rd_addr, _raddr_2_T_3) @[Mux.scala 101:16]
    node raddr_2 = mux(_raddr_2_T, rk_addr, _raddr_2_T_4) @[Mux.scala 101:16]
    node _stall_case1_T = neq(raddr_1, UInt<1>("h0")) @[ID.scala 94:32]
    node _stall_case1_T_1 = eq(raddr_1, io_wRegAddr_EXE) @[ID.scala 94:53]
    node _stall_case1_T_2 = and(_stall_case1_T, _stall_case1_T_1) @[ID.scala 94:41]
    node stall_case1 = and(_stall_case1_T_2, io_wRegDataSrc_ctrl_uMEM_EXE) @[ID.scala 94:74]
    node _stall_case2_T = neq(raddr_2, UInt<1>("h0")) @[ID.scala 95:32]
    node _stall_case2_T_1 = eq(raddr_2, io_wRegAddr_EXE) @[ID.scala 95:53]
    node _stall_case2_T_2 = and(_stall_case2_T, _stall_case2_T_1) @[ID.scala 95:41]
    node stall_case2 = and(_stall_case2_T_2, io_wRegDataSrc_ctrl_uMEM_EXE) @[ID.scala 95:74]
    node stallReg = or(stall_case1, stall_case2) @[ID.scala 98:33]
    node _wb_addr_T = eq(csignals_5, UInt<2>("h1")) @[ID.scala 101:15]
    node _wb_addr_T_1 = eq(csignals_5, UInt<2>("h2")) @[ID.scala 102:15]
    node _wb_addr_T_2 = mux(_wb_addr_T_1, rd_addr, UInt<5>("h0")) @[Mux.scala 101:16]
    node wb_addr = mux(_wb_addr_T, UInt<5>("h1"), _wb_addr_T_2) @[Mux.scala 101:16]
    node _data1_T = eq(raddr_1, io_wRegAddr_MEM) @[ID.scala 106:19]
    node _data1_T_1 = eq(io_wRegDataSrc_ctrl_uMEM_EXE, UInt<1>("h1")) @[ID.scala 106:73]
    node _data1_T_2 = and(_data1_T, _data1_T_1) @[ID.scala 106:40]
    node _data1_T_3 = eq(raddr_1, io_wRegAddr_EXE) @[ID.scala 107:19]
    node _data1_T_4 = eq(io_wRegDataSrc_ctrl_uMEM_EXE, UInt<1>("h0")) @[ID.scala 107:73]
    node _data1_T_5 = and(_data1_T_3, _data1_T_4) @[ID.scala 107:40]
    node _data1_T_6 = eq(raddr_1, io_wRegaddr_WB) @[ID.scala 108:19]
    node _data1_T_7 = eq(io_wReg_ctrl_WB, UInt<1>("h1")) @[ID.scala 108:60]
    node _data1_T_8 = and(_data1_T_6, _data1_T_7) @[ID.scala 108:40]
    node _data1_T_9 = mux(_data1_T_8, io_wRegData_WB, regfile.data1_MPORT.data) @[Mux.scala 101:16]
    node _data1_T_10 = mux(_data1_T_5, io_aluResult_EXE, _data1_T_9) @[Mux.scala 101:16]
    node data1 = mux(_data1_T_2, io_wRegData_MEM, _data1_T_10) @[Mux.scala 101:16]
    node _data2_T = eq(raddr_2, io_wRegAddr_MEM) @[ID.scala 113:19]
    node _data2_T_1 = eq(io_wRegDataSrc_ctrl_uMEM_EXE, UInt<1>("h1")) @[ID.scala 113:73]
    node _data2_T_2 = and(_data2_T, _data2_T_1) @[ID.scala 113:40]
    node _data2_T_3 = eq(raddr_2, io_wRegAddr_EXE) @[ID.scala 114:19]
    node _data2_T_4 = eq(io_wRegDataSrc_ctrl_uMEM_EXE, UInt<1>("h0")) @[ID.scala 114:73]
    node _data2_T_5 = and(_data2_T_3, _data2_T_4) @[ID.scala 114:40]
    node _data2_T_6 = eq(raddr_2, io_wRegaddr_WB) @[ID.scala 115:19]
    node _data2_T_7 = eq(io_wReg_ctrl_WB, UInt<1>("h1")) @[ID.scala 115:60]
    node _data2_T_8 = and(_data2_T_6, _data2_T_7) @[ID.scala 115:40]
    node _data2_T_9 = mux(_data2_T_8, io_wRegData_WB, regfile.data2_MPORT.data) @[Mux.scala 101:16]
    node _data2_T_10 = mux(_data2_T_5, io_aluResult_EXE, _data2_T_9) @[Mux.scala 101:16]
    node data2 = mux(_data2_T_2, io_wRegData_MEM, _data2_T_10) @[Mux.scala 101:16]
    node _op1_data_T = eq(csignals_3, UInt<2>("h1")) @[ID.scala 119:18]
    node _op1_data_T_1 = eq(csignals_3, UInt<2>("h2")) @[ID.scala 120:18]
    node _op1_data_T_2 = mux(_op1_data_T_1, io_PC_ID, UInt<32>("h0")) @[Mux.scala 101:16]
    node op1_data = mux(_op1_data_T, data1, _op1_data_T_2) @[Mux.scala 101:16]
    node _imm_data_T = eq(csignals_8, UInt<3>("h1")) @[ID.scala 124:14]
    node _imm_data_T_1 = eq(csignals_8, UInt<3>("h2")) @[ID.scala 125:14]
    node _imm_data_T_2 = eq(csignals_8, UInt<3>("h3")) @[ID.scala 126:14]
    node _imm_data_T_3 = eq(csignals_8, UInt<3>("h4")) @[ID.scala 127:14]
    node _imm_data_T_4 = mux(_imm_data_T_3, ext_o26, UInt<32>("h0")) @[Mux.scala 101:16]
    node _imm_data_T_5 = mux(_imm_data_T_2, ext_o16, _imm_data_T_4) @[Mux.scala 101:16]
    node _imm_data_T_6 = mux(_imm_data_T_1, ext_si20, _imm_data_T_5) @[Mux.scala 101:16]
    node imm_data = mux(_imm_data_T, ext_si12, _imm_data_T_6) @[Mux.scala 101:16]
    node _op2_data_T = eq(csignals_4, UInt<2>("h1")) @[ID.scala 131:18]
    node _op2_data_T_1 = eq(csignals_4, UInt<2>("h2")) @[ID.scala 132:18]
    node _op2_data_T_2 = eq(csignals_4, UInt<2>("h3")) @[ID.scala 133:18]
    node _op2_data_T_3 = mux(_op2_data_T_2, UInt<32>("h4"), UInt<32>("h0")) @[Mux.scala 101:16]
    node _op2_data_T_4 = mux(_op2_data_T_1, imm_data, _op2_data_T_3) @[Mux.scala 101:16]
    node op2_data = mux(_op2_data_T, data2, _op2_data_T_4) @[Mux.scala 101:16]
    node _wMemData_T = eq(csignals_7, UInt<2>("h1")) @[ID.scala 137:21]
    node _wMemData_T_1 = and(regfile.wMemData_MPORT_1.data, UInt<8>("hff")) @[ID.scala 137:56]
    node _wMemData_T_2 = eq(csignals_7, UInt<2>("h2")) @[ID.scala 138:21]
    node _wMemData_T_3 = and(regfile.wMemData_MPORT_2.data, UInt<16>("hffff")) @[ID.scala 138:56]
    node _wMemData_T_4 = mux(_wMemData_T_2, _wMemData_T_3, regfile.wMemData_MPORT.data) @[Mux.scala 101:16]
    node wMemData = mux(_wMemData_T, _wMemData_T_1, _wMemData_T_4) @[Mux.scala 101:16]
    node _branchFlag_T = and(io_instr_ID, UInt<32>("hfc000000")) @[ID.scala 145:22]
    node _branchFlag_T_1 = eq(UInt<31>("h58000000"), _branchFlag_T) @[ID.scala 145:22]
    node _branchFlag_T_2 = eq(op1_data, op2_data) @[ID.scala 145:46]
    node _branchFlag_T_3 = and(io_instr_ID, UInt<32>("hfc000000")) @[ID.scala 146:22]
    node _branchFlag_T_4 = eq(UInt<31>("h64000000"), _branchFlag_T_3) @[ID.scala 146:22]
    node _branchFlag_T_5 = asSInt(op1_data) @[ID.scala 146:52]
    node _branchFlag_T_6 = asSInt(op2_data) @[ID.scala 146:74]
    node _branchFlag_T_7 = eq(_branchFlag_T_5, _branchFlag_T_6) @[ID.scala 146:55]
    node _branchFlag_T_8 = and(io_instr_ID, UInt<32>("hfc000000")) @[ID.scala 147:22]
    node _branchFlag_T_9 = eq(UInt<31>("h68000000"), _branchFlag_T_8) @[ID.scala 147:22]
    node _branchFlag_T_10 = lt(op1_data, op2_data) @[ID.scala 147:46]
    node _branchFlag_T_11 = and(io_instr_ID, UInt<32>("hfc000000")) @[ID.scala 148:22]
    node _branchFlag_T_12 = eq(UInt<31>("h54000000"), _branchFlag_T_11) @[ID.scala 148:22]
    node _branchFlag_T_13 = and(io_instr_ID, UInt<32>("hfc000000")) @[ID.scala 149:22]
    node _branchFlag_T_14 = eq(UInt<31>("h4c000000"), _branchFlag_T_13) @[ID.scala 149:22]
    node _branchFlag_T_15 = mux(_branchFlag_T_14, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _branchFlag_T_16 = mux(_branchFlag_T_12, UInt<1>("h1"), _branchFlag_T_15) @[Mux.scala 101:16]
    node _branchFlag_T_17 = mux(_branchFlag_T_9, _branchFlag_T_10, _branchFlag_T_16) @[Mux.scala 101:16]
    node _branchFlag_T_18 = mux(_branchFlag_T_4, _branchFlag_T_7, _branchFlag_T_17) @[Mux.scala 101:16]
    node branchFlag = mux(_branchFlag_T_1, _branchFlag_T_2, _branchFlag_T_18) @[Mux.scala 101:16]
    node _branchTarge_T = and(io_instr_ID, UInt<32>("hfc000000")) @[ID.scala 156:22]
    node _branchTarge_T_1 = eq(UInt<31>("h4c000000"), _branchTarge_T) @[ID.scala 156:22]
    node _branchTarge_T_2 = mux(_branchTarge_T_1, data1, io_PC_ID) @[Mux.scala 101:16]
    node _branchTarge_T_3 = add(_branchTarge_T_2, imm_data) @[ID.scala 157:8]
    node branchTarge = tail(_branchTarge_T_3, 1) @[ID.scala 157:8]
    io_data1_ID <= op1_data @[ID.scala 160:46]
    io_data2_ID <= bits(op2_data, 31, 0) @[ID.scala 161:46]
    io_wRegAddr_ID <= wb_addr @[ID.scala 162:46]
    io_wMemData_ID <= wMemData @[ID.scala 163:46]
    io_branchTarge_ID <= bits(branchTarge, 31, 0) @[ID.scala 164:46]
    io_branchFlag_ID <= branchFlag @[ID.scala 165:46]
    io_stallReqOfID_ID <= stallReg @[ID.scala 166:46]
    io_flushReqOfID_ID <= branchFlag @[ID.scala 167:46]
    io_weReg_ctrl_uWB_ID <= csignals_10 @[ID.scala 168:46]
    io_memReadDataExt_ctrl_uMEM_ID <= csignals_11 @[ID.scala 169:46]
    io_wrMemByteSelScr_ctrl_uMEM_ID <= csignals_6 @[ID.scala 170:46]
    io_wRegDataSrc_ctrl_uMEM_ID <= csignals_12 @[ID.scala 171:46]
    io_weMEM_ctrl_uMEM_ID <= csignals_9 @[ID.scala 172:46]
    io_aluOP_ctrl_uEXE_ID <= csignals_0 @[ID.scala 173:46]
    regfile.data1_MPORT.addr <= raddr_1 @[ID.scala 105:32]
    regfile.data1_MPORT.en <= UInt<1>("h1") @[ID.scala 105:32]
    regfile.data1_MPORT.clk <= clock @[ID.scala 105:32]
    regfile.data2_MPORT.addr <= raddr_2 @[ID.scala 112:32]
    regfile.data2_MPORT.en <= UInt<1>("h1") @[ID.scala 112:32]
    regfile.data2_MPORT.clk <= clock @[ID.scala 112:32]
    regfile.wMemData_MPORT.addr <= raddr_2 @[ID.scala 136:35]
    regfile.wMemData_MPORT.en <= UInt<1>("h1") @[ID.scala 136:35]
    regfile.wMemData_MPORT.clk <= clock @[ID.scala 136:35]
    regfile.wMemData_MPORT_1.addr <= raddr_2 @[ID.scala 137:46]
    regfile.wMemData_MPORT_1.en <= UInt<1>("h1") @[ID.scala 137:46]
    regfile.wMemData_MPORT_1.clk <= clock @[ID.scala 137:46]
    regfile.wMemData_MPORT_2.addr <= raddr_2 @[ID.scala 138:46]
    regfile.wMemData_MPORT_2.en <= UInt<1>("h1") @[ID.scala 138:46]
    regfile.wMemData_MPORT_2.clk <= clock @[ID.scala 138:46]
    regfile.MPORT.addr <= _GEN_0
    regfile.MPORT.en <= _GEN_2
    regfile.MPORT.clk <= _GEN_1
    regfile.MPORT.data <= _GEN_4
    regfile.MPORT.mask <= _GEN_3

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

  module EXE :
    input clock : Clock
    input reset : UInt<1>
    input io_aluOP_ctrl_uEXE_EXE : UInt<4>
    input io_data1_EXE : UInt<32>
    input io_data2_EXE : UInt<32>
    output io_aluResult_EXE : UInt<32>

    node _exe_alu_out_T = eq(io_aluOP_ctrl_uEXE_EXE, UInt<4>("h1")) @[EXE.scala 15:29]
    node _exe_alu_out_T_1 = add(io_data1_EXE, io_data2_EXE) @[EXE.scala 15:60]
    node _exe_alu_out_T_2 = tail(_exe_alu_out_T_1, 1) @[EXE.scala 15:60]
    node _exe_alu_out_T_3 = eq(io_aluOP_ctrl_uEXE_EXE, UInt<4>("h2")) @[EXE.scala 16:29]
    node _exe_alu_out_T_4 = bits(io_data2_EXE, 4, 0) @[EXE.scala 16:75]
    node _exe_alu_out_T_5 = dshr(io_data1_EXE, _exe_alu_out_T_4) @[EXE.scala 16:60]
    node _exe_alu_out_T_6 = eq(io_aluOP_ctrl_uEXE_EXE, UInt<4>("h3")) @[EXE.scala 17:29]
    node _exe_alu_out_T_7 = asSInt(io_data1_EXE) @[EXE.scala 17:66]
    node _exe_alu_out_T_8 = bits(io_data2_EXE, 4, 0) @[EXE.scala 17:84]
    node _exe_alu_out_T_9 = dshr(_exe_alu_out_T_7, _exe_alu_out_T_8) @[EXE.scala 17:69]
    node _exe_alu_out_T_10 = asUInt(_exe_alu_out_T_9) @[EXE.scala 17:97]
    node _exe_alu_out_T_11 = eq(io_aluOP_ctrl_uEXE_EXE, UInt<4>("h9")) @[EXE.scala 18:29]
    node _exe_alu_out_T_12 = asSInt(io_data1_EXE) @[EXE.scala 18:66]
    node _exe_alu_out_T_13 = asSInt(io_data2_EXE) @[EXE.scala 18:90]
    node _exe_alu_out_T_14 = lt(_exe_alu_out_T_12, _exe_alu_out_T_13) @[EXE.scala 18:69]
    node _exe_alu_out_T_15 = mux(_exe_alu_out_T_11, _exe_alu_out_T_14, UInt<32>("h0")) @[Mux.scala 101:16]
    node _exe_alu_out_T_16 = mux(_exe_alu_out_T_6, _exe_alu_out_T_10, _exe_alu_out_T_15) @[Mux.scala 101:16]
    node _exe_alu_out_T_17 = mux(_exe_alu_out_T_3, _exe_alu_out_T_5, _exe_alu_out_T_16) @[Mux.scala 101:16]
    node exe_alu_out = mux(_exe_alu_out_T, _exe_alu_out_T_2, _exe_alu_out_T_17) @[Mux.scala 101:16]
    io_aluResult_EXE <= exe_alu_out @[EXE.scala 20:20]

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

  module MEM :
    input clock : Clock
    input reset : UInt<1>
    input io_aluResult_MEM : UInt<32>
    input io_wMemData_MEM : UInt<32>
    input io_weMEM_ctrl_uMEM_MEM : UInt<1>
    input io_wRegDataSrc_ctrl_uMEM_MEM : UInt<1>
    input io_wrMemByteSelScr_ctrl_uMEM_MEM : UInt<2>
    input io_memReadDataExt_ctrl_uMEM_MEM : UInt<1>
    input io_reset : UInt<1>
    output io_wRegData_MEM : UInt<32>

    mem mem : @[MEM.scala 19:18]
      data-type => UInt<8>
      depth => 16384
      read-latency => 0
      write-latency => 1
      reader => rdata0
      reader => rdata1
      reader => rdata2
      reader => rdata3
      writer => MPORT
      writer => MPORT_1
      writer => MPORT_2
      writer => MPORT_3
      read-under-write => undefined
    reg readMemData : UInt<32>, clock with :
      reset => (UInt<1>("h0"), readMemData) @[MEM.scala 22:30]
    node byteAddr = bits(io_aluResult_MEM, 1, 0) @[MEM.scala 25:36]
    node addr = bits(io_aluResult_MEM, 6, 2) @[MEM.scala 26:32]
    node _wMemDAtaB_T = bits(io_wMemData_MEM, 7, 0) @[MEM.scala 33:33]
    node _wMemDAtaB_T_1 = bits(io_wMemData_MEM, 7, 0) @[MEM.scala 33:47]
    node _wMemDAtaB_T_2 = bits(io_wMemData_MEM, 7, 0) @[MEM.scala 33:61]
    node _wMemDAtaB_T_3 = bits(io_wMemData_MEM, 7, 0) @[MEM.scala 33:75]
    node wMemDAtaB_lo = cat(_wMemDAtaB_T_2, _wMemDAtaB_T_3) @[Cat.scala 31:58]
    node wMemDAtaB_hi = cat(_wMemDAtaB_T, _wMemDAtaB_T_1) @[Cat.scala 31:58]
    node wMemDAtaB = cat(wMemDAtaB_hi, wMemDAtaB_lo) @[Cat.scala 31:58]
    node _wMemDataH_T = bits(io_wMemData_MEM, 15, 0) @[MEM.scala 34:33]
    node _wMemDataH_T_1 = bits(io_wMemData_MEM, 15, 0) @[MEM.scala 34:48]
    node wMemDataH = cat(_wMemDataH_T, _wMemDataH_T_1) @[Cat.scala 31:58]
    node _wMeMData_end_T = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h1")) @[MEM.scala 37:31]
    node _wMeMData_end_T_1 = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h2")) @[MEM.scala 38:31]
    node _wMeMData_end_T_2 = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h3")) @[MEM.scala 39:31]
    node _wMeMData_end_T_3 = mux(_wMeMData_end_T_2, io_wMemData_MEM, UInt<32>("h0")) @[Mux.scala 101:16]
    node _wMeMData_end_T_4 = mux(_wMeMData_end_T_1, wMemDataH, _wMeMData_end_T_3) @[Mux.scala 101:16]
    node wMeMData_end = mux(_wMeMData_end_T, wMemDAtaB, _wMeMData_end_T_4) @[Mux.scala 101:16]
    node wdata0 = bits(wMeMData_end, 7, 0) @[MEM.scala 42:30]
    node wdata1 = bits(wMeMData_end, 15, 8) @[MEM.scala 43:30]
    node wdata2 = bits(wMeMData_end, 23, 16) @[MEM.scala 44:30]
    node wdata3 = bits(wMeMData_end, 31, 24) @[MEM.scala 45:30]
    node _typeB_T = eq(byteAddr, UInt<1>("h0")) @[MEM.scala 48:19]
    node _typeB_T_1 = eq(byteAddr, UInt<1>("h1")) @[MEM.scala 49:19]
    node _typeB_T_2 = eq(byteAddr, UInt<2>("h2")) @[MEM.scala 50:19]
    node _typeB_T_3 = eq(byteAddr, UInt<2>("h3")) @[MEM.scala 51:19]
    node _typeB_T_4 = mux(_typeB_T_3, UInt<4>("h8"), UInt<4>("h0")) @[Mux.scala 101:16]
    node _typeB_T_5 = mux(_typeB_T_2, UInt<3>("h4"), _typeB_T_4) @[Mux.scala 101:16]
    node _typeB_T_6 = mux(_typeB_T_1, UInt<2>("h2"), _typeB_T_5) @[Mux.scala 101:16]
    node typeB = mux(_typeB_T, UInt<1>("h1"), _typeB_T_6) @[Mux.scala 101:16]
    node _typeH_T = bits(byteAddr, 1, 1) @[MEM.scala 55:18]
    node _typeH_T_1 = eq(_typeH_T, UInt<1>("h0")) @[MEM.scala 55:22]
    node _typeH_T_2 = bits(byteAddr, 1, 1) @[MEM.scala 56:18]
    node _typeH_T_3 = eq(_typeH_T_2, UInt<1>("h1")) @[MEM.scala 56:22]
    node _typeH_T_4 = mux(_typeH_T_3, UInt<4>("hc"), UInt<4>("h0")) @[Mux.scala 101:16]
    node typeH = mux(_typeH_T_1, UInt<2>("h3"), _typeH_T_4) @[Mux.scala 101:16]
    node _byteSel_T = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h1")) @[MEM.scala 60:31]
    node _byteSel_T_1 = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h2")) @[MEM.scala 61:31]
    node _byteSel_T_2 = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h3")) @[MEM.scala 62:31]
    node _byteSel_T_3 = mux(_byteSel_T_2, UInt<4>("hf"), UInt<4>("h0")) @[Mux.scala 101:16]
    node _byteSel_T_4 = mux(_byteSel_T_1, typeH, _byteSel_T_3) @[Mux.scala 101:16]
    node byteSel = mux(_byteSel_T, typeB, _byteSel_T_4) @[Mux.scala 101:16]
    node _T = eq(io_weMEM_ctrl_uMEM_MEM, UInt<1>("h1")) @[MEM.scala 65:21]
    node _T_1 = bits(byteSel, 0, 0) @[MEM.scala 66:46]
    node _T_2 = bits(_T_1, 0, 0) @[Bitwise.scala 74:15]
    node _T_3 = mux(_T_2, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 74:12]
    node _T_4 = and(wdata0, _T_3) @[MEM.scala 66:29]
    node _T_5 = add(addr, UInt<32>("h1")) @[MEM.scala 67:18]
    node _T_6 = tail(_T_5, 1) @[MEM.scala 67:18]
    node _T_7 = bits(_T_6, 13, 0) @[MEM.scala 67:12]
    node _T_8 = bits(byteSel, 1, 1) @[MEM.scala 67:64]
    node _T_9 = bits(_T_8, 0, 0) @[Bitwise.scala 74:15]
    node _T_10 = mux(_T_9, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 74:12]
    node _T_11 = and(wdata1, _T_10) @[MEM.scala 67:47]
    node _T_12 = add(addr, UInt<32>("h2")) @[MEM.scala 68:18]
    node _T_13 = tail(_T_12, 1) @[MEM.scala 68:18]
    node _T_14 = bits(_T_13, 13, 0) @[MEM.scala 68:12]
    node _T_15 = bits(byteSel, 2, 2) @[MEM.scala 68:64]
    node _T_16 = bits(_T_15, 0, 0) @[Bitwise.scala 74:15]
    node _T_17 = mux(_T_16, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 74:12]
    node _T_18 = and(wdata2, _T_17) @[MEM.scala 68:47]
    node _T_19 = add(addr, UInt<32>("h3")) @[MEM.scala 69:18]
    node _T_20 = tail(_T_19, 1) @[MEM.scala 69:18]
    node _T_21 = bits(_T_20, 13, 0) @[MEM.scala 69:12]
    node _T_22 = bits(byteSel, 3, 3) @[MEM.scala 69:64]
    node _T_23 = bits(_T_22, 0, 0) @[Bitwise.scala 74:15]
    node _T_24 = mux(_T_23, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 74:12]
    node _T_25 = and(wdata3, _T_24) @[MEM.scala 69:47]
    node _T_26 = eq(io_weMEM_ctrl_uMEM_MEM, UInt<1>("h0")) @[MEM.scala 70:27]
    node _rdata1_T = add(addr, UInt<32>("h1")) @[MEM.scala 72:31]
    node _rdata1_T_1 = tail(_rdata1_T, 1) @[MEM.scala 72:31]
    node _rdata1_T_2 = bits(_rdata1_T_1, 13, 0) @[MEM.scala 72:25]
    node _rdata2_T = add(addr, UInt<32>("h2")) @[MEM.scala 73:31]
    node _rdata2_T_1 = tail(_rdata2_T, 1) @[MEM.scala 73:31]
    node _rdata2_T_2 = bits(_rdata2_T_1, 13, 0) @[MEM.scala 73:25]
    node _rdata3_T = add(addr, UInt<32>("h3")) @[MEM.scala 74:31]
    node _rdata3_T_1 = tail(_rdata3_T, 1) @[MEM.scala 74:31]
    node _rdata3_T_2 = bits(_rdata3_T_1, 13, 0) @[MEM.scala 74:25]
    node readWordData_lo = cat(mem.rdata1.data, mem.rdata0.data) @[Cat.scala 31:58]
    node readWordData_hi = cat(mem.rdata3.data, mem.rdata2.data) @[Cat.scala 31:58]
    node readWordData = cat(readWordData_hi, readWordData_lo) @[Cat.scala 31:58]
    node _DataB_T = eq(byteAddr, UInt<1>("h0")) @[MEM.scala 77:23]
    node _DataB_T_1 = eq(byteAddr, UInt<1>("h1")) @[MEM.scala 78:23]
    node _DataB_T_2 = eq(byteAddr, UInt<2>("h2")) @[MEM.scala 79:23]
    node _DataB_T_3 = eq(byteAddr, UInt<2>("h3")) @[MEM.scala 80:23]
    node _DataB_T_4 = mux(_DataB_T_3, mem.rdata3.data, UInt<8>("h0")) @[Mux.scala 101:16]
    node _DataB_T_5 = mux(_DataB_T_2, mem.rdata2.data, _DataB_T_4) @[Mux.scala 101:16]
    node _DataB_T_6 = mux(_DataB_T_1, mem.rdata1.data, _DataB_T_5) @[Mux.scala 101:16]
    node DataB = mux(_DataB_T, mem.rdata0.data, _DataB_T_6) @[Mux.scala 101:16]
    node _readByteData_T = eq(io_memReadDataExt_ctrl_uMEM_MEM, UInt<1>("h0")) @[MEM.scala 83:39]
    node _readByteData_T_1 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
    node _readByteData_T_2 = cat(_readByteData_T_1, DataB) @[Cat.scala 31:58]
    node _readByteData_T_3 = eq(io_memReadDataExt_ctrl_uMEM_MEM, UInt<1>("h1")) @[MEM.scala 84:39]
    node _readByteData_T_4 = bits(DataB, 7, 7) @[MEM.scala 84:71]
    node _readByteData_T_5 = bits(_readByteData_T_4, 0, 0) @[Bitwise.scala 74:15]
    node _readByteData_T_6 = mux(_readByteData_T_5, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
    node _readByteData_T_7 = cat(_readByteData_T_6, DataB) @[Cat.scala 31:58]
    node _readByteData_T_8 = mux(_readByteData_T_3, _readByteData_T_7, UInt<32>("h0")) @[Mux.scala 101:16]
    node readByteData = mux(_readByteData_T, _readByteData_T_2, _readByteData_T_8) @[Mux.scala 101:16]
    node _DataH_T = bits(byteAddr, 1, 1) @[MEM.scala 87:22]
    node _DataH_T_1 = eq(_DataH_T, UInt<1>("h0")) @[MEM.scala 87:26]
    node _DataH_T_2 = cat(mem.rdata1.data, mem.rdata0.data) @[Cat.scala 31:58]
    node _DataH_T_3 = bits(byteAddr, 1, 1) @[MEM.scala 88:22]
    node _DataH_T_4 = eq(_DataH_T_3, UInt<1>("h1")) @[MEM.scala 88:26]
    node _DataH_T_5 = cat(mem.rdata3.data, mem.rdata2.data) @[Cat.scala 31:58]
    node _DataH_T_6 = mux(_DataH_T_4, _DataH_T_5, UInt<16>("h0")) @[Mux.scala 101:16]
    node DataH = mux(_DataH_T_1, _DataH_T_2, _DataH_T_6) @[Mux.scala 101:16]
    node _readHalfWordData_T = eq(io_memReadDataExt_ctrl_uMEM_MEM, UInt<1>("h0")) @[MEM.scala 91:39]
    node _readHalfWordData_T_1 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _readHalfWordData_T_2 = cat(_readHalfWordData_T_1, DataH) @[Cat.scala 31:58]
    node _readHalfWordData_T_3 = eq(io_memReadDataExt_ctrl_uMEM_MEM, UInt<1>("h1")) @[MEM.scala 92:39]
    node _readHalfWordData_T_4 = bits(DataH, 15, 15) @[MEM.scala 92:71]
    node _readHalfWordData_T_5 = bits(_readHalfWordData_T_4, 0, 0) @[Bitwise.scala 74:15]
    node _readHalfWordData_T_6 = mux(_readHalfWordData_T_5, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _readHalfWordData_T_7 = cat(_readHalfWordData_T_6, DataH) @[Cat.scala 31:58]
    node _readHalfWordData_T_8 = mux(_readHalfWordData_T_3, _readHalfWordData_T_7, UInt<32>("h0")) @[Mux.scala 101:16]
    node readHalfWordData = mux(_readHalfWordData_T, _readHalfWordData_T_2, _readHalfWordData_T_8) @[Mux.scala 101:16]
    node _readMemData_T = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h1")) @[MEM.scala 95:35]
    node _readMemData_T_1 = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h2")) @[MEM.scala 96:35]
    node _readMemData_T_2 = eq(io_wrMemByteSelScr_ctrl_uMEM_MEM, UInt<2>("h3")) @[MEM.scala 97:35]
    node _readMemData_T_3 = mux(_readMemData_T_2, readWordData, UInt<32>("h0")) @[Mux.scala 101:16]
    node _readMemData_T_4 = mux(_readMemData_T_1, readHalfWordData, _readMemData_T_3) @[Mux.scala 101:16]
    node _readMemData_T_5 = mux(_readMemData_T, readByteData, _readMemData_T_4) @[Mux.scala 101:16]
    node _GEN_0 = validif(_T_26, addr) @[MEM.scala 70:37 71:25]
    node _GEN_1 = validif(_T_26, clock) @[MEM.scala 70:37 71:25]
    node _GEN_2 = mux(_T_26, UInt<1>("h1"), UInt<1>("h0")) @[MEM.scala 19:18 70:37 71:25]
    node _GEN_3 = validif(_T_26, _rdata1_T_2) @[MEM.scala 70:37 72:25]
    node _GEN_4 = validif(_T_26, _rdata2_T_2) @[MEM.scala 70:37 73:25]
    node _GEN_5 = validif(_T_26, _rdata3_T_2) @[MEM.scala 70:37 74:25]
    node _GEN_6 = mux(_T_26, _readMemData_T_5, readMemData) @[MEM.scala 70:37 94:21 22:30]
    node _GEN_7 = validif(_T, addr) @[MEM.scala 65:31 66:12]
    node _GEN_8 = validif(_T, clock) @[MEM.scala 65:31 66:12]
    node _GEN_9 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[MEM.scala 65:31 66:12 19:18]
    node _GEN_10 = validif(_T, UInt<1>("h1")) @[MEM.scala 65:31 66:19]
    node _GEN_11 = validif(_T, _T_4) @[MEM.scala 65:31 66:19]
    node _GEN_12 = validif(_T, _T_7) @[MEM.scala 65:31 67:12]
    node _GEN_13 = validif(_T, _T_11) @[MEM.scala 65:31 67:37]
    node _GEN_14 = validif(_T, _T_14) @[MEM.scala 65:31 68:12]
    node _GEN_15 = validif(_T, _T_18) @[MEM.scala 65:31 68:37]
    node _GEN_16 = validif(_T, _T_21) @[MEM.scala 65:31 69:12]
    node _GEN_17 = validif(_T, _T_25) @[MEM.scala 65:31 69:37]
    node _GEN_18 = validif(eq(_T, UInt<1>("h0")), _GEN_0) @[MEM.scala 65:31]
    node _GEN_19 = validif(eq(_T, UInt<1>("h0")), _GEN_1) @[MEM.scala 65:31]
    node _GEN_20 = mux(_T, UInt<1>("h0"), _GEN_2) @[MEM.scala 19:18 65:31]
    node _GEN_21 = validif(eq(_T, UInt<1>("h0")), _GEN_3) @[MEM.scala 65:31]
    node _GEN_22 = validif(eq(_T, UInt<1>("h0")), _GEN_4) @[MEM.scala 65:31]
    node _GEN_23 = validif(eq(_T, UInt<1>("h0")), _GEN_5) @[MEM.scala 65:31]
    node _GEN_24 = mux(_T, readMemData, _GEN_6) @[MEM.scala 22:30 65:31]
    node _wRegData_MEM_T = eq(io_wRegDataSrc_ctrl_uMEM_MEM, UInt<1>("h1")) @[MEM.scala 102:27]
    node _wRegData_MEM_T_1 = eq(io_wRegDataSrc_ctrl_uMEM_MEM, UInt<1>("h0")) @[MEM.scala 103:27]
    node _wRegData_MEM_T_2 = mux(_wRegData_MEM_T_1, io_aluResult_MEM, UInt<32>("h0")) @[Mux.scala 101:16]
    node wRegData_MEM = mux(_wRegData_MEM_T, readMemData, _wRegData_MEM_T_2) @[Mux.scala 101:16]
    io_wRegData_MEM <= wRegData_MEM @[MEM.scala 106:21]
    mem.rdata0.addr <= pad(_GEN_18, 14)
    mem.rdata0.en <= _GEN_20
    mem.rdata0.clk <= _GEN_19
    mem.rdata1.addr <= _GEN_21
    mem.rdata1.en <= _GEN_20
    mem.rdata1.clk <= _GEN_19
    mem.rdata2.addr <= _GEN_22
    mem.rdata2.en <= _GEN_20
    mem.rdata2.clk <= _GEN_19
    mem.rdata3.addr <= _GEN_23
    mem.rdata3.en <= _GEN_20
    mem.rdata3.clk <= _GEN_19
    mem.MPORT.addr <= pad(_GEN_7, 14)
    mem.MPORT.en <= _GEN_9
    mem.MPORT.clk <= _GEN_8
    mem.MPORT.data <= _GEN_11
    mem.MPORT.mask <= _GEN_10
    mem.MPORT_1.addr <= _GEN_12
    mem.MPORT_1.en <= _GEN_9
    mem.MPORT_1.clk <= _GEN_8
    mem.MPORT_1.data <= _GEN_13
    mem.MPORT_1.mask <= _GEN_10
    mem.MPORT_2.addr <= _GEN_14
    mem.MPORT_2.en <= _GEN_9
    mem.MPORT_2.clk <= _GEN_8
    mem.MPORT_2.data <= _GEN_15
    mem.MPORT_2.mask <= _GEN_10
    mem.MPORT_3.addr <= _GEN_16
    mem.MPORT_3.en <= _GEN_9
    mem.MPORT_3.clk <= _GEN_8
    mem.MPORT_3.data <= _GEN_17
    mem.MPORT_3.mask <= _GEN_10
    readMemData <= mux(reset, UInt<32>("h0"), _GEN_24) @[MEM.scala 22:{30,30}]

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

  module PLC :
    input clock : Clock
    input reset : UInt<1>
    input io_stallReqOfID : UInt<1>
    input io_flushReqOfID : UInt<1>
    output io_stallStageIF : UInt<1>
    output io_stallStageID : UInt<1>
    output io_flushStageID : UInt<1>
    output io_stallStageEXE : UInt<1>
    output io_flushStageEXE : UInt<1>
    output io_stallStageMEM : UInt<1>
    output io_flushStageMEM : UInt<1>
    output io_stallStageWB : UInt<1>
    output io_flushStageWB : UInt<1>

    node _io_flushStageID_T = not(io_stallReqOfID) @[PLC.scala 21:24]
    node _io_flushStageID_T_1 = and(_io_flushStageID_T, io_flushReqOfID) @[PLC.scala 21:41]
    io_stallStageIF <= io_stallReqOfID @[PLC.scala 19:21]
    io_stallStageID <= io_stallReqOfID @[PLC.scala 20:21]
    io_flushStageID <= _io_flushStageID_T_1 @[PLC.scala 21:21]
    io_stallStageEXE <= UInt<1>("h0") @[PLC.scala 22:22]
    io_flushStageEXE <= io_stallReqOfID @[PLC.scala 23:22]
    io_stallStageMEM <= UInt<1>("h0") @[PLC.scala 24:22]
    io_flushStageMEM <= UInt<1>("h0") @[PLC.scala 25:22]
    io_stallStageWB <= UInt<1>("h0") @[PLC.scala 26:21]
    io_flushStageWB <= UInt<1>("h0") @[PLC.scala 27:21]

  module MyCpu :
    input clock : Clock
    input reset : UInt<1>
    input io_reset : UInt<1>

    inst ifd of IF @[MyCpu.scala 11:21]
    inst if_id of IF_ID @[MyCpu.scala 12:23]
    inst id of ID @[MyCpu.scala 13:20]
    inst id_exe of ID_EXE @[MyCpu.scala 14:24]
    inst exe of EXE @[MyCpu.scala 15:21]
    inst exe_mem of EXE_MEM @[MyCpu.scala 16:25]
    inst mem of MEM @[MyCpu.scala 17:21]
    inst mem_wb of MEM_WB @[MyCpu.scala 18:24]
    inst plc of PLC @[MyCpu.scala 19:21]
    node _T = bits(reset, 0, 0) @[MyCpu.scala 40:11]
    node _T_1 = eq(_T, UInt<1>("h0")) @[MyCpu.scala 40:11]
    node _T_2 = bits(reset, 0, 0) @[MyCpu.scala 41:11]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[MyCpu.scala 41:11]
    node _T_4 = bits(reset, 0, 0) @[MyCpu.scala 44:11]
    node _T_5 = eq(_T_4, UInt<1>("h0")) @[MyCpu.scala 44:11]
    node _T_6 = bits(reset, 0, 0) @[MyCpu.scala 45:11]
    node _T_7 = eq(_T_6, UInt<1>("h0")) @[MyCpu.scala 45:11]
    node _T_8 = bits(reset, 0, 0) @[MyCpu.scala 46:11]
    node _T_9 = eq(_T_8, UInt<1>("h0")) @[MyCpu.scala 46:11]
    node _T_10 = bits(reset, 0, 0) @[MyCpu.scala 50:11]
    node _T_11 = eq(_T_10, UInt<1>("h0")) @[MyCpu.scala 50:11]
    node _T_12 = bits(reset, 0, 0) @[MyCpu.scala 51:11]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[MyCpu.scala 51:11]
    node _T_14 = bits(reset, 0, 0) @[MyCpu.scala 52:11]
    node _T_15 = eq(_T_14, UInt<1>("h0")) @[MyCpu.scala 52:11]
    node _T_16 = bits(reset, 0, 0) @[MyCpu.scala 64:11]
    node _T_17 = eq(_T_16, UInt<1>("h0")) @[MyCpu.scala 64:11]
    node _T_18 = bits(reset, 0, 0) @[MyCpu.scala 65:11]
    node _T_19 = eq(_T_18, UInt<1>("h0")) @[MyCpu.scala 65:11]
    node _T_20 = bits(reset, 0, 0) @[MyCpu.scala 66:11]
    node _T_21 = eq(_T_20, UInt<1>("h0")) @[MyCpu.scala 66:11]
    node _T_22 = bits(reset, 0, 0) @[MyCpu.scala 67:11]
    node _T_23 = eq(_T_22, UInt<1>("h0")) @[MyCpu.scala 67:11]
    node _T_24 = bits(reset, 0, 0) @[MyCpu.scala 68:11]
    node _T_25 = eq(_T_24, UInt<1>("h0")) @[MyCpu.scala 68:11]
    node _T_26 = bits(reset, 0, 0) @[MyCpu.scala 69:11]
    node _T_27 = eq(_T_26, UInt<1>("h0")) @[MyCpu.scala 69:11]
    node _T_28 = bits(reset, 0, 0) @[MyCpu.scala 70:11]
    node _T_29 = eq(_T_28, UInt<1>("h0")) @[MyCpu.scala 70:11]
    node _T_30 = bits(reset, 0, 0) @[MyCpu.scala 71:11]
    node _T_31 = eq(_T_30, UInt<1>("h0")) @[MyCpu.scala 71:11]
    node _T_32 = bits(reset, 0, 0) @[MyCpu.scala 84:11]
    node _T_33 = eq(_T_32, UInt<1>("h0")) @[MyCpu.scala 84:11]
    node _T_34 = bits(reset, 0, 0) @[MyCpu.scala 85:11]
    node _T_35 = eq(_T_34, UInt<1>("h0")) @[MyCpu.scala 85:11]
    node _T_36 = bits(reset, 0, 0) @[MyCpu.scala 86:11]
    node _T_37 = eq(_T_36, UInt<1>("h0")) @[MyCpu.scala 86:11]
    node _T_38 = bits(reset, 0, 0) @[MyCpu.scala 87:11]
    node _T_39 = eq(_T_38, UInt<1>("h0")) @[MyCpu.scala 87:11]
    node _T_40 = bits(reset, 0, 0) @[MyCpu.scala 88:11]
    node _T_41 = eq(_T_40, UInt<1>("h0")) @[MyCpu.scala 88:11]
    node _T_42 = bits(reset, 0, 0) @[MyCpu.scala 89:11]
    node _T_43 = eq(_T_42, UInt<1>("h0")) @[MyCpu.scala 89:11]
    node _T_44 = bits(reset, 0, 0) @[MyCpu.scala 90:11]
    node _T_45 = eq(_T_44, UInt<1>("h0")) @[MyCpu.scala 90:11]
    node _T_46 = bits(reset, 0, 0) @[MyCpu.scala 104:11]
    node _T_47 = eq(_T_46, UInt<1>("h0")) @[MyCpu.scala 104:11]
    node _T_48 = bits(reset, 0, 0) @[MyCpu.scala 105:11]
    node _T_49 = eq(_T_48, UInt<1>("h0")) @[MyCpu.scala 105:11]
    node _T_50 = bits(reset, 0, 0) @[MyCpu.scala 106:11]
    node _T_51 = eq(_T_50, UInt<1>("h0")) @[MyCpu.scala 106:11]
    node _T_52 = bits(reset, 0, 0) @[MyCpu.scala 107:11]
    node _T_53 = eq(_T_52, UInt<1>("h0")) @[MyCpu.scala 107:11]
    node _T_54 = bits(reset, 0, 0) @[MyCpu.scala 108:11]
    node _T_55 = eq(_T_54, UInt<1>("h0")) @[MyCpu.scala 108:11]
    node _T_56 = bits(reset, 0, 0) @[MyCpu.scala 109:11]
    node _T_57 = eq(_T_56, UInt<1>("h0")) @[MyCpu.scala 109:11]
    node _T_58 = bits(reset, 0, 0) @[MyCpu.scala 110:11]
    node _T_59 = eq(_T_58, UInt<1>("h0")) @[MyCpu.scala 110:11]
    node _T_60 = bits(reset, 0, 0) @[MyCpu.scala 118:11]
    node _T_61 = eq(_T_60, UInt<1>("h0")) @[MyCpu.scala 118:11]
    node _T_62 = bits(reset, 0, 0) @[MyCpu.scala 119:11]
    node _T_63 = eq(_T_62, UInt<1>("h0")) @[MyCpu.scala 119:11]
    node _T_64 = bits(reset, 0, 0) @[MyCpu.scala 124:11]
    node _T_65 = eq(_T_64, UInt<1>("h0")) @[MyCpu.scala 124:11]
    node _T_66 = bits(reset, 0, 0) @[MyCpu.scala 125:11]
    node _T_67 = eq(_T_66, UInt<1>("h0")) @[MyCpu.scala 125:11]
    node _T_68 = bits(reset, 0, 0) @[MyCpu.scala 126:11]
    node _T_69 = eq(_T_68, UInt<1>("h0")) @[MyCpu.scala 126:11]
    node _T_70 = bits(reset, 0, 0) @[MyCpu.scala 127:11]
    node _T_71 = eq(_T_70, UInt<1>("h0")) @[MyCpu.scala 127:11]
    ifd.clock <= clock
    ifd.reset <= reset
    ifd.io_stallStageIF <= plc.io_stallStageIF @[MyCpu.scala 29:25]
    ifd.io_branchTarget_ID <= id.io_branchTarge_ID @[MyCpu.scala 42:28]
    ifd.io_branchFlag_ID <= id.io_branchFlag_ID @[MyCpu.scala 43:26]
    ifd.io_reset <= reset @[MyCpu.scala 21:18]
    if_id.clock <= clock
    if_id.reset <= reset
    if_id.io_PC_IF <= ifd.io_PC_IF @[MyCpu.scala 48:20]
    if_id.io_instr_IF <= ifd.io_instr_IF @[MyCpu.scala 49:23]
    if_id.io_flushStageID <= plc.io_flushStageID @[MyCpu.scala 31:27]
    if_id.io_stallStageID <= plc.io_stallStageID @[MyCpu.scala 32:27]
    if_id.io_reset <= reset @[MyCpu.scala 22:20]
    id.clock <= clock
    id.reset <= reset
    id.io_PC_ID <= if_id.io_PC_ID @[MyCpu.scala 54:17]
    id.io_instr_ID <= if_id.io_instr_ID @[MyCpu.scala 55:20]
    id.io_reset <= reset @[MyCpu.scala 23:17]
    id.io_wRegAddr_EXE <= id_exe.io_wRegAddr_EXE @[MyCpu.scala 60:24]
    id.io_wRegAddr_MEM <= exe_mem.io_wRegAddr_MEM @[MyCpu.scala 61:24]
    id.io_aluResult_EXE <= exe.io_aluResult_EXE @[MyCpu.scala 59:25]
    id.io_wRegData_MEM <= mem.io_wRegData_MEM @[MyCpu.scala 62:24]
    id.io_wRegDataSrc_ctrl_uMEM_EXE <= id_exe.io_wRegDataSrc_ctrl_uMEM_EXE @[MyCpu.scala 63:37]
    id.io_wReg_ctrl_WB <= mem_wb.io_weReg_ctrl_uWB_WB @[MyCpu.scala 58:24]
    id.io_wRegaddr_WB <= mem_wb.io_wRegAddr_WB @[MyCpu.scala 56:23]
    id.io_wRegData_WB <= mem_wb.io_wRegData_WB @[MyCpu.scala 57:23]
    id_exe.clock <= clock
    id_exe.reset <= reset
    id_exe.io_flushStageID <= plc.io_flushStageEXE @[MyCpu.scala 33:28]
    id_exe.io_stallStageID <= plc.io_stallStageEXE @[MyCpu.scala 34:28]
    id_exe.io_reset <= reset @[MyCpu.scala 24:21]
    id_exe.io_aluOP_ctrl_uEXE_ID <= id.io_aluOP_ctrl_uEXE_ID @[MyCpu.scala 74:34]
    id_exe.io_data1_ID <= id.io_data1_ID @[MyCpu.scala 75:24]
    id_exe.io_data2_ID <= id.io_data2_ID @[MyCpu.scala 76:24]
    id_exe.io_wRegAddr_ID <= id.io_wRegAddr_ID @[MyCpu.scala 77:27]
    id_exe.io_wMemData_ID <= id.io_wMemData_ID @[MyCpu.scala 78:27]
    id_exe.io_weMEM_ctrl_uMEM_ID <= id.io_weMEM_ctrl_uMEM_ID @[MyCpu.scala 79:34]
    id_exe.io_wRegDataSrc_ctrl_uMEM_ID <= id.io_wRegDataSrc_ctrl_uMEM_ID @[MyCpu.scala 80:40]
    id_exe.io_wrMemByteSelScr_ctrl_uMEM_ID <= id.io_wrMemByteSelScr_ctrl_uMEM_ID @[MyCpu.scala 81:44]
    id_exe.io_memReadDataExt_ctrl_uMEM_ID <= id.io_memReadDataExt_ctrl_uMEM_ID @[MyCpu.scala 82:43]
    id_exe.io_weReg_ctrl_uWB_ID <= id.io_weReg_ctrl_uWB_ID @[MyCpu.scala 83:33]
    exe.clock <= clock
    exe.reset <= reset
    exe.io_aluOP_ctrl_uEXE_EXE <= id_exe.io_aluOP_ctrl_uID_EXE @[MyCpu.scala 92:32]
    exe.io_data1_EXE <= id_exe.io_data1_EXE @[MyCpu.scala 93:22]
    exe.io_data2_EXE <= id_exe.io_data2_EXE @[MyCpu.scala 94:22]
    exe_mem.clock <= clock
    exe_mem.reset <= reset
    exe_mem.io_aluResult_EXE <= exe.io_aluResult_EXE @[MyCpu.scala 96:30]
    exe_mem.io_wRegAddr_EXE <= id_exe.io_wRegAddr_EXE @[MyCpu.scala 97:29]
    exe_mem.io_wMemData_EXE <= id_exe.io_wMemData_EXE @[MyCpu.scala 98:29]
    exe_mem.io_weMEM_ctrl_uMEM_EXE <= id_exe.io_weMEM_ctrl_uMEM_EXE @[MyCpu.scala 99:36]
    exe_mem.io_wRegDataSrc_ctrl_uMEM_EXE <= id_exe.io_wRegDataSrc_ctrl_uMEM_EXE @[MyCpu.scala 100:42]
    exe_mem.io_wrMemByteSelScr_ctrl_uMEM_EXE <= id_exe.io_wrMemByteSelScr_ctrl_uMEM_EXE @[MyCpu.scala 101:46]
    exe_mem.io_memReadDataExt_ctrl_uMEM_EXE <= id_exe.io_memReadDataExt_ctrl_uMEM_EXE @[MyCpu.scala 102:45]
    exe_mem.io_weReg_ctrl_uWB_EXE <= id_exe.io_weReg_ctrl_uWB_EXE @[MyCpu.scala 103:35]
    exe_mem.io_flushStageMEM <= plc.io_flushStageMEM @[MyCpu.scala 36:30]
    exe_mem.io_stallStageMEM <= plc.io_stallStageMEM @[MyCpu.scala 35:30]
    exe_mem.io_reset <= reset @[MyCpu.scala 25:22]
    mem.clock <= clock
    mem.reset <= reset
    mem.io_aluResult_MEM <= exe_mem.io_aluResult_MEM @[MyCpu.scala 112:26]
    mem.io_wMemData_MEM <= exe_mem.io_wMemData_MEM @[MyCpu.scala 113:25]
    mem.io_weMEM_ctrl_uMEM_MEM <= exe_mem.io_weMEM_ctrl_uMEM_MEM @[MyCpu.scala 114:32]
    mem.io_wRegDataSrc_ctrl_uMEM_MEM <= exe_mem.io_wRegDataSrc_ctrl_uMEM_MEM @[MyCpu.scala 115:38]
    mem.io_wrMemByteSelScr_ctrl_uMEM_MEM <= exe_mem.io_wrMemByteSelScr_ctrl_uMEM_MEM @[MyCpu.scala 116:42]
    mem.io_memReadDataExt_ctrl_uMEM_MEM <= exe_mem.io_memReadDataExt_ctrl_uMEM_MEM @[MyCpu.scala 117:41]
    mem.io_reset <= reset @[MyCpu.scala 26:18]
    mem_wb.clock <= clock
    mem_wb.reset <= reset
    mem_wb.io_flushStageWB <= plc.io_flushStageWB @[MyCpu.scala 38:28]
    mem_wb.io_stallStageWB <= plc.io_stallStageWB @[MyCpu.scala 37:28]
    mem_wb.io_reset <= reset @[MyCpu.scala 27:21]
    mem_wb.io_wRegData_MEM <= mem.io_wRegData_MEM @[MyCpu.scala 121:28]
    mem_wb.io_wRegAddr_MEM <= exe_mem.io_wRegAddr_MEM @[MyCpu.scala 123:28]
    mem_wb.io_weReg_ctrl_uWB_MEM <= exe_mem.io_weReg_ctrl_uWB_MEM @[MyCpu.scala 122:34]
    plc.clock <= clock
    plc.reset <= reset
    plc.io_stallReqOfID <= id.io_stallReqOfID_ID @[MyCpu.scala 129:25]
    plc.io_flushReqOfID <= id.io_flushReqOfID_ID @[MyCpu.scala 130:25]
    printf(clock, and(and(UInt<1>("h1"), _T_1), UInt<1>("h1")), "branchTarget_ID: %x\n", id.io_branchTarge_ID) : printf @[MyCpu.scala 40:11]
    printf(clock, and(and(UInt<1>("h1"), _T_3), UInt<1>("h1")), "********************************************************\n") : printf_1 @[MyCpu.scala 41:11]
    printf(clock, and(and(UInt<1>("h1"), _T_5), UInt<1>("h1")), "PC_IF: %x\n", ifd.io_PC_IF) : printf_2 @[MyCpu.scala 44:11]
    printf(clock, and(and(UInt<1>("h1"), _T_7), UInt<1>("h1")), "instr_IF: %x\n", ifd.io_instr_IF) : printf_3 @[MyCpu.scala 45:11]
    printf(clock, and(and(UInt<1>("h1"), _T_9), UInt<1>("h1")), "********************************************************\n") : printf_4 @[MyCpu.scala 46:11]
    printf(clock, and(and(UInt<1>("h1"), _T_11), UInt<1>("h1")), "PC_ID: %x\n", if_id.io_PC_ID) : printf_5 @[MyCpu.scala 50:11]
    printf(clock, and(and(UInt<1>("h1"), _T_13), UInt<1>("h1")), "instr_ID: %x\n", if_id.io_instr_ID) : printf_6 @[MyCpu.scala 51:11]
    printf(clock, and(and(UInt<1>("h1"), _T_15), UInt<1>("h1")), "********************************************************\n") : printf_7 @[MyCpu.scala 52:11]
    printf(clock, and(and(UInt<1>("h1"), _T_17), UInt<1>("h1")), "data1_ID: %x\n", id.io_data1_ID) : printf_8 @[MyCpu.scala 64:11]
    printf(clock, and(and(UInt<1>("h1"), _T_19), UInt<1>("h1")), "data2_ID: %x\n", id.io_data2_ID) : printf_9 @[MyCpu.scala 65:11]
    printf(clock, and(and(UInt<1>("h1"), _T_21), UInt<1>("h1")), "aluOP_ctrl_uEXE_ID: %x\n", id.io_aluOP_ctrl_uEXE_ID) : printf_10 @[MyCpu.scala 66:11]
    printf(clock, and(and(UInt<1>("h1"), _T_23), UInt<1>("h1")), "wRegAddr_ID: %x\n", id.io_wRegAddr_ID) : printf_11 @[MyCpu.scala 67:11]
    printf(clock, and(and(UInt<1>("h1"), _T_25), UInt<1>("h1")), "wMemData_ID: %x\n", id.io_wMemData_ID) : printf_12 @[MyCpu.scala 68:11]
    printf(clock, and(and(UInt<1>("h1"), _T_27), UInt<1>("h1")), "branchTarget_ID: %x\n", id.io_branchTarge_ID) : printf_13 @[MyCpu.scala 69:11]
    printf(clock, and(and(UInt<1>("h1"), _T_29), UInt<1>("h1")), "branchFalg_ID: %x\n", id.io_branchFlag_ID) : printf_14 @[MyCpu.scala 70:11]
    printf(clock, and(and(UInt<1>("h1"), _T_31), UInt<1>("h1")), "********************************************************\n") : printf_15 @[MyCpu.scala 71:11]
    printf(clock, and(and(UInt<1>("h1"), _T_33), UInt<1>("h1")), "aluResult_EXE: %x\n", exe.io_aluResult_EXE) : printf_16 @[MyCpu.scala 84:11]
    printf(clock, and(and(UInt<1>("h1"), _T_35), UInt<1>("h1")), "wRegAddr_EXE: %x\n", id_exe.io_wRegAddr_EXE) : printf_17 @[MyCpu.scala 85:11]
    printf(clock, and(and(UInt<1>("h1"), _T_37), UInt<1>("h1")), "wRegData_EXE: %x\n", id_exe.io_wMemData_EXE) : printf_18 @[MyCpu.scala 86:11]
    printf(clock, and(and(UInt<1>("h1"), _T_39), UInt<1>("h1")), "weMEM_ctrl_EXE: %x\n", id_exe.io_weMEM_ctrl_uMEM_EXE) : printf_19 @[MyCpu.scala 87:11]
    printf(clock, and(and(UInt<1>("h1"), _T_41), UInt<1>("h1")), "wRegDataSrc_ctrl_uMEM_EXE: %x\n", id_exe.io_wRegDataSrc_ctrl_uMEM_EXE) : printf_20 @[MyCpu.scala 88:11]
    printf(clock, and(and(UInt<1>("h1"), _T_43), UInt<1>("h1")), "weReg_ctrl_uWB_EXE: %x\n", id_exe.io_weReg_ctrl_uWB_EXE) : printf_21 @[MyCpu.scala 89:11]
    printf(clock, and(and(UInt<1>("h1"), _T_45), UInt<1>("h1")), "********************************************************\n") : printf_22 @[MyCpu.scala 90:11]
    printf(clock, and(and(UInt<1>("h1"), _T_47), UInt<1>("h1")), "wRegAddr_MEM: %x\n", exe_mem.io_wRegAddr_MEM) : printf_23 @[MyCpu.scala 104:11]
    printf(clock, and(and(UInt<1>("h1"), _T_49), UInt<1>("h1")), "weReg_ctrl_uWB_MEM: %x\n", exe_mem.io_weReg_ctrl_uWB_MEM) : printf_24 @[MyCpu.scala 105:11]
    printf(clock, and(and(UInt<1>("h1"), _T_51), UInt<1>("h1")), "wMemData_MEM: %x\n", exe_mem.io_wMemData_MEM) : printf_25 @[MyCpu.scala 106:11]
    printf(clock, and(and(UInt<1>("h1"), _T_53), UInt<1>("h1")), "weMEM_ctrl_uMEM_MEM: %x\n", exe_mem.io_weMEM_ctrl_uMEM_MEM) : printf_26 @[MyCpu.scala 107:11]
    printf(clock, and(and(UInt<1>("h1"), _T_55), UInt<1>("h1")), "wRegDataSrc_ctrl_uMEM_MEM: %x\n", exe_mem.io_wRegDataSrc_ctrl_uMEM_MEM) : printf_27 @[MyCpu.scala 108:11]
    printf(clock, and(and(UInt<1>("h1"), _T_57), UInt<1>("h1")), "aluResult_MEM: %x\n", exe_mem.io_aluResult_MEM) : printf_28 @[MyCpu.scala 109:11]
    printf(clock, and(and(UInt<1>("h1"), _T_59), UInt<1>("h1")), "********************************************************\n") : printf_29 @[MyCpu.scala 110:11]
    printf(clock, and(and(UInt<1>("h1"), _T_61), UInt<1>("h1")), "wRegData_MEM: %x\n", mem.io_wRegData_MEM) : printf_30 @[MyCpu.scala 118:11]
    printf(clock, and(and(UInt<1>("h1"), _T_63), UInt<1>("h1")), "********************************************************\n") : printf_31 @[MyCpu.scala 119:11]
    printf(clock, and(and(UInt<1>("h1"), _T_65), UInt<1>("h1")), "wRegData_WB: %x\n", mem_wb.io_wRegData_WB) : printf_32 @[MyCpu.scala 124:11]
    printf(clock, and(and(UInt<1>("h1"), _T_67), UInt<1>("h1")), "wRegAddr_WB: %x\n", mem_wb.io_wRegAddr_WB) : printf_33 @[MyCpu.scala 125:11]
    printf(clock, and(and(UInt<1>("h1"), _T_69), UInt<1>("h1")), "weReg_ctrl_uWB_WB: %x\n", mem_wb.io_weReg_ctrl_uWB_WB) : printf_34 @[MyCpu.scala 126:11]
    printf(clock, and(and(UInt<1>("h1"), _T_71), UInt<1>("h1")), "********************************************************\n") : printf_35 @[MyCpu.scala 127:11]

module ID(
  input         clock,
  input         reset,
  input  [31:0] io_PC_ID,
  input  [31:0] io_instr_ID,
  input         io_flush,
  input         io_stall,
  input         io_reset,
  input  [4:0]  io_wRegAddr_EXE,
  input  [4:0]  io_wRegAddr_MEM,
  input  [31:0] io_aluResult_EXE,
  input  [31:0] io_wRegData_MEM,
  input         io_wRegDataSrc_ctrl_uMEM_EXE,
  input         io_wReg_ctrl_uWB_WB,
  input  [4:0]  io_wRegaddr_WB,
  input  [31:0] io_wRegData_WB,
  output [31:0] io_data1_ID,
  output [31:0] io_data2_ID,
  output [4:0]  io_wRegAddr_ID,
  output [31:0] io_wMemData_ID,
  output [31:0] io_branchTarge_ID,
  output        io_branchFlag_ID,
  output        io_stallReqOfID_ID,
  output        io_flushReqOfID_ID,
  output        io_weReg_ctrl_uWB_ID,
  output        io_memReadDataExt_ctrl_uMEM_ID,
  output [1:0]  io_wrMemByteSelScr_ctrl_uMEM_ID,
  output        io_wRegDataSrc_ctrl_uMEM_ID,
  output        io_weMEM_ctrl_uMEM_ID,
  output [3:0]  io_aluOP_ctrl_uEXE_ID
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regfile [0:31]; // @[ID.scala 37:22]
  wire  regfile_data1_MPORT_en; // @[ID.scala 37:22]
  wire [4:0] regfile_data1_MPORT_addr; // @[ID.scala 37:22]
  wire [31:0] regfile_data1_MPORT_data; // @[ID.scala 37:22]
  wire  regfile_data2_MPORT_en; // @[ID.scala 37:22]
  wire [4:0] regfile_data2_MPORT_addr; // @[ID.scala 37:22]
  wire [31:0] regfile_data2_MPORT_data; // @[ID.scala 37:22]
  wire  regfile_wMemData_MPORT_en; // @[ID.scala 37:22]
  wire [4:0] regfile_wMemData_MPORT_addr; // @[ID.scala 37:22]
  wire [31:0] regfile_wMemData_MPORT_data; // @[ID.scala 37:22]
  wire  regfile_wMemData_MPORT_1_en; // @[ID.scala 37:22]
  wire [4:0] regfile_wMemData_MPORT_1_addr; // @[ID.scala 37:22]
  wire [31:0] regfile_wMemData_MPORT_1_data; // @[ID.scala 37:22]
  wire  regfile_wMemData_MPORT_2_en; // @[ID.scala 37:22]
  wire [4:0] regfile_wMemData_MPORT_2_addr; // @[ID.scala 37:22]
  wire [31:0] regfile_wMemData_MPORT_2_data; // @[ID.scala 37:22]
  wire [31:0] regfile_MPORT_data; // @[ID.scala 37:22]
  wire [4:0] regfile_MPORT_addr; // @[ID.scala 37:22]
  wire  regfile_MPORT_mask; // @[ID.scala 37:22]
  wire  regfile_MPORT_en; // @[ID.scala 37:22]
  wire [11:0] si12 = io_instr_ID[21:10]; // @[ID.scala 39:27]
  wire [19:0] _ext_si12_T_2 = si12[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] ext_si12 = {_ext_si12_T_2,si12}; // @[Cat.scala 31:58]
  wire [15:0] o16 = io_instr_ID[25:10]; // @[ID.scala 41:26]
  wire [13:0] _ext_o16_T_2 = o16[15] ? 14'h3fff : 14'h0; // @[Bitwise.scala 74:12]
  wire [31:0] ext_o16 = {_ext_o16_T_2,o16,2'h0}; // @[Cat.scala 31:58]
  wire [19:0] si20 = io_instr_ID[24:5]; // @[ID.scala 43:27]
  wire [31:0] ext_si20 = {si20,12'h0}; // @[Cat.scala 31:58]
  wire [25:0] o26 = {io_instr_ID[9:0],o16}; // @[Cat.scala 31:58]
  wire [3:0] _ext_o26_T_2 = o26[25] ? 4'hf : 4'h0; // @[Bitwise.scala 74:12]
  wire [31:0] ext_o26 = {_ext_o26_T_2,io_instr_ID[9:0],o16,2'h0}; // @[Cat.scala 31:58]
  wire [4:0] rj_addr = io_instr_ID[9:5]; // @[ID.scala 47:30]
  wire [4:0] rk_addr = io_instr_ID[14:10]; // @[ID.scala 48:30]
  wire [4:0] rd_addr = io_instr_ID[4:0]; // @[ID.scala 50:30]
  wire  stall_case1 = io_wReg_ctrl_uWB_WB & rj_addr != 5'h0 & rj_addr == io_wRegAddr_EXE; // @[ID.scala 51:75]
  wire  stall_case2 = io_wReg_ctrl_uWB_WB & rk_addr != 5'h0 & rk_addr == io_wRegAddr_EXE; // @[ID.scala 52:75]
  wire  _T_1 = ~reset; // @[ID.scala 54:11]
  wire [31:0] _csignals_T = io_instr_ID & 32'hffff8000; // @[Lookup.scala 31:38]
  wire  _csignals_T_1 = 32'h100000 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h178000 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_5 = 32'h180000 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_6 = io_instr_ID & 32'hffc00000; // @[Lookup.scala 31:38]
  wire  _csignals_T_7 = 32'h2800000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_9 = 32'h28000000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_11 = 32'h28400000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_13 = 32'h28800000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_15 = 32'h29000000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_17 = 32'h29400000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_19 = 32'h29800000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_20 = io_instr_ID & 32'hfe000000; // @[Lookup.scala 31:38]
  wire  _csignals_T_21 = 32'h14000000 == _csignals_T_20; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_22 = io_instr_ID & 32'hfc000000; // @[Lookup.scala 31:38]
  wire  _csignals_T_23 = 32'h54000000 == _csignals_T_22; // @[Lookup.scala 31:38]
  wire  _csignals_T_25 = 32'h4c000000 == _csignals_T_22; // @[Lookup.scala 31:38]
  wire  _csignals_T_27 = 32'h58000000 == _csignals_T_22; // @[Lookup.scala 31:38]
  wire  _csignals_T_29 = 32'h64000000 == _csignals_T_22; // @[Lookup.scala 31:38]
  wire  _csignals_T_31 = 32'h68000000 == _csignals_T_22; // @[Lookup.scala 31:38]
  wire  _csignals_T_33 = 32'h2000000 == _csignals_T_6; // @[Lookup.scala 31:38]
  wire  _csignals_T_35 = 32'h488000 == _csignals_T; // @[Lookup.scala 31:38]
  wire [3:0] _csignals_T_36 = _csignals_T_35 ? 4'h2 : 4'h0; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_37 = _csignals_T_33 ? 4'h9 : _csignals_T_36; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_38 = _csignals_T_31 ? 4'h6 : _csignals_T_37; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_39 = _csignals_T_29 ? 4'h5 : _csignals_T_38; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_40 = _csignals_T_27 ? 4'h4 : _csignals_T_39; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_41 = _csignals_T_25 ? 4'h1 : _csignals_T_40; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_42 = _csignals_T_23 ? 4'h7 : _csignals_T_41; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_43 = _csignals_T_21 ? 4'h0 : _csignals_T_42; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_44 = _csignals_T_19 ? 4'h1 : _csignals_T_43; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_45 = _csignals_T_17 ? 4'h1 : _csignals_T_44; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_46 = _csignals_T_15 ? 4'h1 : _csignals_T_45; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_47 = _csignals_T_13 ? 4'h1 : _csignals_T_46; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_48 = _csignals_T_11 ? 4'h1 : _csignals_T_47; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_49 = _csignals_T_9 ? 4'h1 : _csignals_T_48; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_50 = _csignals_T_7 ? 4'h1 : _csignals_T_49; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_51 = _csignals_T_5 ? 4'h3 : _csignals_T_50; // @[Lookup.scala 34:39]
  wire [3:0] _csignals_T_52 = _csignals_T_3 ? 4'h2 : _csignals_T_51; // @[Lookup.scala 34:39]
  wire [3:0] csignals_0 = _csignals_T_1 ? 4'h1 : _csignals_T_52; // @[Lookup.scala 34:39]
  wire  _csignals_T_59 = _csignals_T_23 ? 1'h0 : _csignals_T_25 | (_csignals_T_27 | (_csignals_T_29 | (_csignals_T_31 |
    (_csignals_T_33 | _csignals_T_35)))); // @[Lookup.scala 34:39]
  wire  _csignals_T_60 = _csignals_T_21 ? 1'h0 : _csignals_T_59; // @[Lookup.scala 34:39]
  wire  csignals_1 = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (_csignals_T_11
     | (_csignals_T_13 | (_csignals_T_15 | (_csignals_T_17 | (_csignals_T_19 | _csignals_T_60))))))))); // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_70 = _csignals_T_35 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_71 = _csignals_T_33 ? 2'h0 : _csignals_T_70; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_72 = _csignals_T_31 ? 2'h2 : _csignals_T_71; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_73 = _csignals_T_29 ? 2'h2 : _csignals_T_72; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_74 = _csignals_T_27 ? 2'h2 : _csignals_T_73; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_75 = _csignals_T_25 ? 2'h0 : _csignals_T_74; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_76 = _csignals_T_23 ? 2'h0 : _csignals_T_75; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_77 = _csignals_T_21 ? 2'h0 : _csignals_T_76; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_78 = _csignals_T_19 ? 2'h2 : _csignals_T_77; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_79 = _csignals_T_17 ? 2'h2 : _csignals_T_78; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_80 = _csignals_T_15 ? 2'h2 : _csignals_T_79; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_81 = _csignals_T_13 ? 2'h0 : _csignals_T_80; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_82 = _csignals_T_11 ? 2'h0 : _csignals_T_81; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_83 = _csignals_T_9 ? 2'h0 : _csignals_T_82; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_84 = _csignals_T_7 ? 2'h0 : _csignals_T_83; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_85 = _csignals_T_5 ? 2'h1 : _csignals_T_84; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_86 = _csignals_T_3 ? 2'h1 : _csignals_T_85; // @[Lookup.scala 34:39]
  wire [1:0] csignals_2 = _csignals_T_1 ? 2'h1 : _csignals_T_86; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_87 = _csignals_T_35 ? 2'h1 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_88 = _csignals_T_33 ? 2'h1 : _csignals_T_87; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_89 = _csignals_T_31 ? 2'h1 : _csignals_T_88; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_90 = _csignals_T_29 ? 2'h1 : _csignals_T_89; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_91 = _csignals_T_27 ? 2'h1 : _csignals_T_90; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_92 = _csignals_T_25 ? 2'h1 : _csignals_T_91; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_93 = _csignals_T_23 ? 2'h0 : _csignals_T_92; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_94 = _csignals_T_21 ? 2'h0 : _csignals_T_93; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_95 = _csignals_T_19 ? 2'h1 : _csignals_T_94; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_96 = _csignals_T_17 ? 2'h1 : _csignals_T_95; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_97 = _csignals_T_15 ? 2'h1 : _csignals_T_96; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_98 = _csignals_T_13 ? 2'h1 : _csignals_T_97; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_99 = _csignals_T_11 ? 2'h1 : _csignals_T_98; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_100 = _csignals_T_9 ? 2'h1 : _csignals_T_99; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_101 = _csignals_T_7 ? 2'h1 : _csignals_T_100; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_102 = _csignals_T_5 ? 2'h1 : _csignals_T_101; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_103 = _csignals_T_3 ? 2'h1 : _csignals_T_102; // @[Lookup.scala 34:39]
  wire [1:0] csignals_3 = _csignals_T_1 ? 2'h1 : _csignals_T_103; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_105 = _csignals_T_33 ? 2'h2 : _csignals_T_87; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_106 = _csignals_T_31 ? 2'h1 : _csignals_T_105; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_107 = _csignals_T_29 ? 2'h1 : _csignals_T_106; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_108 = _csignals_T_27 ? 2'h1 : _csignals_T_107; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_109 = _csignals_T_25 ? 2'h2 : _csignals_T_108; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_110 = _csignals_T_23 ? 2'h0 : _csignals_T_109; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_111 = _csignals_T_21 ? 2'h2 : _csignals_T_110; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_112 = _csignals_T_19 ? 2'h2 : _csignals_T_111; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_113 = _csignals_T_17 ? 2'h2 : _csignals_T_112; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_114 = _csignals_T_15 ? 2'h2 : _csignals_T_113; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_115 = _csignals_T_13 ? 2'h2 : _csignals_T_114; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_116 = _csignals_T_11 ? 2'h2 : _csignals_T_115; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_117 = _csignals_T_9 ? 2'h2 : _csignals_T_116; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_118 = _csignals_T_7 ? 2'h2 : _csignals_T_117; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_119 = _csignals_T_5 ? 2'h1 : _csignals_T_118; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_120 = _csignals_T_3 ? 2'h1 : _csignals_T_119; // @[Lookup.scala 34:39]
  wire [1:0] csignals_4 = _csignals_T_1 ? 2'h1 : _csignals_T_120; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_121 = _csignals_T_35 ? 2'h2 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_122 = _csignals_T_33 ? 2'h2 : _csignals_T_121; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_123 = _csignals_T_31 ? 2'h0 : _csignals_T_122; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_124 = _csignals_T_29 ? 2'h0 : _csignals_T_123; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_125 = _csignals_T_27 ? 2'h0 : _csignals_T_124; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_126 = _csignals_T_25 ? 2'h2 : _csignals_T_125; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_127 = _csignals_T_23 ? 2'h1 : _csignals_T_126; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_128 = _csignals_T_21 ? 2'h2 : _csignals_T_127; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_129 = _csignals_T_19 ? 2'h0 : _csignals_T_128; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_130 = _csignals_T_17 ? 2'h0 : _csignals_T_129; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_131 = _csignals_T_15 ? 2'h0 : _csignals_T_130; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_132 = _csignals_T_13 ? 2'h2 : _csignals_T_131; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_133 = _csignals_T_11 ? 2'h2 : _csignals_T_132; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_134 = _csignals_T_9 ? 2'h2 : _csignals_T_133; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_135 = _csignals_T_7 ? 2'h2 : _csignals_T_134; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_136 = _csignals_T_5 ? 2'h2 : _csignals_T_135; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_137 = _csignals_T_3 ? 2'h2 : _csignals_T_136; // @[Lookup.scala 34:39]
  wire [1:0] csignals_5 = _csignals_T_1 ? 2'h2 : _csignals_T_137; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_149 = _csignals_T_13 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_150 = _csignals_T_11 ? 2'h2 : _csignals_T_149; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_151 = _csignals_T_9 ? 2'h1 : _csignals_T_150; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_152 = _csignals_T_7 ? 2'h0 : _csignals_T_151; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_153 = _csignals_T_5 ? 2'h0 : _csignals_T_152; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_154 = _csignals_T_3 ? 2'h0 : _csignals_T_153; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_163 = _csignals_T_19 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_164 = _csignals_T_17 ? 2'h2 : _csignals_T_163; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_165 = _csignals_T_15 ? 2'h1 : _csignals_T_164; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_166 = _csignals_T_13 ? 2'h0 : _csignals_T_165; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_167 = _csignals_T_11 ? 2'h0 : _csignals_T_166; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_168 = _csignals_T_9 ? 2'h0 : _csignals_T_167; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_169 = _csignals_T_7 ? 2'h0 : _csignals_T_168; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_170 = _csignals_T_5 ? 2'h0 : _csignals_T_169; // @[Lookup.scala 34:39]
  wire [1:0] _csignals_T_171 = _csignals_T_3 ? 2'h0 : _csignals_T_170; // @[Lookup.scala 34:39]
  wire [1:0] csignals_7 = _csignals_T_1 ? 2'h0 : _csignals_T_171; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_173 = _csignals_T_33 ? 3'h1 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_174 = _csignals_T_31 ? 3'h3 : _csignals_T_173; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_175 = _csignals_T_29 ? 3'h3 : _csignals_T_174; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_176 = _csignals_T_27 ? 3'h3 : _csignals_T_175; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_177 = _csignals_T_25 ? 3'h3 : _csignals_T_176; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_178 = _csignals_T_23 ? 3'h4 : _csignals_T_177; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_179 = _csignals_T_21 ? 3'h2 : _csignals_T_178; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_180 = _csignals_T_19 ? 3'h1 : _csignals_T_179; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_181 = _csignals_T_17 ? 3'h1 : _csignals_T_180; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_182 = _csignals_T_15 ? 3'h1 : _csignals_T_181; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_183 = _csignals_T_13 ? 3'h1 : _csignals_T_182; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_184 = _csignals_T_11 ? 3'h1 : _csignals_T_183; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_185 = _csignals_T_9 ? 3'h1 : _csignals_T_184; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_186 = _csignals_T_7 ? 3'h1 : _csignals_T_185; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_187 = _csignals_T_5 ? 3'h0 : _csignals_T_186; // @[Lookup.scala 34:39]
  wire [2:0] _csignals_T_188 = _csignals_T_3 ? 3'h0 : _csignals_T_187; // @[Lookup.scala 34:39]
  wire [2:0] csignals_8 = _csignals_T_1 ? 3'h0 : _csignals_T_188; // @[Lookup.scala 34:39]
  wire  _csignals_T_200 = _csignals_T_13 ? 1'h0 : _csignals_T_15 | (_csignals_T_17 | _csignals_T_19); // @[Lookup.scala 34:39]
  wire  _csignals_T_201 = _csignals_T_11 ? 1'h0 : _csignals_T_200; // @[Lookup.scala 34:39]
  wire  _csignals_T_202 = _csignals_T_9 ? 1'h0 : _csignals_T_201; // @[Lookup.scala 34:39]
  wire  _csignals_T_203 = _csignals_T_7 ? 1'h0 : _csignals_T_202; // @[Lookup.scala 34:39]
  wire  _csignals_T_204 = _csignals_T_5 ? 1'h0 : _csignals_T_203; // @[Lookup.scala 34:39]
  wire  _csignals_T_205 = _csignals_T_3 ? 1'h0 : _csignals_T_204; // @[Lookup.scala 34:39]
  wire  _csignals_T_208 = _csignals_T_31 ? 1'h0 : _csignals_T_33 | _csignals_T_35; // @[Lookup.scala 34:39]
  wire  _csignals_T_209 = _csignals_T_29 ? 1'h0 : _csignals_T_208; // @[Lookup.scala 34:39]
  wire  _csignals_T_210 = _csignals_T_27 ? 1'h0 : _csignals_T_209; // @[Lookup.scala 34:39]
  wire  _csignals_T_214 = _csignals_T_19 ? 1'h0 : _csignals_T_21 | (_csignals_T_23 | (_csignals_T_25 | _csignals_T_210))
    ; // @[Lookup.scala 34:39]
  wire  _csignals_T_215 = _csignals_T_17 ? 1'h0 : _csignals_T_214; // @[Lookup.scala 34:39]
  wire  _csignals_T_216 = _csignals_T_15 ? 1'h0 : _csignals_T_215; // @[Lookup.scala 34:39]
  wire  _csignals_T_237 = _csignals_T_7 ? 1'h0 : _csignals_T_9 | (_csignals_T_11 | _csignals_T_13); // @[Lookup.scala 34:39]
  wire  _csignals_T_238 = _csignals_T_5 ? 1'h0 : _csignals_T_237; // @[Lookup.scala 34:39]
  wire  _csignals_T_239 = _csignals_T_3 ? 1'h0 : _csignals_T_238; // @[Lookup.scala 34:39]
  wire [4:0] raddr_1 = csignals_1 ? rj_addr : 5'h0; // @[Mux.scala 101:16]
  wire  _raddr_2_T = csignals_2 == 2'h1; // @[ID.scala 85:19]
  wire  _raddr_2_T_1 = csignals_2 == 2'h2; // @[ID.scala 86:19]
  wire  _raddr_2_T_2 = csignals_2 == 2'h3; // @[ID.scala 87:19]
  wire [4:0] _raddr_2_T_3 = _raddr_2_T_2 ? rk_addr : 5'h0; // @[Mux.scala 101:16]
  wire [4:0] _raddr_2_T_4 = _raddr_2_T_1 ? rd_addr : _raddr_2_T_3; // @[Mux.scala 101:16]
  wire [4:0] raddr_2 = _raddr_2_T ? rk_addr : _raddr_2_T_4; // @[Mux.scala 101:16]
  wire  _wb_addr_T = csignals_5 == 2'h1; // @[ID.scala 91:15]
  wire  _wb_addr_T_1 = csignals_5 == 2'h2; // @[ID.scala 92:15]
  wire [4:0] _wb_addr_T_2 = _wb_addr_T_1 ? rd_addr : 5'h0; // @[Mux.scala 101:16]
  wire  _data1_T_2 = raddr_1 == io_wRegAddr_MEM & io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 96:40]
  wire  _data1_T_4 = ~io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 97:73]
  wire  _data1_T_5 = raddr_1 == io_wRegAddr_EXE & ~io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 97:40]
  wire  _data1_T_8 = raddr_1 == io_wRegaddr_WB & io_wReg_ctrl_uWB_WB; // @[ID.scala 98:40]
  wire [31:0] _data1_T_9 = _data1_T_8 ? io_wRegData_WB : regfile_data1_MPORT_data; // @[Mux.scala 101:16]
  wire [31:0] _data1_T_10 = _data1_T_5 ? io_aluResult_EXE : _data1_T_9; // @[Mux.scala 101:16]
  wire [31:0] data1 = _data1_T_2 ? io_wRegData_MEM : _data1_T_10; // @[Mux.scala 101:16]
  wire  _data2_T_2 = raddr_2 == io_wRegAddr_MEM & io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 102:40]
  wire  _data2_T_5 = raddr_2 == io_wRegAddr_EXE & _data1_T_4; // @[ID.scala 103:40]
  wire  _data2_T_8 = raddr_2 == io_wRegaddr_WB & io_wReg_ctrl_uWB_WB; // @[ID.scala 104:40]
  wire [31:0] _data2_T_9 = _data2_T_8 ? io_wRegData_WB : regfile_data2_MPORT_data; // @[Mux.scala 101:16]
  wire [31:0] _data2_T_10 = _data2_T_5 ? io_aluResult_EXE : _data2_T_9; // @[Mux.scala 101:16]
  wire [31:0] data2 = _data2_T_2 ? io_wRegData_MEM : _data2_T_10; // @[Mux.scala 101:16]
  wire  _op1_data_T = csignals_3 == 2'h1; // @[ID.scala 108:18]
  wire  _op1_data_T_1 = csignals_3 == 2'h2; // @[ID.scala 109:18]
  wire [31:0] _op1_data_T_2 = _op1_data_T_1 ? io_PC_ID : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] op1_data = _op1_data_T ? data1 : _op1_data_T_2; // @[Mux.scala 101:16]
  wire  _imm_data_T = csignals_8 == 3'h1; // @[ID.scala 112:14]
  wire  _imm_data_T_1 = csignals_8 == 3'h2; // @[ID.scala 113:14]
  wire  _imm_data_T_2 = csignals_8 == 3'h3; // @[ID.scala 114:14]
  wire  _imm_data_T_3 = csignals_8 == 3'h4; // @[ID.scala 115:14]
  wire [31:0] _imm_data_T_4 = _imm_data_T_3 ? ext_o26 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _imm_data_T_5 = _imm_data_T_2 ? ext_o16 : _imm_data_T_4; // @[Mux.scala 101:16]
  wire [31:0] _imm_data_T_6 = _imm_data_T_1 ? ext_si20 : _imm_data_T_5; // @[Mux.scala 101:16]
  wire [31:0] imm_data = _imm_data_T ? ext_si12 : _imm_data_T_6; // @[Mux.scala 101:16]
  wire  _op2_data_T = csignals_4 == 2'h1; // @[ID.scala 120:18]
  wire  _op2_data_T_1 = csignals_4 == 2'h2; // @[ID.scala 121:18]
  wire  _op2_data_T_2 = csignals_4 == 2'h3; // @[ID.scala 122:18]
  wire [31:0] _op2_data_T_3 = _op2_data_T_2 ? 32'h4 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _op2_data_T_4 = _op2_data_T_1 ? imm_data : _op2_data_T_3; // @[Mux.scala 101:16]
  wire [31:0] op2_data = _op2_data_T ? data2 : _op2_data_T_4; // @[Mux.scala 101:16]
  wire  _wMemData_T = csignals_7 == 2'h1; // @[ID.scala 126:21]
  wire [31:0] _wMemData_T_1 = regfile_wMemData_MPORT_1_data & 32'hff; // @[ID.scala 126:56]
  wire  _wMemData_T_2 = csignals_7 == 2'h2; // @[ID.scala 127:21]
  wire [31:0] _wMemData_T_3 = regfile_wMemData_MPORT_2_data & 32'hffff; // @[ID.scala 127:56]
  wire [31:0] _wMemData_T_4 = _wMemData_T_2 ? _wMemData_T_3 : regfile_wMemData_MPORT_data; // @[Mux.scala 101:16]
  wire  _branchFlag_T = csignals_0 == 4'h4; // @[ID.scala 136:18]
  wire  _branchFlag_T_1 = op1_data == op2_data; // @[ID.scala 136:45]
  wire  _branchFlag_T_2 = csignals_0 == 4'h5; // @[ID.scala 137:18]
  wire [31:0] _branchFlag_T_3 = _op1_data_T ? data1 : _op1_data_T_2; // @[ID.scala 137:51]
  wire [31:0] _branchFlag_T_4 = _op2_data_T ? data2 : _op2_data_T_4; // @[ID.scala 137:73]
  wire  _branchFlag_T_5 = $signed(_branchFlag_T_3) == $signed(_branchFlag_T_4); // @[ID.scala 137:54]
  wire  _branchFlag_T_6 = csignals_0 == 4'h6; // @[ID.scala 138:18]
  wire  _branchFlag_T_7 = op1_data < op2_data; // @[ID.scala 138:45]
  wire  _branchFlag_T_8 = csignals_0 == 4'h7; // @[ID.scala 139:18]
  wire  _branchFlag_T_9 = csignals_0 == 4'h8; // @[ID.scala 140:18]
  wire  _branchFlag_T_12 = _branchFlag_T_6 ? _branchFlag_T_7 : _branchFlag_T_8 | _branchFlag_T_9; // @[Mux.scala 101:16]
  wire  _branchFlag_T_13 = _branchFlag_T_2 ? _branchFlag_T_5 : _branchFlag_T_12; // @[Mux.scala 101:16]
  wire [31:0] _branchTarge_T_1 = _branchFlag_T_9 ? data1 : io_PC_ID; // @[Mux.scala 101:16]
  assign regfile_data1_MPORT_en = 1'h1;
  assign regfile_data1_MPORT_addr = csignals_1 ? rj_addr : 5'h0;
  assign regfile_data1_MPORT_data = regfile[regfile_data1_MPORT_addr]; // @[ID.scala 37:22]
  assign regfile_data2_MPORT_en = 1'h1;
  assign regfile_data2_MPORT_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_data2_MPORT_data = regfile[regfile_data2_MPORT_addr]; // @[ID.scala 37:22]
  assign regfile_wMemData_MPORT_en = 1'h1;
  assign regfile_wMemData_MPORT_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_wMemData_MPORT_data = regfile[regfile_wMemData_MPORT_addr]; // @[ID.scala 37:22]
  assign regfile_wMemData_MPORT_1_en = 1'h1;
  assign regfile_wMemData_MPORT_1_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_wMemData_MPORT_1_data = regfile[regfile_wMemData_MPORT_1_addr]; // @[ID.scala 37:22]
  assign regfile_wMemData_MPORT_2_en = 1'h1;
  assign regfile_wMemData_MPORT_2_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_wMemData_MPORT_2_data = regfile[regfile_wMemData_MPORT_2_addr]; // @[ID.scala 37:22]
  assign regfile_MPORT_data = io_wRegData_WB;
  assign regfile_MPORT_addr = io_wRegaddr_WB;
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = io_wReg_ctrl_uWB_WB;
  assign io_data1_ID = _op1_data_T ? data1 : _op1_data_T_2; // @[Mux.scala 101:16]
  assign io_data2_ID = _op2_data_T ? data2 : _op2_data_T_4; // @[Mux.scala 101:16]
  assign io_wRegAddr_ID = _wb_addr_T ? 5'h1 : _wb_addr_T_2; // @[Mux.scala 101:16]
  assign io_wMemData_ID = _wMemData_T ? _wMemData_T_1 : _wMemData_T_4; // @[Mux.scala 101:16]
  assign io_branchTarge_ID = _branchTarge_T_1 + imm_data; // @[ID.scala 148:8]
  assign io_branchFlag_ID = _branchFlag_T ? _branchFlag_T_1 : _branchFlag_T_13; // @[Mux.scala 101:16]
  assign io_stallReqOfID_ID = stall_case1 | stall_case2; // @[ID.scala 53:33]
  assign io_flushReqOfID_ID = _branchFlag_T ? _branchFlag_T_1 : _branchFlag_T_13; // @[Mux.scala 101:16]
  assign io_weReg_ctrl_uWB_ID = _csignals_T_1 | (_csignals_T_3 | (_csignals_T_5 | (_csignals_T_7 | (_csignals_T_9 | (
    _csignals_T_11 | (_csignals_T_13 | _csignals_T_216)))))); // @[Lookup.scala 34:39]
  assign io_memReadDataExt_ctrl_uMEM_ID = _csignals_T_1 ? 1'h0 : _csignals_T_239; // @[Lookup.scala 34:39]
  assign io_wrMemByteSelScr_ctrl_uMEM_ID = _csignals_T_1 ? 2'h0 : _csignals_T_154; // @[Lookup.scala 34:39]
  assign io_wRegDataSrc_ctrl_uMEM_ID = _csignals_T_1 ? 1'h0 : _csignals_T_239; // @[Lookup.scala 34:39]
  assign io_weMEM_ctrl_uMEM_ID = _csignals_T_1 ? 1'h0 : _csignals_T_205; // @[Lookup.scala 34:39]
  assign io_aluOP_ctrl_uEXE_ID = _csignals_T_1 ? 4'h1 : _csignals_T_52; // @[Lookup.scala 34:39]
  always @(posedge clock) begin
    if (regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[ID.scala 37:22]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"io.instr_ID value is %b\n",io_instr_ID); // @[ID.scala 54:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"operate value is %b\n",csignals_0); // @[ID.scala 79:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"raddr1_f value is %b\n",csignals_1); // @[ID.scala 80:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"imm_data value is %b\n",imm_data); // @[ID.scala 117:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"data2_f value is %b\n",csignals_4); // @[ID.scala 118:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"op2_data value is %b\n",op2_data); // @[ID.scala 124:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

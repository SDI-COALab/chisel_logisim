module IF(
  input         clock,
  input         reset,
  input         io_stallStageIF,
  input  [31:0] io_branchTarget_ID,
  input         io_branchFlag_ID,
  input         io_reset,
  output [31:0] io_PC_IF,
  output [31:0] io_instr_IF
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem [0:127]; // @[IF.scala 22:18]
  wire  mem_instr_IF_MPORT_en; // @[IF.scala 22:18]
  wire [6:0] mem_instr_IF_MPORT_addr; // @[IF.scala 22:18]
  wire [7:0] mem_instr_IF_MPORT_data; // @[IF.scala 22:18]
  wire  mem_instr_IF_MPORT_1_en; // @[IF.scala 22:18]
  wire [6:0] mem_instr_IF_MPORT_1_addr; // @[IF.scala 22:18]
  wire [7:0] mem_instr_IF_MPORT_1_data; // @[IF.scala 22:18]
  wire  mem_instr_IF_MPORT_2_en; // @[IF.scala 22:18]
  wire [6:0] mem_instr_IF_MPORT_2_addr; // @[IF.scala 22:18]
  wire [7:0] mem_instr_IF_MPORT_2_data; // @[IF.scala 22:18]
  wire  mem_instr_IF_MPORT_3_en; // @[IF.scala 22:18]
  wire [6:0] mem_instr_IF_MPORT_3_addr; // @[IF.scala 22:18]
  wire [7:0] mem_instr_IF_MPORT_3_data; // @[IF.scala 22:18]
  reg [31:0] PC; // @[IF.scala 24:21]
  reg [31:0] nextPC; // @[IF.scala 25:25]
  wire [31:0] PC_next = PC + 32'h4; // @[IF.scala 28:25]
  wire [31:0] _instr_IF_T_1 = PC + 32'h3; // @[IF.scala 39:31]
  wire [31:0] _instr_IF_T_4 = PC + 32'h2; // @[IF.scala 39:58]
  wire [31:0] _instr_IF_T_7 = PC + 32'h1; // @[IF.scala 39:85]
  wire [15:0] instr_IF_lo = {mem_instr_IF_MPORT_2_data,mem_instr_IF_MPORT_3_data}; // @[Cat.scala 31:58]
  wire [15:0] instr_IF_hi = {mem_instr_IF_MPORT_data,mem_instr_IF_MPORT_1_data}; // @[Cat.scala 31:58]
  assign mem_instr_IF_MPORT_en = 1'h1;
  assign mem_instr_IF_MPORT_addr = _instr_IF_T_1[6:0];
  assign mem_instr_IF_MPORT_data = mem[mem_instr_IF_MPORT_addr]; // @[IF.scala 22:18]
  assign mem_instr_IF_MPORT_1_en = 1'h1;
  assign mem_instr_IF_MPORT_1_addr = _instr_IF_T_4[6:0];
  assign mem_instr_IF_MPORT_1_data = mem[mem_instr_IF_MPORT_1_addr]; // @[IF.scala 22:18]
  assign mem_instr_IF_MPORT_2_en = 1'h1;
  assign mem_instr_IF_MPORT_2_addr = _instr_IF_T_7[6:0];
  assign mem_instr_IF_MPORT_2_data = mem[mem_instr_IF_MPORT_2_addr]; // @[IF.scala 22:18]
  assign mem_instr_IF_MPORT_3_en = 1'h1;
  assign mem_instr_IF_MPORT_3_addr = PC[6:0];
  assign mem_instr_IF_MPORT_3_data = mem[mem_instr_IF_MPORT_3_addr]; // @[IF.scala 22:18]
  assign io_PC_IF = PC; // @[IF.scala 41:14]
  assign io_instr_IF = {instr_IF_hi,instr_IF_lo}; // @[Cat.scala 31:58]
  always @(posedge clock) begin
    if (reset) begin // @[IF.scala 24:21]
      PC <= 32'h0; // @[IF.scala 24:21]
    end else if (!(io_stallStageIF)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        PC <= 32'h0;
      end else if (io_branchFlag_ID) begin // @[Mux.scala 101:16]
        PC <= io_branchTarget_ID;
      end else begin
        PC <= nextPC;
      end
    end
    if (reset) begin // @[IF.scala 25:25]
      nextPC <= 32'h0; // @[IF.scala 25:25]
    end else if (io_branchFlag_ID) begin // @[Mux.scala 101:16]
      nextPC <= io_branchTarget_ID;
    end else begin
      nextPC <= PC_next;
    end
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
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  PC = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  nextPC = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IF_ID(
  input         clock,
  input         reset,
  input  [31:0] io_PC_IF,
  input  [31:0] io_instr_IF,
  input         io_flushStageID,
  input         io_stallStageID,
  input         io_reset,
  output [31:0] io_PC_ID,
  output [31:0] io_instr_ID
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] PC_ID_reg; // @[IF_ID.scala 18:28]
  reg [31:0] instr_ID_reg; // @[IF_ID.scala 19:31]
  assign io_PC_ID = PC_ID_reg; // @[IF_ID.scala 37:14]
  assign io_instr_ID = instr_ID_reg; // @[IF_ID.scala 38:17]
  always @(posedge clock) begin
    if (reset) begin // @[IF_ID.scala 18:28]
      PC_ID_reg <= 32'h0; // @[IF_ID.scala 18:28]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        PC_ID_reg <= 32'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        PC_ID_reg <= 32'h0;
      end else begin
        PC_ID_reg <= io_PC_IF;
      end
    end
    if (reset) begin // @[IF_ID.scala 19:31]
      instr_ID_reg <= 32'h0; // @[IF_ID.scala 19:31]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        instr_ID_reg <= 32'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        instr_ID_reg <= 32'h0;
      end else begin
        instr_ID_reg <= io_instr_IF;
      end
    end
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  PC_ID_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  instr_ID_reg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ID(
  input         clock,
  input         reset,
  input  [31:0] io_PC_ID,
  input  [31:0] io_instr_ID,
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
  reg [31:0] regfile [0:31]; // @[ID.scala 35:22]
  wire  regfile_data1_MPORT_en; // @[ID.scala 35:22]
  wire [4:0] regfile_data1_MPORT_addr; // @[ID.scala 35:22]
  wire [31:0] regfile_data1_MPORT_data; // @[ID.scala 35:22]
  wire  regfile_data2_MPORT_en; // @[ID.scala 35:22]
  wire [4:0] regfile_data2_MPORT_addr; // @[ID.scala 35:22]
  wire [31:0] regfile_data2_MPORT_data; // @[ID.scala 35:22]
  wire  regfile_wMemData_MPORT_en; // @[ID.scala 35:22]
  wire [4:0] regfile_wMemData_MPORT_addr; // @[ID.scala 35:22]
  wire [31:0] regfile_wMemData_MPORT_data; // @[ID.scala 35:22]
  wire  regfile_wMemData_MPORT_1_en; // @[ID.scala 35:22]
  wire [4:0] regfile_wMemData_MPORT_1_addr; // @[ID.scala 35:22]
  wire [31:0] regfile_wMemData_MPORT_1_data; // @[ID.scala 35:22]
  wire  regfile_wMemData_MPORT_2_en; // @[ID.scala 35:22]
  wire [4:0] regfile_wMemData_MPORT_2_addr; // @[ID.scala 35:22]
  wire [31:0] regfile_wMemData_MPORT_2_data; // @[ID.scala 35:22]
  wire [31:0] regfile_MPORT_data; // @[ID.scala 35:22]
  wire [4:0] regfile_MPORT_addr; // @[ID.scala 35:22]
  wire  regfile_MPORT_mask; // @[ID.scala 35:22]
  wire  regfile_MPORT_en; // @[ID.scala 35:22]
  wire [11:0] si12 = io_instr_ID[21:10]; // @[ID.scala 37:27]
  wire [19:0] _ext_si12_T_2 = si12[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] ext_si12 = {_ext_si12_T_2,si12}; // @[Cat.scala 31:58]
  wire [15:0] o16 = io_instr_ID[25:10]; // @[ID.scala 39:26]
  wire [13:0] _ext_o16_T_2 = o16[15] ? 14'h3fff : 14'h0; // @[Bitwise.scala 74:12]
  wire [31:0] ext_o16 = {_ext_o16_T_2,o16,2'h0}; // @[Cat.scala 31:58]
  wire [19:0] si20 = io_instr_ID[24:5]; // @[ID.scala 41:27]
  wire [31:0] ext_si20 = {si20,12'h0}; // @[Cat.scala 31:58]
  wire [25:0] o26 = {io_instr_ID[9:0],o16}; // @[Cat.scala 31:58]
  wire [3:0] _ext_o26_T_2 = o26[25] ? 4'hf : 4'h0; // @[Bitwise.scala 74:12]
  wire [31:0] ext_o26 = {_ext_o26_T_2,io_instr_ID[9:0],o16,2'h0}; // @[Cat.scala 31:58]
  wire [4:0] rj_addr = io_instr_ID[9:5]; // @[ID.scala 45:30]
  wire [4:0] rk_addr = io_instr_ID[14:10]; // @[ID.scala 46:30]
  wire [4:0] rd_addr = io_instr_ID[4:0]; // @[ID.scala 48:30]
  wire  stall_case1 = io_wReg_ctrl_uWB_WB & rj_addr != 5'h0 & rj_addr == io_wRegAddr_EXE; // @[ID.scala 49:75]
  wire  stall_case2 = io_wReg_ctrl_uWB_WB & rk_addr != 5'h0 & rk_addr == io_wRegAddr_EXE; // @[ID.scala 50:75]
  wire  _T_1 = ~reset; // @[ID.scala 52:11]
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
  wire  _raddr_2_T = csignals_2 == 2'h1; // @[ID.scala 83:19]
  wire  _raddr_2_T_1 = csignals_2 == 2'h2; // @[ID.scala 84:19]
  wire  _raddr_2_T_2 = csignals_2 == 2'h3; // @[ID.scala 85:19]
  wire [4:0] _raddr_2_T_3 = _raddr_2_T_2 ? rk_addr : 5'h0; // @[Mux.scala 101:16]
  wire [4:0] _raddr_2_T_4 = _raddr_2_T_1 ? rd_addr : _raddr_2_T_3; // @[Mux.scala 101:16]
  wire [4:0] raddr_2 = _raddr_2_T ? rk_addr : _raddr_2_T_4; // @[Mux.scala 101:16]
  wire  _wb_addr_T = csignals_5 == 2'h1; // @[ID.scala 89:15]
  wire  _wb_addr_T_1 = csignals_5 == 2'h2; // @[ID.scala 90:15]
  wire [4:0] _wb_addr_T_2 = _wb_addr_T_1 ? rd_addr : 5'h0; // @[Mux.scala 101:16]
  wire  _data1_T_2 = raddr_1 == io_wRegAddr_MEM & io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 94:40]
  wire  _data1_T_4 = ~io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 95:73]
  wire  _data1_T_5 = raddr_1 == io_wRegAddr_EXE & ~io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 95:40]
  wire  _data1_T_8 = raddr_1 == io_wRegaddr_WB & io_wReg_ctrl_uWB_WB; // @[ID.scala 96:40]
  wire [31:0] _data1_T_9 = _data1_T_8 ? io_wRegData_WB : regfile_data1_MPORT_data; // @[Mux.scala 101:16]
  wire [31:0] _data1_T_10 = _data1_T_5 ? io_aluResult_EXE : _data1_T_9; // @[Mux.scala 101:16]
  wire [31:0] data1 = _data1_T_2 ? io_wRegData_MEM : _data1_T_10; // @[Mux.scala 101:16]
  wire  _data2_T_2 = raddr_2 == io_wRegAddr_MEM & io_wRegDataSrc_ctrl_uMEM_EXE; // @[ID.scala 100:40]
  wire  _data2_T_5 = raddr_2 == io_wRegAddr_EXE & _data1_T_4; // @[ID.scala 101:40]
  wire  _data2_T_8 = raddr_2 == io_wRegaddr_WB & io_wReg_ctrl_uWB_WB; // @[ID.scala 102:40]
  wire [31:0] _data2_T_9 = _data2_T_8 ? io_wRegData_WB : regfile_data2_MPORT_data; // @[Mux.scala 101:16]
  wire [31:0] _data2_T_10 = _data2_T_5 ? io_aluResult_EXE : _data2_T_9; // @[Mux.scala 101:16]
  wire [31:0] data2 = _data2_T_2 ? io_wRegData_MEM : _data2_T_10; // @[Mux.scala 101:16]
  wire  _op1_data_T = csignals_3 == 2'h1; // @[ID.scala 106:18]
  wire  _op1_data_T_1 = csignals_3 == 2'h2; // @[ID.scala 107:18]
  wire [31:0] _op1_data_T_2 = _op1_data_T_1 ? io_PC_ID : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] op1_data = _op1_data_T ? data1 : _op1_data_T_2; // @[Mux.scala 101:16]
  wire  _imm_data_T = csignals_8 == 3'h1; // @[ID.scala 110:14]
  wire  _imm_data_T_1 = csignals_8 == 3'h2; // @[ID.scala 111:14]
  wire  _imm_data_T_2 = csignals_8 == 3'h3; // @[ID.scala 112:14]
  wire  _imm_data_T_3 = csignals_8 == 3'h4; // @[ID.scala 113:14]
  wire [31:0] _imm_data_T_4 = _imm_data_T_3 ? ext_o26 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _imm_data_T_5 = _imm_data_T_2 ? ext_o16 : _imm_data_T_4; // @[Mux.scala 101:16]
  wire [31:0] _imm_data_T_6 = _imm_data_T_1 ? ext_si20 : _imm_data_T_5; // @[Mux.scala 101:16]
  wire [31:0] imm_data = _imm_data_T ? ext_si12 : _imm_data_T_6; // @[Mux.scala 101:16]
  wire  _op2_data_T = csignals_4 == 2'h1; // @[ID.scala 118:18]
  wire  _op2_data_T_1 = csignals_4 == 2'h2; // @[ID.scala 119:18]
  wire  _op2_data_T_2 = csignals_4 == 2'h3; // @[ID.scala 120:18]
  wire [31:0] _op2_data_T_3 = _op2_data_T_2 ? 32'h4 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _op2_data_T_4 = _op2_data_T_1 ? imm_data : _op2_data_T_3; // @[Mux.scala 101:16]
  wire [31:0] op2_data = _op2_data_T ? data2 : _op2_data_T_4; // @[Mux.scala 101:16]
  wire  _wMemData_T = csignals_7 == 2'h1; // @[ID.scala 124:21]
  wire [31:0] _wMemData_T_1 = regfile_wMemData_MPORT_1_data & 32'hff; // @[ID.scala 124:56]
  wire  _wMemData_T_2 = csignals_7 == 2'h2; // @[ID.scala 125:21]
  wire [31:0] _wMemData_T_3 = regfile_wMemData_MPORT_2_data & 32'hffff; // @[ID.scala 125:56]
  wire [31:0] _wMemData_T_4 = _wMemData_T_2 ? _wMemData_T_3 : regfile_wMemData_MPORT_data; // @[Mux.scala 101:16]
  wire  _branchFlag_T = csignals_0 == 4'h4; // @[ID.scala 134:18]
  wire  _branchFlag_T_1 = op1_data == op2_data; // @[ID.scala 134:45]
  wire  _branchFlag_T_2 = csignals_0 == 4'h5; // @[ID.scala 135:18]
  wire [31:0] _branchFlag_T_3 = _op1_data_T ? data1 : _op1_data_T_2; // @[ID.scala 135:51]
  wire [31:0] _branchFlag_T_4 = _op2_data_T ? data2 : _op2_data_T_4; // @[ID.scala 135:73]
  wire  _branchFlag_T_5 = $signed(_branchFlag_T_3) == $signed(_branchFlag_T_4); // @[ID.scala 135:54]
  wire  _branchFlag_T_6 = csignals_0 == 4'h6; // @[ID.scala 136:18]
  wire  _branchFlag_T_7 = op1_data < op2_data; // @[ID.scala 136:45]
  wire  _branchFlag_T_8 = csignals_0 == 4'h7; // @[ID.scala 137:18]
  wire  _branchFlag_T_9 = csignals_0 == 4'h8; // @[ID.scala 138:18]
  wire  _branchFlag_T_12 = _branchFlag_T_6 ? _branchFlag_T_7 : _branchFlag_T_8 | _branchFlag_T_9; // @[Mux.scala 101:16]
  wire  _branchFlag_T_13 = _branchFlag_T_2 ? _branchFlag_T_5 : _branchFlag_T_12; // @[Mux.scala 101:16]
  wire [31:0] _branchTarge_T_1 = _branchFlag_T_9 ? data1 : io_PC_ID; // @[Mux.scala 101:16]
  assign regfile_data1_MPORT_en = 1'h1;
  assign regfile_data1_MPORT_addr = csignals_1 ? rj_addr : 5'h0;
  assign regfile_data1_MPORT_data = regfile[regfile_data1_MPORT_addr]; // @[ID.scala 35:22]
  assign regfile_data2_MPORT_en = 1'h1;
  assign regfile_data2_MPORT_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_data2_MPORT_data = regfile[regfile_data2_MPORT_addr]; // @[ID.scala 35:22]
  assign regfile_wMemData_MPORT_en = 1'h1;
  assign regfile_wMemData_MPORT_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_wMemData_MPORT_data = regfile[regfile_wMemData_MPORT_addr]; // @[ID.scala 35:22]
  assign regfile_wMemData_MPORT_1_en = 1'h1;
  assign regfile_wMemData_MPORT_1_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_wMemData_MPORT_1_data = regfile[regfile_wMemData_MPORT_1_addr]; // @[ID.scala 35:22]
  assign regfile_wMemData_MPORT_2_en = 1'h1;
  assign regfile_wMemData_MPORT_2_addr = _raddr_2_T ? rk_addr : _raddr_2_T_4;
  assign regfile_wMemData_MPORT_2_data = regfile[regfile_wMemData_MPORT_2_addr]; // @[ID.scala 35:22]
  assign regfile_MPORT_data = io_wRegData_WB;
  assign regfile_MPORT_addr = io_wRegaddr_WB;
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = io_wReg_ctrl_uWB_WB;
  assign io_data1_ID = _op1_data_T ? data1 : _op1_data_T_2; // @[Mux.scala 101:16]
  assign io_data2_ID = _op2_data_T ? data2 : _op2_data_T_4; // @[Mux.scala 101:16]
  assign io_wRegAddr_ID = _wb_addr_T ? 5'h1 : _wb_addr_T_2; // @[Mux.scala 101:16]
  assign io_wMemData_ID = _wMemData_T ? _wMemData_T_1 : _wMemData_T_4; // @[Mux.scala 101:16]
  assign io_branchTarge_ID = _branchTarge_T_1 + imm_data; // @[ID.scala 146:8]
  assign io_branchFlag_ID = _branchFlag_T ? _branchFlag_T_1 : _branchFlag_T_13; // @[Mux.scala 101:16]
  assign io_stallReqOfID_ID = stall_case1 | stall_case2; // @[ID.scala 51:33]
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
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[ID.scala 35:22]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"io.instr_ID value is %b\n",io_instr_ID); // @[ID.scala 52:11]
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
          $fwrite(32'h80000002,"operate value is %b\n",csignals_0); // @[ID.scala 77:11]
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
          $fwrite(32'h80000002,"raddr1_f value is %b\n",csignals_1); // @[ID.scala 78:11]
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
          $fwrite(32'h80000002,"imm_data value is %b\n",imm_data); // @[ID.scala 115:11]
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
          $fwrite(32'h80000002,"data2_f value is %b\n",csignals_4); // @[ID.scala 116:11]
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
          $fwrite(32'h80000002,"op2_data value is %b\n",op2_data); // @[ID.scala 122:11]
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
module ID_EXE(
  input         clock,
  input         reset,
  input         io_flushStageID,
  input         io_reset,
  input  [3:0]  io_aluOP_ctrl_uEXE_ID,
  input  [31:0] io_data1_ID,
  input  [31:0] io_data2_ID,
  input  [4:0]  io_wRegAddr_ID,
  input  [31:0] io_wMemData_ID,
  input         io_weMEM_ctrl_uMEM_ID,
  input         io_wRegDataSrc_ctrl_uMEM_ID,
  input  [1:0]  io_wrMemByteSelScr_ctrl_uMEM_ID,
  input         io_memReadDataExt_ctrl_uMEM_ID,
  input         io_weReg_ctrl_uWB_ID,
  output [3:0]  io_aluOP_ctrl_uID_EXE,
  output [31:0] io_data1_EXE,
  output [31:0] io_data2_EXE,
  output [4:0]  io_wRegAddr_EXE,
  output [31:0] io_wMenData_EXE,
  output        io_weMEM_ctrl_uMEM_EXE,
  output        io_wRegDataSrc_ctrl_uMEM_EXE,
  output [1:0]  io_wrMemByteSelScr_ctrl_uMEM_EXE,
  output        io_memReadDataExt_ctrl_uMEM_EXE,
  output        io_weReg_ctrl_uWB_EXE
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] aluOP_ctrl_uEXE_ID; // @[ID_EXE.scala 35:35]
  reg [31:0] data1_ID; // @[ID_EXE.scala 36:25]
  reg [31:0] data2_ID; // @[ID_EXE.scala 37:25]
  reg [4:0] wRegAddr_ID; // @[ID_EXE.scala 38:28]
  reg [31:0] wMemData_ID; // @[ID_EXE.scala 39:28]
  reg  weMEM_ctrl_uMEM_ID; // @[ID_EXE.scala 40:35]
  reg  wRegDataSrc_ctrl_uMEM_ID; // @[ID_EXE.scala 41:41]
  reg [1:0] wrMemByteSelScr_ctrl_uMEM_ID; // @[ID_EXE.scala 42:45]
  reg  memReadDataExt_ctrl_uMEM_ID; // @[ID_EXE.scala 43:44]
  reg  weReg_ctrl_uWB_ID; // @[ID_EXE.scala 44:34]
  assign io_aluOP_ctrl_uID_EXE = aluOP_ctrl_uEXE_ID; // @[ID_EXE.scala 96:25]
  assign io_data1_EXE = data1_ID; // @[ID_EXE.scala 97:16]
  assign io_data2_EXE = data2_ID; // @[ID_EXE.scala 98:16]
  assign io_wRegAddr_EXE = wRegAddr_ID; // @[ID_EXE.scala 99:19]
  assign io_wMenData_EXE = wMemData_ID; // @[ID_EXE.scala 100:19]
  assign io_weMEM_ctrl_uMEM_EXE = weMEM_ctrl_uMEM_ID; // @[ID_EXE.scala 101:26]
  assign io_wRegDataSrc_ctrl_uMEM_EXE = wRegDataSrc_ctrl_uMEM_ID; // @[ID_EXE.scala 102:32]
  assign io_wrMemByteSelScr_ctrl_uMEM_EXE = wrMemByteSelScr_ctrl_uMEM_ID; // @[ID_EXE.scala 103:36]
  assign io_memReadDataExt_ctrl_uMEM_EXE = memReadDataExt_ctrl_uMEM_ID; // @[ID_EXE.scala 104:35]
  assign io_weReg_ctrl_uWB_EXE = weReg_ctrl_uWB_ID; // @[ID_EXE.scala 105:25]
  always @(posedge clock) begin
    if (reset) begin // @[ID_EXE.scala 35:35]
      aluOP_ctrl_uEXE_ID <= 4'h0; // @[ID_EXE.scala 35:35]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      aluOP_ctrl_uEXE_ID <= 4'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      aluOP_ctrl_uEXE_ID <= 4'h0;
    end else begin
      aluOP_ctrl_uEXE_ID <= io_aluOP_ctrl_uEXE_ID;
    end
    if (reset) begin // @[ID_EXE.scala 36:25]
      data1_ID <= 32'h0; // @[ID_EXE.scala 36:25]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      data1_ID <= 32'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      data1_ID <= 32'h0;
    end else begin
      data1_ID <= io_data1_ID;
    end
    if (reset) begin // @[ID_EXE.scala 37:25]
      data2_ID <= 32'h0; // @[ID_EXE.scala 37:25]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      data2_ID <= 32'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      data2_ID <= 32'h0;
    end else begin
      data2_ID <= io_data2_ID;
    end
    if (reset) begin // @[ID_EXE.scala 38:28]
      wRegAddr_ID <= 5'h0; // @[ID_EXE.scala 38:28]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wRegAddr_ID <= 5'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      wRegAddr_ID <= 5'h0;
    end else begin
      wRegAddr_ID <= io_wRegAddr_ID;
    end
    if (reset) begin // @[ID_EXE.scala 39:28]
      wMemData_ID <= 32'h0; // @[ID_EXE.scala 39:28]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wMemData_ID <= 32'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      wMemData_ID <= 32'h0;
    end else begin
      wMemData_ID <= io_wMemData_ID;
    end
    if (reset) begin // @[ID_EXE.scala 40:35]
      weMEM_ctrl_uMEM_ID <= 1'h0; // @[ID_EXE.scala 40:35]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      weMEM_ctrl_uMEM_ID <= 1'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      weMEM_ctrl_uMEM_ID <= 1'h0;
    end else begin
      weMEM_ctrl_uMEM_ID <= io_weMEM_ctrl_uMEM_ID;
    end
    if (reset) begin // @[ID_EXE.scala 41:41]
      wRegDataSrc_ctrl_uMEM_ID <= 1'h0; // @[ID_EXE.scala 41:41]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wRegDataSrc_ctrl_uMEM_ID <= 1'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      wRegDataSrc_ctrl_uMEM_ID <= 1'h0;
    end else begin
      wRegDataSrc_ctrl_uMEM_ID <= io_wRegDataSrc_ctrl_uMEM_ID;
    end
    if (reset) begin // @[ID_EXE.scala 42:45]
      wrMemByteSelScr_ctrl_uMEM_ID <= 2'h0; // @[ID_EXE.scala 42:45]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wrMemByteSelScr_ctrl_uMEM_ID <= 2'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      wrMemByteSelScr_ctrl_uMEM_ID <= 2'h0;
    end else begin
      wrMemByteSelScr_ctrl_uMEM_ID <= io_wrMemByteSelScr_ctrl_uMEM_ID;
    end
    if (reset) begin // @[ID_EXE.scala 43:44]
      memReadDataExt_ctrl_uMEM_ID <= 1'h0; // @[ID_EXE.scala 43:44]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      memReadDataExt_ctrl_uMEM_ID <= 1'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      memReadDataExt_ctrl_uMEM_ID <= 1'h0;
    end else begin
      memReadDataExt_ctrl_uMEM_ID <= io_memReadDataExt_ctrl_uMEM_ID;
    end
    if (reset) begin // @[ID_EXE.scala 44:34]
      weReg_ctrl_uWB_ID <= 1'h0; // @[ID_EXE.scala 44:34]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      weReg_ctrl_uWB_ID <= 1'h0;
    end else if (io_flushStageID) begin // @[Mux.scala 101:16]
      weReg_ctrl_uWB_ID <= 1'h0;
    end else begin
      weReg_ctrl_uWB_ID <= io_weReg_ctrl_uWB_ID;
    end
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  aluOP_ctrl_uEXE_ID = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  data1_ID = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  data2_ID = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  wRegAddr_ID = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  wMemData_ID = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  weMEM_ctrl_uMEM_ID = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  wRegDataSrc_ctrl_uMEM_ID = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  wrMemByteSelScr_ctrl_uMEM_ID = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  memReadDataExt_ctrl_uMEM_ID = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  weReg_ctrl_uWB_ID = _RAND_9[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EXE(
  input  [3:0]  io_aluOP_ctrl_uEXE_EXE,
  input  [31:0] io_data1_EXE,
  input  [31:0] io_data2_EXE,
  output [31:0] io_aluResult_EXE
);
  wire  _exe_alu_out_T = io_aluOP_ctrl_uEXE_EXE == 4'h1; // @[EXE.scala 15:29]
  wire [31:0] _exe_alu_out_T_2 = io_data1_EXE + io_data2_EXE; // @[EXE.scala 15:60]
  wire  _exe_alu_out_T_3 = io_aluOP_ctrl_uEXE_EXE == 4'h2; // @[EXE.scala 16:29]
  wire [31:0] _exe_alu_out_T_5 = io_data1_EXE >> io_data2_EXE[4:0]; // @[EXE.scala 16:60]
  wire  _exe_alu_out_T_6 = io_aluOP_ctrl_uEXE_EXE == 4'h3; // @[EXE.scala 17:29]
  wire [31:0] _exe_alu_out_T_10 = $signed(io_data1_EXE) >>> io_data2_EXE[4:0]; // @[EXE.scala 17:97]
  wire  _exe_alu_out_T_11 = io_aluOP_ctrl_uEXE_EXE == 4'h9; // @[EXE.scala 18:29]
  wire  _exe_alu_out_T_14 = $signed(io_data1_EXE) < $signed(io_data2_EXE); // @[EXE.scala 18:69]
  wire [31:0] _exe_alu_out_T_15 = _exe_alu_out_T_11 ? {{31'd0}, _exe_alu_out_T_14} : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_out_T_16 = _exe_alu_out_T_6 ? _exe_alu_out_T_10 : _exe_alu_out_T_15; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_out_T_17 = _exe_alu_out_T_3 ? _exe_alu_out_T_5 : _exe_alu_out_T_16; // @[Mux.scala 101:16]
  assign io_aluResult_EXE = _exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_17; // @[Mux.scala 101:16]
endmodule
module EXE_MEM(
  input         clock,
  input         reset,
  input  [31:0] io_aluResult_EXE,
  input  [4:0]  io_wRegAddr_EXE,
  input  [31:0] io_wMenData_EXE,
  input         io_weMEM_ctrl_uMEM_EXE,
  input         io_wRegDataSrc_ctrl_uMEM_EXE,
  input  [1:0]  io_wrMemByteSelScr_ctrl_uMEM_EXE,
  input         io_memReadDataExt_ctrl_uMEM_EXE,
  input         io_weReg_ctrl_uWB_EXE,
  output [31:0] io_aluResult_MEM,
  output [4:0]  io_wRegAddr_MEM,
  output [31:0] io_wMemData_MEM,
  output        io_weMEM_ctrl_uMEM_MEM,
  output        io_wRegDataSrc_ctrl_uMEM_MEM,
  output [1:0]  io_wrMemByteSelScr_ctrl_uMEM_MEM,
  output        io_memReadDataExt_ctrl_uMEM_MEM,
  output        io_weReg_ctrl_uWB_MEM,
  input         io_reset
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] aluResult_MEM; // @[EXE_MEM.scala 29:32]
  reg [4:0] wRegAddr_MEM; // @[EXE_MEM.scala 30:31]
  reg [31:0] wMemData_MEM; // @[EXE_MEM.scala 31:31]
  reg  weMEM_ctrl_uMEM_MEM; // @[EXE_MEM.scala 32:38]
  reg  wRegDataSrc_ctrl_uMEM_MEM; // @[EXE_MEM.scala 33:44]
  reg [1:0] wrMemByteSelScr_ctrl_uMEM_MEM; // @[EXE_MEM.scala 34:48]
  reg  memReadDataExt_ctrl_uMEM_MEM; // @[EXE_MEM.scala 35:47]
  reg  weReg_ctrl_uWB_MEM; // @[EXE_MEM.scala 36:37]
  assign io_aluResult_MEM = aluResult_MEM; // @[EXE_MEM.scala 80:22]
  assign io_wRegAddr_MEM = wRegAddr_MEM; // @[EXE_MEM.scala 81:21]
  assign io_wMemData_MEM = wMemData_MEM; // @[EXE_MEM.scala 82:21]
  assign io_weMEM_ctrl_uMEM_MEM = weMEM_ctrl_uMEM_MEM; // @[EXE_MEM.scala 83:28]
  assign io_wRegDataSrc_ctrl_uMEM_MEM = wRegDataSrc_ctrl_uMEM_MEM; // @[EXE_MEM.scala 84:34]
  assign io_wrMemByteSelScr_ctrl_uMEM_MEM = wrMemByteSelScr_ctrl_uMEM_MEM; // @[EXE_MEM.scala 85:38]
  assign io_memReadDataExt_ctrl_uMEM_MEM = memReadDataExt_ctrl_uMEM_MEM; // @[EXE_MEM.scala 86:37]
  assign io_weReg_ctrl_uWB_MEM = weReg_ctrl_uWB_MEM; // @[EXE_MEM.scala 87:27]
  always @(posedge clock) begin
    if (reset) begin // @[EXE_MEM.scala 29:32]
      aluResult_MEM <= 32'h0; // @[EXE_MEM.scala 29:32]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      aluResult_MEM <= 32'h0;
    end else begin
      aluResult_MEM <= io_aluResult_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 30:31]
      wRegAddr_MEM <= 5'h0; // @[EXE_MEM.scala 30:31]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wRegAddr_MEM <= 5'h0;
    end else begin
      wRegAddr_MEM <= io_wRegAddr_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 31:31]
      wMemData_MEM <= 32'h0; // @[EXE_MEM.scala 31:31]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wMemData_MEM <= 32'h0;
    end else begin
      wMemData_MEM <= io_wMenData_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 32:38]
      weMEM_ctrl_uMEM_MEM <= 1'h0; // @[EXE_MEM.scala 32:38]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      weMEM_ctrl_uMEM_MEM <= 1'h0;
    end else begin
      weMEM_ctrl_uMEM_MEM <= io_weMEM_ctrl_uMEM_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 33:44]
      wRegDataSrc_ctrl_uMEM_MEM <= 1'h0; // @[EXE_MEM.scala 33:44]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wRegDataSrc_ctrl_uMEM_MEM <= 1'h0;
    end else begin
      wRegDataSrc_ctrl_uMEM_MEM <= io_wRegDataSrc_ctrl_uMEM_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 34:48]
      wrMemByteSelScr_ctrl_uMEM_MEM <= 2'h0; // @[EXE_MEM.scala 34:48]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wrMemByteSelScr_ctrl_uMEM_MEM <= 2'h0;
    end else begin
      wrMemByteSelScr_ctrl_uMEM_MEM <= io_wrMemByteSelScr_ctrl_uMEM_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 35:47]
      memReadDataExt_ctrl_uMEM_MEM <= 1'h0; // @[EXE_MEM.scala 35:47]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      memReadDataExt_ctrl_uMEM_MEM <= 1'h0;
    end else begin
      memReadDataExt_ctrl_uMEM_MEM <= io_memReadDataExt_ctrl_uMEM_EXE;
    end
    if (reset) begin // @[EXE_MEM.scala 36:37]
      weReg_ctrl_uWB_MEM <= 1'h0; // @[EXE_MEM.scala 36:37]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      weReg_ctrl_uWB_MEM <= 1'h0;
    end else begin
      weReg_ctrl_uWB_MEM <= io_weReg_ctrl_uWB_EXE;
    end
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  aluResult_MEM = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  wRegAddr_MEM = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  wMemData_MEM = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  weMEM_ctrl_uMEM_MEM = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  wRegDataSrc_ctrl_uMEM_MEM = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  wrMemByteSelScr_ctrl_uMEM_MEM = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  memReadDataExt_ctrl_uMEM_MEM = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  weReg_ctrl_uWB_MEM = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM(
  input         clock,
  input         reset,
  input  [31:0] io_aluResult_MEM,
  input  [31:0] io_wMemData_MEM,
  input         io_weMEM_ctrl_uMEM_MEM,
  input         io_wRegDataSrc_ctrl_uMEM_MEM,
  input  [1:0]  io_wrMemByteSelScr_ctrl_uMEM_MEM,
  input         io_memReadDataExt_ctrl_uMEM_MEM,
  output [31:0] io_wRegData_MEM
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem [0:16383]; // @[MEM.scala 19:18]
  wire  mem_rdata0_en; // @[MEM.scala 19:18]
  wire [13:0] mem_rdata0_addr; // @[MEM.scala 19:18]
  wire [7:0] mem_rdata0_data; // @[MEM.scala 19:18]
  wire  mem_rdata1_en; // @[MEM.scala 19:18]
  wire [13:0] mem_rdata1_addr; // @[MEM.scala 19:18]
  wire [7:0] mem_rdata1_data; // @[MEM.scala 19:18]
  wire  mem_rdata2_en; // @[MEM.scala 19:18]
  wire [13:0] mem_rdata2_addr; // @[MEM.scala 19:18]
  wire [7:0] mem_rdata2_data; // @[MEM.scala 19:18]
  wire  mem_rdata3_en; // @[MEM.scala 19:18]
  wire [13:0] mem_rdata3_addr; // @[MEM.scala 19:18]
  wire [7:0] mem_rdata3_data; // @[MEM.scala 19:18]
  wire [7:0] mem_MPORT_data; // @[MEM.scala 19:18]
  wire [13:0] mem_MPORT_addr; // @[MEM.scala 19:18]
  wire  mem_MPORT_mask; // @[MEM.scala 19:18]
  wire  mem_MPORT_en; // @[MEM.scala 19:18]
  wire [7:0] mem_MPORT_1_data; // @[MEM.scala 19:18]
  wire [13:0] mem_MPORT_1_addr; // @[MEM.scala 19:18]
  wire  mem_MPORT_1_mask; // @[MEM.scala 19:18]
  wire  mem_MPORT_1_en; // @[MEM.scala 19:18]
  wire [7:0] mem_MPORT_2_data; // @[MEM.scala 19:18]
  wire [13:0] mem_MPORT_2_addr; // @[MEM.scala 19:18]
  wire  mem_MPORT_2_mask; // @[MEM.scala 19:18]
  wire  mem_MPORT_2_en; // @[MEM.scala 19:18]
  wire [7:0] mem_MPORT_3_data; // @[MEM.scala 19:18]
  wire [13:0] mem_MPORT_3_addr; // @[MEM.scala 19:18]
  wire  mem_MPORT_3_mask; // @[MEM.scala 19:18]
  wire  mem_MPORT_3_en; // @[MEM.scala 19:18]
  reg [31:0] readMemData; // @[MEM.scala 22:30]
  wire [1:0] byteAddr = io_aluResult_MEM[1:0]; // @[MEM.scala 25:36]
  wire [4:0] addr = io_aluResult_MEM[6:2]; // @[MEM.scala 26:32]
  wire [31:0] wMemDAtaB = {io_wMemData_MEM[7:0],io_wMemData_MEM[7:0],io_wMemData_MEM[7:0],io_wMemData_MEM[7:0]}; // @[Cat.scala 31:58]
  wire [31:0] wMemDataH = {io_wMemData_MEM[15:0],io_wMemData_MEM[15:0]}; // @[Cat.scala 31:58]
  wire  _wMeMData_end_T = io_wrMemByteSelScr_ctrl_uMEM_MEM == 2'h1; // @[MEM.scala 37:31]
  wire  _wMeMData_end_T_1 = io_wrMemByteSelScr_ctrl_uMEM_MEM == 2'h2; // @[MEM.scala 38:31]
  wire  _wMeMData_end_T_2 = io_wrMemByteSelScr_ctrl_uMEM_MEM == 2'h3; // @[MEM.scala 39:31]
  wire [31:0] _wMeMData_end_T_3 = _wMeMData_end_T_2 ? io_wMemData_MEM : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _wMeMData_end_T_4 = _wMeMData_end_T_1 ? wMemDataH : _wMeMData_end_T_3; // @[Mux.scala 101:16]
  wire [31:0] wMeMData_end = _wMeMData_end_T ? wMemDAtaB : _wMeMData_end_T_4; // @[Mux.scala 101:16]
  wire [7:0] wdata0 = wMeMData_end[7:0]; // @[MEM.scala 42:30]
  wire [7:0] wdata1 = wMeMData_end[15:8]; // @[MEM.scala 43:30]
  wire [7:0] wdata2 = wMeMData_end[23:16]; // @[MEM.scala 44:30]
  wire [7:0] wdata3 = wMeMData_end[31:24]; // @[MEM.scala 45:30]
  wire  _typeB_T = byteAddr == 2'h0; // @[MEM.scala 48:19]
  wire  _typeB_T_1 = byteAddr == 2'h1; // @[MEM.scala 49:19]
  wire  _typeB_T_2 = byteAddr == 2'h2; // @[MEM.scala 50:19]
  wire  _typeB_T_3 = byteAddr == 2'h3; // @[MEM.scala 51:19]
  wire [3:0] _typeB_T_4 = _typeB_T_3 ? 4'h8 : 4'h0; // @[Mux.scala 101:16]
  wire [3:0] _typeB_T_5 = _typeB_T_2 ? 4'h4 : _typeB_T_4; // @[Mux.scala 101:16]
  wire [3:0] _typeB_T_6 = _typeB_T_1 ? 4'h2 : _typeB_T_5; // @[Mux.scala 101:16]
  wire [3:0] typeB = _typeB_T ? 4'h1 : _typeB_T_6; // @[Mux.scala 101:16]
  wire  _typeH_T_1 = ~byteAddr[1]; // @[MEM.scala 55:22]
  wire [3:0] _typeH_T_4 = byteAddr[1] ? 4'hc : 4'h0; // @[Mux.scala 101:16]
  wire [3:0] typeH = _typeH_T_1 ? 4'h3 : _typeH_T_4; // @[Mux.scala 101:16]
  wire [3:0] _byteSel_T_3 = _wMeMData_end_T_2 ? 4'hf : 4'h0; // @[Mux.scala 101:16]
  wire [3:0] _byteSel_T_4 = _wMeMData_end_T_1 ? typeH : _byteSel_T_3; // @[Mux.scala 101:16]
  wire [3:0] byteSel = _wMeMData_end_T ? typeB : _byteSel_T_4; // @[Mux.scala 101:16]
  wire [7:0] _T_3 = byteSel[0] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _GEN_25 = {{27'd0}, addr}; // @[MEM.scala 67:18]
  wire [31:0] _T_6 = _GEN_25 + 32'h1; // @[MEM.scala 67:18]
  wire [7:0] _T_10 = byteSel[1] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _T_13 = _GEN_25 + 32'h2; // @[MEM.scala 68:18]
  wire [7:0] _T_17 = byteSel[2] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _T_20 = _GEN_25 + 32'h3; // @[MEM.scala 69:18]
  wire [7:0] _T_24 = byteSel[3] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire  _T_26 = ~io_weMEM_ctrl_uMEM_MEM; // @[MEM.scala 70:27]
  wire [15:0] readWordData_lo = {mem_rdata1_data,mem_rdata0_data}; // @[Cat.scala 31:58]
  wire [15:0] readWordData_hi = {mem_rdata3_data,mem_rdata2_data}; // @[Cat.scala 31:58]
  wire [31:0] readWordData = {mem_rdata3_data,mem_rdata2_data,mem_rdata1_data,mem_rdata0_data}; // @[Cat.scala 31:58]
  wire [7:0] _DataB_T_4 = _typeB_T_3 ? mem_rdata3_data : 8'h0; // @[Mux.scala 101:16]
  wire [7:0] _DataB_T_5 = _typeB_T_2 ? mem_rdata2_data : _DataB_T_4; // @[Mux.scala 101:16]
  wire [7:0] _DataB_T_6 = _typeB_T_1 ? mem_rdata1_data : _DataB_T_5; // @[Mux.scala 101:16]
  wire [7:0] DataB = _typeB_T ? mem_rdata0_data : _DataB_T_6; // @[Mux.scala 101:16]
  wire  _readByteData_T = ~io_memReadDataExt_ctrl_uMEM_MEM; // @[MEM.scala 83:39]
  wire [31:0] _readByteData_T_2 = {24'h0,DataB}; // @[Cat.scala 31:58]
  wire [23:0] _readByteData_T_6 = DataB[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _readByteData_T_7 = {_readByteData_T_6,DataB}; // @[Cat.scala 31:58]
  wire [31:0] _readByteData_T_8 = io_memReadDataExt_ctrl_uMEM_MEM ? _readByteData_T_7 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] readByteData = _readByteData_T ? _readByteData_T_2 : _readByteData_T_8; // @[Mux.scala 101:16]
  wire [15:0] _DataH_T_6 = byteAddr[1] ? readWordData_hi : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] DataH = _typeH_T_1 ? readWordData_lo : _DataH_T_6; // @[Mux.scala 101:16]
  wire [31:0] _readHalfWordData_T_2 = {16'h0,DataH}; // @[Cat.scala 31:58]
  wire [15:0] _readHalfWordData_T_6 = DataH[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _readHalfWordData_T_7 = {_readHalfWordData_T_6,DataH}; // @[Cat.scala 31:58]
  wire [31:0] _readHalfWordData_T_8 = io_memReadDataExt_ctrl_uMEM_MEM ? _readHalfWordData_T_7 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] readHalfWordData = _readByteData_T ? _readHalfWordData_T_2 : _readHalfWordData_T_8; // @[Mux.scala 101:16]
  wire [31:0] _readMemData_T_3 = _wMeMData_end_T_2 ? readWordData : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _readMemData_T_4 = _wMeMData_end_T_1 ? readHalfWordData : _readMemData_T_3; // @[Mux.scala 101:16]
  wire  _wRegData_MEM_T_1 = ~io_wRegDataSrc_ctrl_uMEM_MEM; // @[MEM.scala 103:27]
  wire [31:0] _wRegData_MEM_T_2 = _wRegData_MEM_T_1 ? io_aluResult_MEM : 32'h0; // @[Mux.scala 101:16]
  assign mem_rdata0_en = io_weMEM_ctrl_uMEM_MEM ? 1'h0 : _T_26;
  assign mem_rdata0_addr = {{9'd0}, addr};
  assign mem_rdata0_data = mem[mem_rdata0_addr]; // @[MEM.scala 19:18]
  assign mem_rdata1_en = io_weMEM_ctrl_uMEM_MEM ? 1'h0 : _T_26;
  assign mem_rdata1_addr = _T_6[13:0];
  assign mem_rdata1_data = mem[mem_rdata1_addr]; // @[MEM.scala 19:18]
  assign mem_rdata2_en = io_weMEM_ctrl_uMEM_MEM ? 1'h0 : _T_26;
  assign mem_rdata2_addr = _T_13[13:0];
  assign mem_rdata2_data = mem[mem_rdata2_addr]; // @[MEM.scala 19:18]
  assign mem_rdata3_en = io_weMEM_ctrl_uMEM_MEM ? 1'h0 : _T_26;
  assign mem_rdata3_addr = _T_20[13:0];
  assign mem_rdata3_data = mem[mem_rdata3_addr]; // @[MEM.scala 19:18]
  assign mem_MPORT_data = wdata0 & _T_3;
  assign mem_MPORT_addr = {{9'd0}, addr};
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_weMEM_ctrl_uMEM_MEM;
  assign mem_MPORT_1_data = wdata1 & _T_10;
  assign mem_MPORT_1_addr = _T_6[13:0];
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_weMEM_ctrl_uMEM_MEM;
  assign mem_MPORT_2_data = wdata2 & _T_17;
  assign mem_MPORT_2_addr = _T_13[13:0];
  assign mem_MPORT_2_mask = 1'h1;
  assign mem_MPORT_2_en = io_weMEM_ctrl_uMEM_MEM;
  assign mem_MPORT_3_data = wdata3 & _T_24;
  assign mem_MPORT_3_addr = _T_20[13:0];
  assign mem_MPORT_3_mask = 1'h1;
  assign mem_MPORT_3_en = io_weMEM_ctrl_uMEM_MEM;
  assign io_wRegData_MEM = io_wRegDataSrc_ctrl_uMEM_MEM ? readMemData : _wRegData_MEM_T_2; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[MEM.scala 19:18]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[MEM.scala 19:18]
    end
    if (mem_MPORT_2_en & mem_MPORT_2_mask) begin
      mem[mem_MPORT_2_addr] <= mem_MPORT_2_data; // @[MEM.scala 19:18]
    end
    if (mem_MPORT_3_en & mem_MPORT_3_mask) begin
      mem[mem_MPORT_3_addr] <= mem_MPORT_3_data; // @[MEM.scala 19:18]
    end
    if (reset) begin // @[MEM.scala 22:30]
      readMemData <= 32'h0; // @[MEM.scala 22:30]
    end else if (!(io_weMEM_ctrl_uMEM_MEM)) begin // @[MEM.scala 65:31]
      if (~io_weMEM_ctrl_uMEM_MEM) begin // @[MEM.scala 70:37]
        if (_wMeMData_end_T) begin // @[Mux.scala 101:16]
          readMemData <= readByteData;
        end else begin
          readMemData <= _readMemData_T_4;
        end
      end
    end
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
  for (initvar = 0; initvar < 16384; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  readMemData = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM_WB(
  input         clock,
  input         reset,
  input         io_reset,
  input  [31:0] io_wRegData_MEM,
  input  [4:0]  io_wRegAddr_MEM,
  input         io_weReg_ctrl_uWB_MEM,
  output [31:0] io_wRegData_WB,
  output [4:0]  io_wRegAddr_WB,
  output        io_weReg_ctrl_uWB_WB
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] wRegData; // @[MEM_WB.scala 19:27]
  reg [4:0] wRegAddr; // @[MEM_WB.scala 20:27]
  reg  weReg_ctrl_uWB; // @[MEM_WB.scala 21:33]
  assign io_wRegData_WB = wRegData; // @[MEM_WB.scala 42:20]
  assign io_wRegAddr_WB = wRegAddr; // @[MEM_WB.scala 43:20]
  assign io_weReg_ctrl_uWB_WB = weReg_ctrl_uWB; // @[MEM_WB.scala 44:26]
  always @(posedge clock) begin
    if (reset) begin // @[MEM_WB.scala 19:27]
      wRegData <= 32'h0; // @[MEM_WB.scala 19:27]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wRegData <= 32'h0;
    end else begin
      wRegData <= io_wRegData_MEM;
    end
    if (reset) begin // @[MEM_WB.scala 20:27]
      wRegAddr <= 5'h0; // @[MEM_WB.scala 20:27]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      wRegAddr <= 5'h0;
    end else begin
      wRegAddr <= io_wRegAddr_MEM;
    end
    if (reset) begin // @[MEM_WB.scala 21:33]
      weReg_ctrl_uWB <= 1'h0; // @[MEM_WB.scala 21:33]
    end else if (io_reset) begin // @[Mux.scala 101:16]
      weReg_ctrl_uWB <= 1'h0;
    end else begin
      weReg_ctrl_uWB <= io_weReg_ctrl_uWB_MEM;
    end
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  wRegData = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  wRegAddr = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  weReg_ctrl_uWB = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PLC(
  input   io_stallReqOfID,
  input   io_flushReqOfID,
  output  io_stallStageIF,
  output  io_stallStageID,
  output  io_flushStageID,
  output  io_flushStageEXE
);
  assign io_stallStageIF = io_stallReqOfID; // @[PLC.scala 19:21]
  assign io_stallStageID = io_stallReqOfID; // @[PLC.scala 20:21]
  assign io_flushStageID = ~io_stallReqOfID & io_flushReqOfID; // @[PLC.scala 21:41]
  assign io_flushStageEXE = io_stallReqOfID; // @[PLC.scala 23:22]
endmodule
module MyCpu(
  input   clock,
  input   reset,
  input   io_reset
);
  wire  ifd_clock; // @[MyCpu.scala 11:21]
  wire  ifd_reset; // @[MyCpu.scala 11:21]
  wire  ifd_io_stallStageIF; // @[MyCpu.scala 11:21]
  wire [31:0] ifd_io_branchTarget_ID; // @[MyCpu.scala 11:21]
  wire  ifd_io_branchFlag_ID; // @[MyCpu.scala 11:21]
  wire  ifd_io_reset; // @[MyCpu.scala 11:21]
  wire [31:0] ifd_io_PC_IF; // @[MyCpu.scala 11:21]
  wire [31:0] ifd_io_instr_IF; // @[MyCpu.scala 11:21]
  wire  if_id_clock; // @[MyCpu.scala 12:23]
  wire  if_id_reset; // @[MyCpu.scala 12:23]
  wire [31:0] if_id_io_PC_IF; // @[MyCpu.scala 12:23]
  wire [31:0] if_id_io_instr_IF; // @[MyCpu.scala 12:23]
  wire  if_id_io_flushStageID; // @[MyCpu.scala 12:23]
  wire  if_id_io_stallStageID; // @[MyCpu.scala 12:23]
  wire  if_id_io_reset; // @[MyCpu.scala 12:23]
  wire [31:0] if_id_io_PC_ID; // @[MyCpu.scala 12:23]
  wire [31:0] if_id_io_instr_ID; // @[MyCpu.scala 12:23]
  wire  id_clock; // @[MyCpu.scala 13:20]
  wire  id_reset; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_PC_ID; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_instr_ID; // @[MyCpu.scala 13:20]
  wire [4:0] id_io_wRegAddr_EXE; // @[MyCpu.scala 13:20]
  wire [4:0] id_io_wRegAddr_MEM; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_aluResult_EXE; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_wRegData_MEM; // @[MyCpu.scala 13:20]
  wire  id_io_wRegDataSrc_ctrl_uMEM_EXE; // @[MyCpu.scala 13:20]
  wire  id_io_wReg_ctrl_uWB_WB; // @[MyCpu.scala 13:20]
  wire [4:0] id_io_wRegaddr_WB; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_wRegData_WB; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_data1_ID; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_data2_ID; // @[MyCpu.scala 13:20]
  wire [4:0] id_io_wRegAddr_ID; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_wMemData_ID; // @[MyCpu.scala 13:20]
  wire [31:0] id_io_branchTarge_ID; // @[MyCpu.scala 13:20]
  wire  id_io_branchFlag_ID; // @[MyCpu.scala 13:20]
  wire  id_io_stallReqOfID_ID; // @[MyCpu.scala 13:20]
  wire  id_io_flushReqOfID_ID; // @[MyCpu.scala 13:20]
  wire  id_io_weReg_ctrl_uWB_ID; // @[MyCpu.scala 13:20]
  wire  id_io_memReadDataExt_ctrl_uMEM_ID; // @[MyCpu.scala 13:20]
  wire [1:0] id_io_wrMemByteSelScr_ctrl_uMEM_ID; // @[MyCpu.scala 13:20]
  wire  id_io_wRegDataSrc_ctrl_uMEM_ID; // @[MyCpu.scala 13:20]
  wire  id_io_weMEM_ctrl_uMEM_ID; // @[MyCpu.scala 13:20]
  wire [3:0] id_io_aluOP_ctrl_uEXE_ID; // @[MyCpu.scala 13:20]
  wire  id_exe_clock; // @[MyCpu.scala 14:24]
  wire  id_exe_reset; // @[MyCpu.scala 14:24]
  wire  id_exe_io_flushStageID; // @[MyCpu.scala 14:24]
  wire  id_exe_io_reset; // @[MyCpu.scala 14:24]
  wire [3:0] id_exe_io_aluOP_ctrl_uEXE_ID; // @[MyCpu.scala 14:24]
  wire [31:0] id_exe_io_data1_ID; // @[MyCpu.scala 14:24]
  wire [31:0] id_exe_io_data2_ID; // @[MyCpu.scala 14:24]
  wire [4:0] id_exe_io_wRegAddr_ID; // @[MyCpu.scala 14:24]
  wire [31:0] id_exe_io_wMemData_ID; // @[MyCpu.scala 14:24]
  wire  id_exe_io_weMEM_ctrl_uMEM_ID; // @[MyCpu.scala 14:24]
  wire  id_exe_io_wRegDataSrc_ctrl_uMEM_ID; // @[MyCpu.scala 14:24]
  wire [1:0] id_exe_io_wrMemByteSelScr_ctrl_uMEM_ID; // @[MyCpu.scala 14:24]
  wire  id_exe_io_memReadDataExt_ctrl_uMEM_ID; // @[MyCpu.scala 14:24]
  wire  id_exe_io_weReg_ctrl_uWB_ID; // @[MyCpu.scala 14:24]
  wire [3:0] id_exe_io_aluOP_ctrl_uID_EXE; // @[MyCpu.scala 14:24]
  wire [31:0] id_exe_io_data1_EXE; // @[MyCpu.scala 14:24]
  wire [31:0] id_exe_io_data2_EXE; // @[MyCpu.scala 14:24]
  wire [4:0] id_exe_io_wRegAddr_EXE; // @[MyCpu.scala 14:24]
  wire [31:0] id_exe_io_wMenData_EXE; // @[MyCpu.scala 14:24]
  wire  id_exe_io_weMEM_ctrl_uMEM_EXE; // @[MyCpu.scala 14:24]
  wire  id_exe_io_wRegDataSrc_ctrl_uMEM_EXE; // @[MyCpu.scala 14:24]
  wire [1:0] id_exe_io_wrMemByteSelScr_ctrl_uMEM_EXE; // @[MyCpu.scala 14:24]
  wire  id_exe_io_memReadDataExt_ctrl_uMEM_EXE; // @[MyCpu.scala 14:24]
  wire  id_exe_io_weReg_ctrl_uWB_EXE; // @[MyCpu.scala 14:24]
  wire [3:0] exe_io_aluOP_ctrl_uEXE_EXE; // @[MyCpu.scala 15:21]
  wire [31:0] exe_io_data1_EXE; // @[MyCpu.scala 15:21]
  wire [31:0] exe_io_data2_EXE; // @[MyCpu.scala 15:21]
  wire [31:0] exe_io_aluResult_EXE; // @[MyCpu.scala 15:21]
  wire  exe_mem_clock; // @[MyCpu.scala 16:25]
  wire  exe_mem_reset; // @[MyCpu.scala 16:25]
  wire [31:0] exe_mem_io_aluResult_EXE; // @[MyCpu.scala 16:25]
  wire [4:0] exe_mem_io_wRegAddr_EXE; // @[MyCpu.scala 16:25]
  wire [31:0] exe_mem_io_wMenData_EXE; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_weMEM_ctrl_uMEM_EXE; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_wRegDataSrc_ctrl_uMEM_EXE; // @[MyCpu.scala 16:25]
  wire [1:0] exe_mem_io_wrMemByteSelScr_ctrl_uMEM_EXE; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_memReadDataExt_ctrl_uMEM_EXE; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_weReg_ctrl_uWB_EXE; // @[MyCpu.scala 16:25]
  wire [31:0] exe_mem_io_aluResult_MEM; // @[MyCpu.scala 16:25]
  wire [4:0] exe_mem_io_wRegAddr_MEM; // @[MyCpu.scala 16:25]
  wire [31:0] exe_mem_io_wMemData_MEM; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_weMEM_ctrl_uMEM_MEM; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_wRegDataSrc_ctrl_uMEM_MEM; // @[MyCpu.scala 16:25]
  wire [1:0] exe_mem_io_wrMemByteSelScr_ctrl_uMEM_MEM; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_memReadDataExt_ctrl_uMEM_MEM; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_weReg_ctrl_uWB_MEM; // @[MyCpu.scala 16:25]
  wire  exe_mem_io_reset; // @[MyCpu.scala 16:25]
  wire  mem_clock; // @[MyCpu.scala 17:21]
  wire  mem_reset; // @[MyCpu.scala 17:21]
  wire [31:0] mem_io_aluResult_MEM; // @[MyCpu.scala 17:21]
  wire [31:0] mem_io_wMemData_MEM; // @[MyCpu.scala 17:21]
  wire  mem_io_weMEM_ctrl_uMEM_MEM; // @[MyCpu.scala 17:21]
  wire  mem_io_wRegDataSrc_ctrl_uMEM_MEM; // @[MyCpu.scala 17:21]
  wire [1:0] mem_io_wrMemByteSelScr_ctrl_uMEM_MEM; // @[MyCpu.scala 17:21]
  wire  mem_io_memReadDataExt_ctrl_uMEM_MEM; // @[MyCpu.scala 17:21]
  wire [31:0] mem_io_wRegData_MEM; // @[MyCpu.scala 17:21]
  wire  mem_wb_clock; // @[MyCpu.scala 18:24]
  wire  mem_wb_reset; // @[MyCpu.scala 18:24]
  wire  mem_wb_io_reset; // @[MyCpu.scala 18:24]
  wire [31:0] mem_wb_io_wRegData_MEM; // @[MyCpu.scala 18:24]
  wire [4:0] mem_wb_io_wRegAddr_MEM; // @[MyCpu.scala 18:24]
  wire  mem_wb_io_weReg_ctrl_uWB_MEM; // @[MyCpu.scala 18:24]
  wire [31:0] mem_wb_io_wRegData_WB; // @[MyCpu.scala 18:24]
  wire [4:0] mem_wb_io_wRegAddr_WB; // @[MyCpu.scala 18:24]
  wire  mem_wb_io_weReg_ctrl_uWB_WB; // @[MyCpu.scala 18:24]
  wire  plc_io_stallReqOfID; // @[MyCpu.scala 19:21]
  wire  plc_io_flushReqOfID; // @[MyCpu.scala 19:21]
  wire  plc_io_stallStageIF; // @[MyCpu.scala 19:21]
  wire  plc_io_stallStageID; // @[MyCpu.scala 19:21]
  wire  plc_io_flushStageID; // @[MyCpu.scala 19:21]
  wire  plc_io_flushStageEXE; // @[MyCpu.scala 19:21]
  IF ifd ( // @[MyCpu.scala 11:21]
    .clock(ifd_clock),
    .reset(ifd_reset),
    .io_stallStageIF(ifd_io_stallStageIF),
    .io_branchTarget_ID(ifd_io_branchTarget_ID),
    .io_branchFlag_ID(ifd_io_branchFlag_ID),
    .io_reset(ifd_io_reset),
    .io_PC_IF(ifd_io_PC_IF),
    .io_instr_IF(ifd_io_instr_IF)
  );
  IF_ID if_id ( // @[MyCpu.scala 12:23]
    .clock(if_id_clock),
    .reset(if_id_reset),
    .io_PC_IF(if_id_io_PC_IF),
    .io_instr_IF(if_id_io_instr_IF),
    .io_flushStageID(if_id_io_flushStageID),
    .io_stallStageID(if_id_io_stallStageID),
    .io_reset(if_id_io_reset),
    .io_PC_ID(if_id_io_PC_ID),
    .io_instr_ID(if_id_io_instr_ID)
  );
  ID id ( // @[MyCpu.scala 13:20]
    .clock(id_clock),
    .reset(id_reset),
    .io_PC_ID(id_io_PC_ID),
    .io_instr_ID(id_io_instr_ID),
    .io_wRegAddr_EXE(id_io_wRegAddr_EXE),
    .io_wRegAddr_MEM(id_io_wRegAddr_MEM),
    .io_aluResult_EXE(id_io_aluResult_EXE),
    .io_wRegData_MEM(id_io_wRegData_MEM),
    .io_wRegDataSrc_ctrl_uMEM_EXE(id_io_wRegDataSrc_ctrl_uMEM_EXE),
    .io_wReg_ctrl_uWB_WB(id_io_wReg_ctrl_uWB_WB),
    .io_wRegaddr_WB(id_io_wRegaddr_WB),
    .io_wRegData_WB(id_io_wRegData_WB),
    .io_data1_ID(id_io_data1_ID),
    .io_data2_ID(id_io_data2_ID),
    .io_wRegAddr_ID(id_io_wRegAddr_ID),
    .io_wMemData_ID(id_io_wMemData_ID),
    .io_branchTarge_ID(id_io_branchTarge_ID),
    .io_branchFlag_ID(id_io_branchFlag_ID),
    .io_stallReqOfID_ID(id_io_stallReqOfID_ID),
    .io_flushReqOfID_ID(id_io_flushReqOfID_ID),
    .io_weReg_ctrl_uWB_ID(id_io_weReg_ctrl_uWB_ID),
    .io_memReadDataExt_ctrl_uMEM_ID(id_io_memReadDataExt_ctrl_uMEM_ID),
    .io_wrMemByteSelScr_ctrl_uMEM_ID(id_io_wrMemByteSelScr_ctrl_uMEM_ID),
    .io_wRegDataSrc_ctrl_uMEM_ID(id_io_wRegDataSrc_ctrl_uMEM_ID),
    .io_weMEM_ctrl_uMEM_ID(id_io_weMEM_ctrl_uMEM_ID),
    .io_aluOP_ctrl_uEXE_ID(id_io_aluOP_ctrl_uEXE_ID)
  );
  ID_EXE id_exe ( // @[MyCpu.scala 14:24]
    .clock(id_exe_clock),
    .reset(id_exe_reset),
    .io_flushStageID(id_exe_io_flushStageID),
    .io_reset(id_exe_io_reset),
    .io_aluOP_ctrl_uEXE_ID(id_exe_io_aluOP_ctrl_uEXE_ID),
    .io_data1_ID(id_exe_io_data1_ID),
    .io_data2_ID(id_exe_io_data2_ID),
    .io_wRegAddr_ID(id_exe_io_wRegAddr_ID),
    .io_wMemData_ID(id_exe_io_wMemData_ID),
    .io_weMEM_ctrl_uMEM_ID(id_exe_io_weMEM_ctrl_uMEM_ID),
    .io_wRegDataSrc_ctrl_uMEM_ID(id_exe_io_wRegDataSrc_ctrl_uMEM_ID),
    .io_wrMemByteSelScr_ctrl_uMEM_ID(id_exe_io_wrMemByteSelScr_ctrl_uMEM_ID),
    .io_memReadDataExt_ctrl_uMEM_ID(id_exe_io_memReadDataExt_ctrl_uMEM_ID),
    .io_weReg_ctrl_uWB_ID(id_exe_io_weReg_ctrl_uWB_ID),
    .io_aluOP_ctrl_uID_EXE(id_exe_io_aluOP_ctrl_uID_EXE),
    .io_data1_EXE(id_exe_io_data1_EXE),
    .io_data2_EXE(id_exe_io_data2_EXE),
    .io_wRegAddr_EXE(id_exe_io_wRegAddr_EXE),
    .io_wMenData_EXE(id_exe_io_wMenData_EXE),
    .io_weMEM_ctrl_uMEM_EXE(id_exe_io_weMEM_ctrl_uMEM_EXE),
    .io_wRegDataSrc_ctrl_uMEM_EXE(id_exe_io_wRegDataSrc_ctrl_uMEM_EXE),
    .io_wrMemByteSelScr_ctrl_uMEM_EXE(id_exe_io_wrMemByteSelScr_ctrl_uMEM_EXE),
    .io_memReadDataExt_ctrl_uMEM_EXE(id_exe_io_memReadDataExt_ctrl_uMEM_EXE),
    .io_weReg_ctrl_uWB_EXE(id_exe_io_weReg_ctrl_uWB_EXE)
  );
  EXE exe ( // @[MyCpu.scala 15:21]
    .io_aluOP_ctrl_uEXE_EXE(exe_io_aluOP_ctrl_uEXE_EXE),
    .io_data1_EXE(exe_io_data1_EXE),
    .io_data2_EXE(exe_io_data2_EXE),
    .io_aluResult_EXE(exe_io_aluResult_EXE)
  );
  EXE_MEM exe_mem ( // @[MyCpu.scala 16:25]
    .clock(exe_mem_clock),
    .reset(exe_mem_reset),
    .io_aluResult_EXE(exe_mem_io_aluResult_EXE),
    .io_wRegAddr_EXE(exe_mem_io_wRegAddr_EXE),
    .io_wMenData_EXE(exe_mem_io_wMenData_EXE),
    .io_weMEM_ctrl_uMEM_EXE(exe_mem_io_weMEM_ctrl_uMEM_EXE),
    .io_wRegDataSrc_ctrl_uMEM_EXE(exe_mem_io_wRegDataSrc_ctrl_uMEM_EXE),
    .io_wrMemByteSelScr_ctrl_uMEM_EXE(exe_mem_io_wrMemByteSelScr_ctrl_uMEM_EXE),
    .io_memReadDataExt_ctrl_uMEM_EXE(exe_mem_io_memReadDataExt_ctrl_uMEM_EXE),
    .io_weReg_ctrl_uWB_EXE(exe_mem_io_weReg_ctrl_uWB_EXE),
    .io_aluResult_MEM(exe_mem_io_aluResult_MEM),
    .io_wRegAddr_MEM(exe_mem_io_wRegAddr_MEM),
    .io_wMemData_MEM(exe_mem_io_wMemData_MEM),
    .io_weMEM_ctrl_uMEM_MEM(exe_mem_io_weMEM_ctrl_uMEM_MEM),
    .io_wRegDataSrc_ctrl_uMEM_MEM(exe_mem_io_wRegDataSrc_ctrl_uMEM_MEM),
    .io_wrMemByteSelScr_ctrl_uMEM_MEM(exe_mem_io_wrMemByteSelScr_ctrl_uMEM_MEM),
    .io_memReadDataExt_ctrl_uMEM_MEM(exe_mem_io_memReadDataExt_ctrl_uMEM_MEM),
    .io_weReg_ctrl_uWB_MEM(exe_mem_io_weReg_ctrl_uWB_MEM),
    .io_reset(exe_mem_io_reset)
  );
  MEM mem ( // @[MyCpu.scala 17:21]
    .clock(mem_clock),
    .reset(mem_reset),
    .io_aluResult_MEM(mem_io_aluResult_MEM),
    .io_wMemData_MEM(mem_io_wMemData_MEM),
    .io_weMEM_ctrl_uMEM_MEM(mem_io_weMEM_ctrl_uMEM_MEM),
    .io_wRegDataSrc_ctrl_uMEM_MEM(mem_io_wRegDataSrc_ctrl_uMEM_MEM),
    .io_wrMemByteSelScr_ctrl_uMEM_MEM(mem_io_wrMemByteSelScr_ctrl_uMEM_MEM),
    .io_memReadDataExt_ctrl_uMEM_MEM(mem_io_memReadDataExt_ctrl_uMEM_MEM),
    .io_wRegData_MEM(mem_io_wRegData_MEM)
  );
  MEM_WB mem_wb ( // @[MyCpu.scala 18:24]
    .clock(mem_wb_clock),
    .reset(mem_wb_reset),
    .io_reset(mem_wb_io_reset),
    .io_wRegData_MEM(mem_wb_io_wRegData_MEM),
    .io_wRegAddr_MEM(mem_wb_io_wRegAddr_MEM),
    .io_weReg_ctrl_uWB_MEM(mem_wb_io_weReg_ctrl_uWB_MEM),
    .io_wRegData_WB(mem_wb_io_wRegData_WB),
    .io_wRegAddr_WB(mem_wb_io_wRegAddr_WB),
    .io_weReg_ctrl_uWB_WB(mem_wb_io_weReg_ctrl_uWB_WB)
  );
  PLC plc ( // @[MyCpu.scala 19:21]
    .io_stallReqOfID(plc_io_stallReqOfID),
    .io_flushReqOfID(plc_io_flushReqOfID),
    .io_stallStageIF(plc_io_stallStageIF),
    .io_stallStageID(plc_io_stallStageID),
    .io_flushStageID(plc_io_flushStageID),
    .io_flushStageEXE(plc_io_flushStageEXE)
  );
  assign ifd_clock = clock;
  assign ifd_reset = reset;
  assign ifd_io_stallStageIF = plc_io_stallStageIF; // @[MyCpu.scala 29:25]
  assign ifd_io_branchTarget_ID = id_io_branchTarge_ID; // @[MyCpu.scala 39:28]
  assign ifd_io_branchFlag_ID = id_io_branchFlag_ID; // @[MyCpu.scala 40:26]
  assign ifd_io_reset = reset; // @[MyCpu.scala 21:18]
  assign if_id_clock = clock;
  assign if_id_reset = reset;
  assign if_id_io_PC_IF = ifd_io_PC_IF; // @[MyCpu.scala 42:20]
  assign if_id_io_instr_IF = ifd_io_instr_IF; // @[MyCpu.scala 43:23]
  assign if_id_io_flushStageID = plc_io_flushStageID; // @[MyCpu.scala 30:27]
  assign if_id_io_stallStageID = plc_io_stallStageID; // @[MyCpu.scala 31:27]
  assign if_id_io_reset = reset; // @[MyCpu.scala 22:20]
  assign id_clock = clock;
  assign id_reset = reset;
  assign id_io_PC_ID = if_id_io_PC_ID; // @[MyCpu.scala 46:17]
  assign id_io_instr_ID = if_id_io_instr_ID; // @[MyCpu.scala 47:20]
  assign id_io_wRegAddr_EXE = exe_mem_io_wRegAddr_EXE; // @[MyCpu.scala 52:24]
  assign id_io_wRegAddr_MEM = exe_mem_io_wRegAddr_MEM; // @[MyCpu.scala 53:24]
  assign id_io_aluResult_EXE = exe_io_aluResult_EXE; // @[MyCpu.scala 51:25]
  assign id_io_wRegData_MEM = mem_io_wRegData_MEM; // @[MyCpu.scala 54:24]
  assign id_io_wRegDataSrc_ctrl_uMEM_EXE = id_exe_io_wRegDataSrc_ctrl_uMEM_EXE; // @[MyCpu.scala 55:37]
  assign id_io_wReg_ctrl_uWB_WB = mem_wb_io_weReg_ctrl_uWB_WB; // @[MyCpu.scala 50:28]
  assign id_io_wRegaddr_WB = mem_wb_io_wRegAddr_WB; // @[MyCpu.scala 48:23]
  assign id_io_wRegData_WB = mem_wb_io_wRegData_WB; // @[MyCpu.scala 49:23]
  assign id_exe_clock = clock;
  assign id_exe_reset = reset;
  assign id_exe_io_flushStageID = plc_io_flushStageEXE; // @[MyCpu.scala 32:28]
  assign id_exe_io_reset = reset; // @[MyCpu.scala 24:21]
  assign id_exe_io_aluOP_ctrl_uEXE_ID = id_io_aluOP_ctrl_uEXE_ID; // @[MyCpu.scala 58:34]
  assign id_exe_io_data1_ID = id_io_data1_ID; // @[MyCpu.scala 59:24]
  assign id_exe_io_data2_ID = id_io_data2_ID; // @[MyCpu.scala 60:24]
  assign id_exe_io_wRegAddr_ID = id_io_wRegAddr_ID; // @[MyCpu.scala 61:27]
  assign id_exe_io_wMemData_ID = id_io_wMemData_ID; // @[MyCpu.scala 62:27]
  assign id_exe_io_weMEM_ctrl_uMEM_ID = id_io_weMEM_ctrl_uMEM_ID; // @[MyCpu.scala 63:34]
  assign id_exe_io_wRegDataSrc_ctrl_uMEM_ID = id_io_wRegDataSrc_ctrl_uMEM_ID; // @[MyCpu.scala 64:40]
  assign id_exe_io_wrMemByteSelScr_ctrl_uMEM_ID = id_io_wrMemByteSelScr_ctrl_uMEM_ID; // @[MyCpu.scala 65:44]
  assign id_exe_io_memReadDataExt_ctrl_uMEM_ID = id_io_memReadDataExt_ctrl_uMEM_ID; // @[MyCpu.scala 66:43]
  assign id_exe_io_weReg_ctrl_uWB_ID = id_io_weReg_ctrl_uWB_ID; // @[MyCpu.scala 67:33]
  assign exe_io_aluOP_ctrl_uEXE_EXE = id_exe_io_aluOP_ctrl_uID_EXE; // @[MyCpu.scala 69:32]
  assign exe_io_data1_EXE = id_exe_io_data1_EXE; // @[MyCpu.scala 70:22]
  assign exe_io_data2_EXE = id_exe_io_data2_EXE; // @[MyCpu.scala 71:22]
  assign exe_mem_clock = clock;
  assign exe_mem_reset = reset;
  assign exe_mem_io_aluResult_EXE = exe_io_aluResult_EXE; // @[MyCpu.scala 73:30]
  assign exe_mem_io_wRegAddr_EXE = id_exe_io_wRegAddr_EXE; // @[MyCpu.scala 74:29]
  assign exe_mem_io_wMenData_EXE = id_exe_io_wMenData_EXE; // @[MyCpu.scala 75:29]
  assign exe_mem_io_weMEM_ctrl_uMEM_EXE = id_exe_io_weMEM_ctrl_uMEM_EXE; // @[MyCpu.scala 76:36]
  assign exe_mem_io_wRegDataSrc_ctrl_uMEM_EXE = id_exe_io_wRegDataSrc_ctrl_uMEM_EXE; // @[MyCpu.scala 77:42]
  assign exe_mem_io_wrMemByteSelScr_ctrl_uMEM_EXE = id_exe_io_wrMemByteSelScr_ctrl_uMEM_EXE; // @[MyCpu.scala 78:46]
  assign exe_mem_io_memReadDataExt_ctrl_uMEM_EXE = id_exe_io_memReadDataExt_ctrl_uMEM_EXE; // @[MyCpu.scala 79:45]
  assign exe_mem_io_weReg_ctrl_uWB_EXE = id_exe_io_weReg_ctrl_uWB_EXE; // @[MyCpu.scala 80:35]
  assign exe_mem_io_reset = reset; // @[MyCpu.scala 25:22]
  assign mem_clock = clock;
  assign mem_reset = reset;
  assign mem_io_aluResult_MEM = exe_mem_io_aluResult_MEM; // @[MyCpu.scala 82:26]
  assign mem_io_wMemData_MEM = exe_mem_io_wMemData_MEM; // @[MyCpu.scala 83:25]
  assign mem_io_weMEM_ctrl_uMEM_MEM = exe_mem_io_weMEM_ctrl_uMEM_MEM; // @[MyCpu.scala 84:32]
  assign mem_io_wRegDataSrc_ctrl_uMEM_MEM = exe_mem_io_wRegDataSrc_ctrl_uMEM_MEM; // @[MyCpu.scala 85:38]
  assign mem_io_wrMemByteSelScr_ctrl_uMEM_MEM = exe_mem_io_wrMemByteSelScr_ctrl_uMEM_MEM; // @[MyCpu.scala 86:42]
  assign mem_io_memReadDataExt_ctrl_uMEM_MEM = exe_mem_io_memReadDataExt_ctrl_uMEM_MEM; // @[MyCpu.scala 87:41]
  assign mem_wb_clock = clock;
  assign mem_wb_reset = reset;
  assign mem_wb_io_reset = reset; // @[MyCpu.scala 27:21]
  assign mem_wb_io_wRegData_MEM = mem_io_wRegData_MEM; // @[MyCpu.scala 89:28]
  assign mem_wb_io_wRegAddr_MEM = exe_mem_io_wRegAddr_MEM; // @[MyCpu.scala 91:28]
  assign mem_wb_io_weReg_ctrl_uWB_MEM = exe_mem_io_weReg_ctrl_uWB_MEM; // @[MyCpu.scala 90:34]
  assign plc_io_stallReqOfID = id_io_stallReqOfID_ID; // @[MyCpu.scala 93:25]
  assign plc_io_flushReqOfID = id_io_flushReqOfID_ID; // @[MyCpu.scala 94:25]
endmodule

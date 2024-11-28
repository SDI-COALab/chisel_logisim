module ID_EXE(
  input         clock,
  input         reset,
  input         io_flushStageID,
  input         io_stallStageID,
  input         io_reset,
  input  [3:0]  io_aluOP_ctrl_uEXE_ID,
  input  [31:0] io_data1_ID,
  input  [31:0] io_data2_ID,
  input  [4:0]  io_wRegAddr_ID,
  input  [31:0] io_wMenData_ID,
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
  reg [31:0] wMenData_ID; // @[ID_EXE.scala 39:28]
  reg  weMEM_ctrl_uMEM_ID; // @[ID_EXE.scala 40:35]
  reg  wRegDataSrc_ctrl_uMEM_ID; // @[ID_EXE.scala 41:41]
  reg [1:0] wrMemByteSelScr_ctrl_uMEM_ID; // @[ID_EXE.scala 42:45]
  reg  memReadDataExt_ctrl_uMEM_ID; // @[ID_EXE.scala 43:44]
  reg  weReg_ctrl_uWB_ID; // @[ID_EXE.scala 44:34]
  assign io_aluOP_ctrl_uID_EXE = aluOP_ctrl_uEXE_ID; // @[ID_EXE.scala 96:25]
  assign io_data1_EXE = data1_ID; // @[ID_EXE.scala 97:16]
  assign io_data2_EXE = data2_ID; // @[ID_EXE.scala 98:16]
  assign io_wRegAddr_EXE = wRegAddr_ID; // @[ID_EXE.scala 99:19]
  assign io_wMenData_EXE = wMenData_ID; // @[ID_EXE.scala 100:19]
  assign io_weMEM_ctrl_uMEM_EXE = weMEM_ctrl_uMEM_ID; // @[ID_EXE.scala 101:26]
  assign io_wRegDataSrc_ctrl_uMEM_EXE = wRegDataSrc_ctrl_uMEM_ID; // @[ID_EXE.scala 102:32]
  assign io_wrMemByteSelScr_ctrl_uMEM_EXE = wrMemByteSelScr_ctrl_uMEM_ID; // @[ID_EXE.scala 103:36]
  assign io_memReadDataExt_ctrl_uMEM_EXE = memReadDataExt_ctrl_uMEM_ID; // @[ID_EXE.scala 104:35]
  assign io_weReg_ctrl_uWB_EXE = weReg_ctrl_uWB_ID; // @[ID_EXE.scala 105:25]
  always @(posedge clock) begin
    if (reset) begin // @[ID_EXE.scala 35:35]
      aluOP_ctrl_uEXE_ID <= 4'h0; // @[ID_EXE.scala 35:35]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        aluOP_ctrl_uEXE_ID <= 4'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        aluOP_ctrl_uEXE_ID <= 4'h0;
      end else begin
        aluOP_ctrl_uEXE_ID <= io_aluOP_ctrl_uEXE_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 36:25]
      data1_ID <= 32'h0; // @[ID_EXE.scala 36:25]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        data1_ID <= 32'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        data1_ID <= 32'h0;
      end else begin
        data1_ID <= io_data1_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 37:25]
      data2_ID <= 32'h0; // @[ID_EXE.scala 37:25]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        data2_ID <= 32'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        data2_ID <= 32'h0;
      end else begin
        data2_ID <= io_data2_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 38:28]
      wRegAddr_ID <= 5'h0; // @[ID_EXE.scala 38:28]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wRegAddr_ID <= 5'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        wRegAddr_ID <= 5'h0;
      end else begin
        wRegAddr_ID <= io_wRegAddr_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 39:28]
      wMenData_ID <= 32'h0; // @[ID_EXE.scala 39:28]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wMenData_ID <= 32'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        wMenData_ID <= 32'h0;
      end else begin
        wMenData_ID <= io_wMenData_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 40:35]
      weMEM_ctrl_uMEM_ID <= 1'h0; // @[ID_EXE.scala 40:35]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        weMEM_ctrl_uMEM_ID <= 1'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        weMEM_ctrl_uMEM_ID <= 1'h0;
      end else begin
        weMEM_ctrl_uMEM_ID <= io_weMEM_ctrl_uMEM_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 41:41]
      wRegDataSrc_ctrl_uMEM_ID <= 1'h0; // @[ID_EXE.scala 41:41]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wRegDataSrc_ctrl_uMEM_ID <= 1'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        wRegDataSrc_ctrl_uMEM_ID <= 1'h0;
      end else begin
        wRegDataSrc_ctrl_uMEM_ID <= io_wRegDataSrc_ctrl_uMEM_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 42:45]
      wrMemByteSelScr_ctrl_uMEM_ID <= 2'h0; // @[ID_EXE.scala 42:45]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wrMemByteSelScr_ctrl_uMEM_ID <= 2'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        wrMemByteSelScr_ctrl_uMEM_ID <= 2'h0;
      end else begin
        wrMemByteSelScr_ctrl_uMEM_ID <= io_wrMemByteSelScr_ctrl_uMEM_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 43:44]
      memReadDataExt_ctrl_uMEM_ID <= 1'h0; // @[ID_EXE.scala 43:44]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        memReadDataExt_ctrl_uMEM_ID <= 1'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        memReadDataExt_ctrl_uMEM_ID <= 1'h0;
      end else begin
        memReadDataExt_ctrl_uMEM_ID <= io_memReadDataExt_ctrl_uMEM_ID;
      end
    end
    if (reset) begin // @[ID_EXE.scala 44:34]
      weReg_ctrl_uWB_ID <= 1'h0; // @[ID_EXE.scala 44:34]
    end else if (!(io_stallStageID)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        weReg_ctrl_uWB_ID <= 1'h0;
      end else if (io_flushStageID) begin // @[Mux.scala 101:16]
        weReg_ctrl_uWB_ID <= 1'h0;
      end else begin
        weReg_ctrl_uWB_ID <= io_weReg_ctrl_uWB_ID;
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
  aluOP_ctrl_uEXE_ID = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  data1_ID = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  data2_ID = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  wRegAddr_ID = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  wMenData_ID = _RAND_4[31:0];
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

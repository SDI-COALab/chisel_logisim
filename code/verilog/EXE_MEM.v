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
  output [31:0] io_wMenData_MEM,
  output        io_weMEM_ctrl_uMEM_MEM,
  output        io_wRegDataSrc_ctrl_uMEM_MEM,
  output [1:0]  io_wrMemByteSelScr_ctrl_uMEM_MEM,
  output        io_memReadDataExt_ctrl_uMEM_MEM,
  output        io_weReg_ctrl_uWB_MEM,
  input         io_flushStageMEM,
  input         io_stallStageMEM,
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
  reg [31:0] wMenData_MEM; // @[EXE_MEM.scala 31:31]
  reg  weMEM_ctrl_uMEM_MEM; // @[EXE_MEM.scala 32:38]
  reg  wRegDataSrc_ctrl_uMEM_MEM; // @[EXE_MEM.scala 33:44]
  reg [1:0] wrMemByteSelScr_ctrl_uMEM_MEM; // @[EXE_MEM.scala 34:48]
  reg  memReadDataExt_ctrl_uMEM_MEM; // @[EXE_MEM.scala 35:47]
  reg  weReg_ctrl_uWB_MEM; // @[EXE_MEM.scala 36:37]
  assign io_aluResult_MEM = aluResult_MEM; // @[EXE_MEM.scala 80:22]
  assign io_wRegAddr_MEM = wRegAddr_MEM; // @[EXE_MEM.scala 81:21]
  assign io_wMenData_MEM = wMenData_MEM; // @[EXE_MEM.scala 82:21]
  assign io_weMEM_ctrl_uMEM_MEM = weMEM_ctrl_uMEM_MEM; // @[EXE_MEM.scala 83:28]
  assign io_wRegDataSrc_ctrl_uMEM_MEM = wRegDataSrc_ctrl_uMEM_MEM; // @[EXE_MEM.scala 84:34]
  assign io_wrMemByteSelScr_ctrl_uMEM_MEM = wrMemByteSelScr_ctrl_uMEM_MEM; // @[EXE_MEM.scala 85:38]
  assign io_memReadDataExt_ctrl_uMEM_MEM = memReadDataExt_ctrl_uMEM_MEM; // @[EXE_MEM.scala 86:37]
  assign io_weReg_ctrl_uWB_MEM = weReg_ctrl_uWB_MEM; // @[EXE_MEM.scala 87:27]
  always @(posedge clock) begin
    if (reset) begin // @[EXE_MEM.scala 29:32]
      aluResult_MEM <= 32'h0; // @[EXE_MEM.scala 29:32]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        aluResult_MEM <= 32'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        aluResult_MEM <= 32'h0;
      end else begin
        aluResult_MEM <= io_aluResult_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 30:31]
      wRegAddr_MEM <= 5'h0; // @[EXE_MEM.scala 30:31]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wRegAddr_MEM <= 5'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        wRegAddr_MEM <= 5'h0;
      end else begin
        wRegAddr_MEM <= io_wRegAddr_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 31:31]
      wMenData_MEM <= 32'h0; // @[EXE_MEM.scala 31:31]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wMenData_MEM <= 32'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        wMenData_MEM <= 32'h0;
      end else begin
        wMenData_MEM <= io_wMenData_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 32:38]
      weMEM_ctrl_uMEM_MEM <= 1'h0; // @[EXE_MEM.scala 32:38]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        weMEM_ctrl_uMEM_MEM <= 1'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        weMEM_ctrl_uMEM_MEM <= 1'h0;
      end else begin
        weMEM_ctrl_uMEM_MEM <= io_weMEM_ctrl_uMEM_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 33:44]
      wRegDataSrc_ctrl_uMEM_MEM <= 1'h0; // @[EXE_MEM.scala 33:44]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wRegDataSrc_ctrl_uMEM_MEM <= 1'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        wRegDataSrc_ctrl_uMEM_MEM <= 1'h0;
      end else begin
        wRegDataSrc_ctrl_uMEM_MEM <= io_wRegDataSrc_ctrl_uMEM_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 34:48]
      wrMemByteSelScr_ctrl_uMEM_MEM <= 2'h0; // @[EXE_MEM.scala 34:48]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wrMemByteSelScr_ctrl_uMEM_MEM <= 2'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        wrMemByteSelScr_ctrl_uMEM_MEM <= 2'h0;
      end else begin
        wrMemByteSelScr_ctrl_uMEM_MEM <= io_wrMemByteSelScr_ctrl_uMEM_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 35:47]
      memReadDataExt_ctrl_uMEM_MEM <= 1'h0; // @[EXE_MEM.scala 35:47]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        memReadDataExt_ctrl_uMEM_MEM <= 1'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        memReadDataExt_ctrl_uMEM_MEM <= 1'h0;
      end else begin
        memReadDataExt_ctrl_uMEM_MEM <= io_memReadDataExt_ctrl_uMEM_EXE;
      end
    end
    if (reset) begin // @[EXE_MEM.scala 36:37]
      weReg_ctrl_uWB_MEM <= 1'h0; // @[EXE_MEM.scala 36:37]
    end else if (!(io_stallStageMEM)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        weReg_ctrl_uWB_MEM <= 1'h0;
      end else if (io_flushStageMEM) begin // @[Mux.scala 101:16]
        weReg_ctrl_uWB_MEM <= 1'h0;
      end else begin
        weReg_ctrl_uWB_MEM <= io_weReg_ctrl_uWB_EXE;
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
  aluResult_MEM = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  wRegAddr_MEM = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  wMenData_MEM = _RAND_2[31:0];
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

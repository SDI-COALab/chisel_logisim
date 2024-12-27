module MEM_WB(
  input         clock,
  input         reset,
  input         io_flushStageWB,
  input         io_stallStageWB,
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
    end else if (!(io_stallStageWB)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wRegData <= 32'h0;
      end else if (io_flushStageWB) begin // @[Mux.scala 101:16]
        wRegData <= 32'h0;
      end else begin
        wRegData <= io_wRegData_MEM;
      end
    end
    if (reset) begin // @[MEM_WB.scala 20:27]
      wRegAddr <= 5'h0; // @[MEM_WB.scala 20:27]
    end else if (!(io_stallStageWB)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        wRegAddr <= 5'h0;
      end else if (io_flushStageWB) begin // @[Mux.scala 101:16]
        wRegAddr <= 5'h0;
      end else begin
        wRegAddr <= io_wRegAddr_MEM;
      end
    end
    if (reset) begin // @[MEM_WB.scala 21:33]
      weReg_ctrl_uWB <= 1'h0; // @[MEM_WB.scala 21:33]
    end else if (!(io_stallStageWB)) begin // @[Mux.scala 101:16]
      if (io_reset) begin // @[Mux.scala 101:16]
        weReg_ctrl_uWB <= 1'h0;
      end else if (io_flushStageWB) begin // @[Mux.scala 101:16]
        weReg_ctrl_uWB <= 1'h0;
      end else begin
        weReg_ctrl_uWB <= io_weReg_ctrl_uWB_MEM;
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

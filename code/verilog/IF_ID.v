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

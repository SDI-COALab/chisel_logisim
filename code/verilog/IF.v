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
  wire [31:0] PC_next = PC + 32'h4; // @[IF.scala 27:25]
  wire  _T_1 = ~reset; // @[IF.scala 36:11]
  wire [31:0] _instr_IF_T_1 = PC + 32'h3; // @[IF.scala 41:31]
  wire [31:0] _instr_IF_T_4 = PC + 32'h2; // @[IF.scala 41:58]
  wire [31:0] _instr_IF_T_7 = PC + 32'h1; // @[IF.scala 41:85]
  wire [15:0] instr_IF_lo = {mem_instr_IF_MPORT_2_data,mem_instr_IF_MPORT_3_data}; // @[Cat.scala 31:58]
  wire [15:0] instr_IF_hi = {mem_instr_IF_MPORT_data,mem_instr_IF_MPORT_1_data}; // @[Cat.scala 31:58]
  wire [31:0] instr_IF = {mem_instr_IF_MPORT_data,mem_instr_IF_MPORT_1_data,mem_instr_IF_MPORT_2_data,
    mem_instr_IF_MPORT_3_data}; // @[Cat.scala 31:58]
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
  assign io_PC_IF = PC; // @[IF.scala 44:14]
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
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"PC = %b\n",PC); // @[IF.scala 36:11]
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
          $fwrite(32'h80000002,"nextPC = %b\n",nextPC); // @[IF.scala 37:11]
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
          $fwrite(32'h80000002,"stallstageIF = %b\n",io_stallStageIF); // @[IF.scala 38:11]
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
          $fwrite(32'h80000002,"resetSignal = %b\n",io_reset); // @[IF.scala 39:11]
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
          $fwrite(32'h80000002,"instr_IF = %b\n",instr_IF); // @[IF.scala 42:11]
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

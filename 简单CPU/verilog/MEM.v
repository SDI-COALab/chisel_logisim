module MEM(
  input         clock,
  input         reset,
  input  [31:0] io_aluResult_MEM,
  input  [31:0] io_wMemData_MEM,
  input         io_weMEM_ctrl_uMEM_MEM,
  input         io_wRegDataSrc_ctrl_uMEM_MEM,
  input  [1:0]  io_wrMemByteSelScr_ctrl_uMEM_MEM,
  input         io_memReadDataExt_ctrl_uMEM_MEM,
  input         io_reset,
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
  wire [7:0] _DataB_T_4 = _typeB_T_3 ? mem_rdata2_data : 8'h0; // @[Mux.scala 101:16]
  wire [7:0] _DataB_T_5 = _typeB_T_2 ? mem_rdata1_data : _DataB_T_4; // @[Mux.scala 101:16]
  wire [7:0] _DataB_T_6 = _typeB_T_1 ? mem_rdata0_data : _DataB_T_5; // @[Mux.scala 101:16]
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

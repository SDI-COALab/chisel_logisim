module EXE(
  input         clock,
  input         reset,
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
  wire  _exe_alu_out_T_15 = io_aluOP_ctrl_uEXE_EXE == 4'ha; // @[EXE.scala 19:29]
  wire  _exe_alu_out_T_18 = io_aluOP_ctrl_uEXE_EXE == 4'h8; // @[EXE.scala 20:29]
  wire [31:0] _exe_alu_out_T_21 = _exe_alu_out_T_18 ? _exe_alu_out_T_2 : 32'h0; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_out_T_22 = _exe_alu_out_T_15 ? _exe_alu_out_T_5 : _exe_alu_out_T_21; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_out_T_23 = _exe_alu_out_T_11 ? {{31'd0}, _exe_alu_out_T_14} : _exe_alu_out_T_22; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_out_T_24 = _exe_alu_out_T_6 ? _exe_alu_out_T_10 : _exe_alu_out_T_23; // @[Mux.scala 101:16]
  wire [31:0] _exe_alu_out_T_25 = _exe_alu_out_T_3 ? _exe_alu_out_T_5 : _exe_alu_out_T_24; // @[Mux.scala 101:16]
  assign io_aluResult_EXE = _exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_25; // @[Mux.scala 101:16]
endmodule

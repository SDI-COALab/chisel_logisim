circuit EXE :
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

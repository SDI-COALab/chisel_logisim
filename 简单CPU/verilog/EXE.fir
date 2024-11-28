circuit EXE :
  module EXE :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip aluOP_ctrl_uEXE_EXE : UInt<4>, flip data1_EXE : UInt<32>, flip data2_EXE : UInt<32>, aluResult_EXE : UInt<32>}

    node _exe_alu_out_T = eq(io.aluOP_ctrl_uEXE_EXE, UInt<4>("h1")) @[EXE.scala 15:29]
    node _exe_alu_out_T_1 = add(io.data1_EXE, io.data2_EXE) @[EXE.scala 15:60]
    node _exe_alu_out_T_2 = tail(_exe_alu_out_T_1, 1) @[EXE.scala 15:60]
    node _exe_alu_out_T_3 = eq(io.aluOP_ctrl_uEXE_EXE, UInt<4>("h2")) @[EXE.scala 16:29]
    node _exe_alu_out_T_4 = bits(io.data2_EXE, 4, 0) @[EXE.scala 16:75]
    node _exe_alu_out_T_5 = dshr(io.data1_EXE, _exe_alu_out_T_4) @[EXE.scala 16:60]
    node _exe_alu_out_T_6 = eq(io.aluOP_ctrl_uEXE_EXE, UInt<4>("h3")) @[EXE.scala 17:29]
    node _exe_alu_out_T_7 = asSInt(io.data1_EXE) @[EXE.scala 17:66]
    node _exe_alu_out_T_8 = bits(io.data2_EXE, 4, 0) @[EXE.scala 17:84]
    node _exe_alu_out_T_9 = dshr(_exe_alu_out_T_7, _exe_alu_out_T_8) @[EXE.scala 17:69]
    node _exe_alu_out_T_10 = asUInt(_exe_alu_out_T_9) @[EXE.scala 17:97]
    node _exe_alu_out_T_11 = eq(io.aluOP_ctrl_uEXE_EXE, UInt<4>("h9")) @[EXE.scala 18:29]
    node _exe_alu_out_T_12 = asSInt(io.data1_EXE) @[EXE.scala 18:66]
    node _exe_alu_out_T_13 = asSInt(io.data2_EXE) @[EXE.scala 18:90]
    node _exe_alu_out_T_14 = lt(_exe_alu_out_T_12, _exe_alu_out_T_13) @[EXE.scala 18:69]
    node _exe_alu_out_T_15 = eq(io.aluOP_ctrl_uEXE_EXE, UInt<4>("ha")) @[EXE.scala 19:29]
    node _exe_alu_out_T_16 = bits(io.data2_EXE, 4, 0) @[EXE.scala 19:75]
    node _exe_alu_out_T_17 = dshr(io.data1_EXE, _exe_alu_out_T_16) @[EXE.scala 19:60]
    node _exe_alu_out_T_18 = eq(io.aluOP_ctrl_uEXE_EXE, UInt<4>("h8")) @[EXE.scala 20:29]
    node _exe_alu_out_T_19 = add(io.data1_EXE, io.data2_EXE) @[EXE.scala 20:60]
    node _exe_alu_out_T_20 = tail(_exe_alu_out_T_19, 1) @[EXE.scala 20:60]
    node _exe_alu_out_T_21 = mux(_exe_alu_out_T_18, _exe_alu_out_T_20, UInt<32>("h0")) @[Mux.scala 101:16]
    node _exe_alu_out_T_22 = mux(_exe_alu_out_T_15, _exe_alu_out_T_17, _exe_alu_out_T_21) @[Mux.scala 101:16]
    node _exe_alu_out_T_23 = mux(_exe_alu_out_T_11, _exe_alu_out_T_14, _exe_alu_out_T_22) @[Mux.scala 101:16]
    node _exe_alu_out_T_24 = mux(_exe_alu_out_T_6, _exe_alu_out_T_10, _exe_alu_out_T_23) @[Mux.scala 101:16]
    node _exe_alu_out_T_25 = mux(_exe_alu_out_T_3, _exe_alu_out_T_5, _exe_alu_out_T_24) @[Mux.scala 101:16]
    node exe_alu_out = mux(_exe_alu_out_T, _exe_alu_out_T_2, _exe_alu_out_T_25) @[Mux.scala 101:16]
    io.aluResult_EXE <= exe_alu_out @[EXE.scala 22:20]


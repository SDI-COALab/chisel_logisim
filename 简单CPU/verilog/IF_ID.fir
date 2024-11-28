circuit IF_ID :
  module IF_ID :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip PC_IF : UInt<32>, flip instr_IF : UInt<32>, flip flushStageID : UInt<1>, flip stallStageID : UInt<1>, flip reset : UInt<1>, PC_ID : UInt<32>, instr_ID : UInt<32>}

    reg PC_ID_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[IF_ID.scala 18:28]
    reg instr_ID_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[IF_ID.scala 19:31]
    node _PC_ID_reg_T = mux(io.flushStageID, UInt<1>("h0"), io.PC_IF) @[Mux.scala 101:16]
    node _PC_ID_reg_T_1 = mux(io.reset, UInt<32>("h0"), _PC_ID_reg_T) @[Mux.scala 101:16]
    node _PC_ID_reg_T_2 = mux(io.stallStageID, PC_ID_reg, _PC_ID_reg_T_1) @[Mux.scala 101:16]
    PC_ID_reg <= _PC_ID_reg_T_2 @[IF_ID.scala 24:15]
    node _instr_ID_reg_T = mux(io.flushStageID, UInt<1>("h0"), io.instr_IF) @[Mux.scala 101:16]
    node _instr_ID_reg_T_1 = mux(io.reset, UInt<32>("h0"), _instr_ID_reg_T) @[Mux.scala 101:16]
    node _instr_ID_reg_T_2 = mux(io.stallStageID, instr_ID_reg, _instr_ID_reg_T_1) @[Mux.scala 101:16]
    instr_ID_reg <= _instr_ID_reg_T_2 @[IF_ID.scala 31:18]
    io.PC_ID <= PC_ID_reg @[IF_ID.scala 37:14]
    io.instr_ID <= instr_ID_reg @[IF_ID.scala 38:17]


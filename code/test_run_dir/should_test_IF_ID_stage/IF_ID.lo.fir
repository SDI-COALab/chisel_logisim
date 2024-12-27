circuit IF_ID :
  module IF_ID :
    input clock : Clock
    input reset : UInt<1>
    input io_PC_IF : UInt<32>
    input io_instr_IF : UInt<32>
    input io_flushStageID : UInt<1>
    input io_stallStageID : UInt<1>
    input io_reset : UInt<1>
    output io_PC_ID : UInt<32>
    output io_instr_ID : UInt<32>

    reg PC_ID_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC_ID_reg) @[IF_ID.scala 18:28]
    reg instr_ID_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instr_ID_reg) @[IF_ID.scala 19:31]
    node _PC_ID_reg_T = mux(io_flushStageID, UInt<1>("h0"), io_PC_IF) @[Mux.scala 101:16]
    node _PC_ID_reg_T_1 = mux(io_reset, UInt<32>("h0"), _PC_ID_reg_T) @[Mux.scala 101:16]
    node _PC_ID_reg_T_2 = mux(io_stallStageID, PC_ID_reg, _PC_ID_reg_T_1) @[Mux.scala 101:16]
    node _instr_ID_reg_T = mux(io_flushStageID, UInt<1>("h0"), io_instr_IF) @[Mux.scala 101:16]
    node _instr_ID_reg_T_1 = mux(io_reset, UInt<32>("h0"), _instr_ID_reg_T) @[Mux.scala 101:16]
    node _instr_ID_reg_T_2 = mux(io_stallStageID, instr_ID_reg, _instr_ID_reg_T_1) @[Mux.scala 101:16]
    io_PC_ID <= PC_ID_reg @[IF_ID.scala 37:14]
    io_instr_ID <= instr_ID_reg @[IF_ID.scala 38:17]
    PC_ID_reg <= mux(reset, UInt<32>("h0"), _PC_ID_reg_T_2) @[IF_ID.scala 18:{28,28} 24:15]
    instr_ID_reg <= mux(reset, UInt<32>("h0"), _instr_ID_reg_T_2) @[IF_ID.scala 19:{31,31} 31:18]

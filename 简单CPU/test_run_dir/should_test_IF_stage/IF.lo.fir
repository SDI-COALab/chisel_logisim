circuit IF :
  module IF :
    input clock : Clock
    input reset : UInt<1>
    input io_stallStageIF : UInt<1>
    input io_branchTarget_ID : UInt<32>
    input io_branchFlag_ID : UInt<1>
    input io_reset : UInt<1>
    output io_PC_IF : UInt<32>
    output io_instr_IF : UInt<32>

    mem mem : @[IF.scala 22:18]
      data-type => UInt<8>
      depth => 128
      read-latency => 0
      write-latency => 1
      reader => instr_IF_MPORT
      reader => instr_IF_MPORT_1
      reader => instr_IF_MPORT_2
      reader => instr_IF_MPORT_3
      read-under-write => undefined
    reg PC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), PC) @[IF.scala 24:21]
    node _nextPC_T = add(PC, UInt<32>("h4")) @[IF.scala 28:32]
    node _nextPC_T_1 = tail(_nextPC_T, 1) @[IF.scala 28:32]
    node nextPC = mux(io_branchFlag_ID, io_branchTarget_ID, _nextPC_T_1) @[Mux.scala 101:16]
    node _PC_T = mux(io_branchFlag_ID, io_branchTarget_ID, nextPC) @[Mux.scala 101:16]
    node _PC_T_1 = mux(io_reset, UInt<32>("h0"), _PC_T) @[Mux.scala 101:16]
    node _PC_T_2 = mux(io_stallStageIF, PC, _PC_T_1) @[Mux.scala 101:16]
    node _instr_IF_T = add(PC, UInt<32>("h3")) @[IF.scala 38:31]
    node _instr_IF_T_1 = tail(_instr_IF_T, 1) @[IF.scala 38:31]
    node _instr_IF_T_2 = bits(_instr_IF_T_1, 6, 0) @[IF.scala 38:27]
    node _instr_IF_T_3 = add(PC, UInt<32>("h2")) @[IF.scala 38:58]
    node _instr_IF_T_4 = tail(_instr_IF_T_3, 1) @[IF.scala 38:58]
    node _instr_IF_T_5 = bits(_instr_IF_T_4, 6, 0) @[IF.scala 38:54]
    node _instr_IF_T_6 = add(PC, UInt<32>("h1")) @[IF.scala 38:85]
    node _instr_IF_T_7 = tail(_instr_IF_T_6, 1) @[IF.scala 38:85]
    node _instr_IF_T_8 = bits(_instr_IF_T_7, 6, 0) @[IF.scala 38:81]
    node _instr_IF_T_9 = bits(PC, 6, 0) @[IF.scala 38:108]
    node instr_IF_lo = cat(mem.instr_IF_MPORT_2.data, mem.instr_IF_MPORT_3.data) @[Cat.scala 31:58]
    node instr_IF_hi = cat(mem.instr_IF_MPORT.data, mem.instr_IF_MPORT_1.data) @[Cat.scala 31:58]
    node instr_IF = cat(instr_IF_hi, instr_IF_lo) @[Cat.scala 31:58]
    io_PC_IF <= PC @[IF.scala 40:14]
    io_instr_IF <= instr_IF @[IF.scala 41:17]
    mem.instr_IF_MPORT.addr <= _instr_IF_T_2 @[IF.scala 38:27]
    mem.instr_IF_MPORT.en <= UInt<1>("h1") @[IF.scala 38:27]
    mem.instr_IF_MPORT.clk <= clock @[IF.scala 38:27]
    mem.instr_IF_MPORT_1.addr <= _instr_IF_T_5 @[IF.scala 38:54]
    mem.instr_IF_MPORT_1.en <= UInt<1>("h1") @[IF.scala 38:54]
    mem.instr_IF_MPORT_1.clk <= clock @[IF.scala 38:54]
    mem.instr_IF_MPORT_2.addr <= _instr_IF_T_8 @[IF.scala 38:81]
    mem.instr_IF_MPORT_2.en <= UInt<1>("h1") @[IF.scala 38:81]
    mem.instr_IF_MPORT_2.clk <= clock @[IF.scala 38:81]
    mem.instr_IF_MPORT_3.addr <= _instr_IF_T_9 @[IF.scala 38:108]
    mem.instr_IF_MPORT_3.en <= UInt<1>("h1") @[IF.scala 38:108]
    mem.instr_IF_MPORT_3.clk <= clock @[IF.scala 38:108]
    PC <= mux(reset, UInt<32>("h0"), _PC_T_2) @[IF.scala 24:{21,21} 32:8]

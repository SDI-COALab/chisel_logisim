circuit PLC :
  module PLC :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip stallReqOfID : UInt<1>, flip flushReqOfID : UInt<1>, stallStageIF : UInt<1>, stallStageID : UInt<1>, flushStageID : UInt<1>, stallStageEXE : UInt<1>, flushStageEXE : UInt<1>, stallStageMEM : UInt<1>, flushStageMEM : UInt<1>, stallStageWB : UInt<1>, flushStageWB : UInt<1>}

    io.stallStageIF <= io.stallReqOfID @[PLC.scala 19:21]
    io.stallStageID <= io.stallReqOfID @[PLC.scala 20:21]
    node _io_flushStageID_T = not(io.stallReqOfID) @[PLC.scala 21:24]
    node _io_flushStageID_T_1 = and(_io_flushStageID_T, io.flushReqOfID) @[PLC.scala 21:41]
    io.flushStageID <= _io_flushStageID_T_1 @[PLC.scala 21:21]
    io.stallStageEXE <= UInt<1>("h0") @[PLC.scala 22:22]
    io.flushStageEXE <= io.stallReqOfID @[PLC.scala 23:22]
    io.stallStageMEM <= UInt<1>("h0") @[PLC.scala 24:22]
    io.flushStageMEM <= UInt<1>("h0") @[PLC.scala 25:22]
    io.stallStageWB <= UInt<1>("h0") @[PLC.scala 26:21]
    io.flushStageWB <= UInt<1>("h0") @[PLC.scala 27:21]


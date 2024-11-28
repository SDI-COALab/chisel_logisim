module PLC(
  input   clock,
  input   reset,
  input   io_stallReqOfID,
  input   io_flushReqOfID,
  output  io_stallStageIF,
  output  io_stallStageID,
  output  io_flushStageID,
  output  io_stallStageEXE,
  output  io_flushStageEXE,
  output  io_stallStageMEM,
  output  io_flushStageMEM,
  output  io_stallStageWB,
  output  io_flushStageWB
);
  assign io_stallStageIF = io_stallReqOfID; // @[PLC.scala 19:21]
  assign io_stallStageID = io_stallReqOfID; // @[PLC.scala 20:21]
  assign io_flushStageID = ~io_stallReqOfID & io_flushReqOfID; // @[PLC.scala 21:41]
  assign io_stallStageEXE = 1'h0; // @[PLC.scala 22:22]
  assign io_flushStageEXE = io_stallReqOfID; // @[PLC.scala 23:22]
  assign io_stallStageMEM = 1'h0; // @[PLC.scala 24:22]
  assign io_flushStageMEM = 1'h0; // @[PLC.scala 25:22]
  assign io_stallStageWB = 1'h0; // @[PLC.scala 26:21]
  assign io_flushStageWB = 1'h0; // @[PLC.scala 27:21]
endmodule

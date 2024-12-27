import chisel3._ 
import chisel3.util._ 
import common.Instructions._ 
import common.Consts._ 

class ID_EXE extends Module { 
  val io = IO(new Bundle {
    val flushStageID = Input(Bool())
    val stallStageID = Input(Bool())
    val reset = Input(Bool())
    val aluOP_ctrl_uEXE_ID = Input(UInt(OP.W)) 
    val data1_ID = Input(UInt(WORD_LEN.W)) 
    val data2_ID = Input(UInt(WORD_LEN.W))
    val wRegAddr_ID = Input(UInt(ADD_LEN.W))
    val wMemData_ID = Input(UInt(WORD_LEN.W))
    val weMEM_ctrl_uMEM_ID = Input(Bool())
    val wRegDataSrc_ctrl_uMEM_ID = Input(Bool())
    val wrMemByteSelScr_ctrl_uMEM_ID = Input(UInt(2.W))
    val memReadDataExt_ctrl_uMEM_ID = Input(Bool())
    val weReg_ctrl_uWB_ID = Input(Bool())
    val aluOP_ctrl_uID_EXE = Output(UInt(OP.W)) 
    val data1_EXE = Output(UInt(WORD_LEN.W)) 
    val data2_EXE = Output(UInt(WORD_LEN.W))
    val wRegAddr_EXE = Output(UInt(ADD_LEN.W))
    val wMemData_EXE = Output(UInt(WORD_LEN.W))
    val weMEM_ctrl_uMEM_EXE = Output(Bool())
    val wRegDataSrc_ctrl_uMEM_EXE = Output(Bool())
    val wrMemByteSelScr_ctrl_uMEM_EXE = Output(UInt(2.W))
    val memReadDataExt_ctrl_uMEM_EXE = Output(Bool())
    val weReg_ctrl_uWB_EXE = Output(Bool())
  })
  val flush = io.flushStageID
  val stall = io.stallStageID
  val resetSignal = io.reset
  val aluOP_ctrl_uEXE_ID = RegInit(0.U(OP.W)) 
  val data1_ID = RegInit(0.U(WORD_LEN.W)) 
  val data2_ID = RegInit(0.U(WORD_LEN.W))
  val wRegAddr_ID = RegInit(0.U(ADD_LEN.W))
  val wMemData_ID = RegInit(0.U(WORD_LEN.W))
  val weMEM_ctrl_uMEM_ID = RegInit(false.B)
  val wRegDataSrc_ctrl_uMEM_ID = RegInit(false.B)
  val wrMemByteSelScr_ctrl_uMEM_ID = RegInit(0.U(2.W))
  val memReadDataExt_ctrl_uMEM_ID = RegInit(false.B)
  val weReg_ctrl_uWB_ID = RegInit(false.B)

  aluOP_ctrl_uEXE_ID := MuxCase(io.aluOP_ctrl_uEXE_ID, Seq(
    stall -> aluOP_ctrl_uEXE_ID,
    resetSignal -> 0.U,
    flush -> 0.U
  ))
  data1_ID := MuxCase(io.data1_ID, Seq(
    stall -> data1_ID,
    resetSignal -> 0.U,
    flush -> 0.U
  ))
  
  data2_ID := MuxCase(io.data2_ID,Seq(
    stall -> data2_ID,
    resetSignal -> 0.U,
    flush -> 0.U
  ))
  wRegAddr_ID := MuxCase(io.wRegAddr_ID, Seq(
    stall -> wRegAddr_ID,
    resetSignal -> 0.U,
    flush -> 0.U
  ))
  wMemData_ID := MuxCase(io.wMemData_ID, Seq(
    stall -> wMemData_ID,
    resetSignal -> 0.U,
    flush -> 0.U
  ))
  weMEM_ctrl_uMEM_ID := MuxCase(io.weMEM_ctrl_uMEM_ID, Seq(
    stall -> weMEM_ctrl_uMEM_ID,
    resetSignal -> false.B,
    flush -> false.B
  ))
  wRegDataSrc_ctrl_uMEM_ID := MuxCase(io.wRegDataSrc_ctrl_uMEM_ID, Seq(
    stall -> wRegDataSrc_ctrl_uMEM_ID,
    resetSignal -> false.B,
    flush -> false.B
  ))
  wrMemByteSelScr_ctrl_uMEM_ID := MuxCase(io.wrMemByteSelScr_ctrl_uMEM_ID, Seq(
    stall -> wrMemByteSelScr_ctrl_uMEM_ID,
    resetSignal -> 0.U,
    flush -> 0.U
  ))
  memReadDataExt_ctrl_uMEM_ID := MuxCase(io.memReadDataExt_ctrl_uMEM_ID, Seq(
    stall -> memReadDataExt_ctrl_uMEM_ID,
    resetSignal -> false.B,
    flush -> false.B
  ))
  weReg_ctrl_uWB_ID := MuxCase(io.weReg_ctrl_uWB_ID, Seq(
    stall -> weReg_ctrl_uWB_ID,
    resetSignal -> false.B,
    flush -> false.B
  ))
  io.aluOP_ctrl_uID_EXE := aluOP_ctrl_uEXE_ID
  io.data1_EXE := data1_ID
  io.data2_EXE := data2_ID
  io.wRegAddr_EXE := wRegAddr_ID
  io.wMemData_EXE := wMemData_ID
  io.weMEM_ctrl_uMEM_EXE := weMEM_ctrl_uMEM_ID
  io.wRegDataSrc_ctrl_uMEM_EXE := wRegDataSrc_ctrl_uMEM_ID
  io.wrMemByteSelScr_ctrl_uMEM_EXE := wrMemByteSelScr_ctrl_uMEM_ID
  io.memReadDataExt_ctrl_uMEM_EXE := memReadDataExt_ctrl_uMEM_ID
  io.weReg_ctrl_uWB_EXE := weReg_ctrl_uWB_ID
}

object ID_EXE extends App{
    emitVerilog(new ID_EXE(), Array("--target-dir", "verilog"))
}
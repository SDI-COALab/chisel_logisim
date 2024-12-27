import chisel3._ 
import chisel3.util._
import common.Instructions._
import common.Consts._

class EXE_MEM extends Module {
    val io = IO(new Bundle {
        val aluResult_EXE = Input(UInt(WORD_LEN.W)) 
        val wRegAddr_EXE = Input(UInt(ADD_LEN.W)) 
        val wMemData_EXE = Input(UInt(WORD_LEN.W))
        val weMEM_ctrl_uMEM_EXE = Input(Bool())
        val wRegDataSrc_ctrl_uMEM_EXE = Input(Bool())
        val wrMemByteSelScr_ctrl_uMEM_EXE = Input(UInt(2.W))
        val memReadDataExt_ctrl_uMEM_EXE = Input(Bool())
        val weReg_ctrl_uWB_EXE = Input(Bool())
        val flushStageMEM = Input(Bool())
        val stallStageMEM = Input(Bool())
        val reset = Input(Bool())
        val aluResult_MEM = Output(UInt(WORD_LEN.W))
        val wRegAddr_MEM = Output(UInt(ADD_LEN.W))
        val wMemData_MEM = Output(UInt(WORD_LEN.W))
        val weMEM_ctrl_uMEM_MEM = Output(Bool())
        val wRegDataSrc_ctrl_uMEM_MEM = Output(Bool())
        val wrMemByteSelScr_ctrl_uMEM_MEM = Output(UInt(2.W))
        val memReadDataExt_ctrl_uMEM_MEM = Output(Bool())
        val weReg_ctrl_uWB_MEM = Output(Bool())
    })

    val aluResult_MEM = RegInit(0.U(WORD_LEN.W))
    val wRegAddr_MEM = RegInit(0.U(ADD_LEN.W))
    val wMemData_MEM = RegInit(0.U(WORD_LEN.W))
    val weMEM_ctrl_uMEM_MEM = RegInit(false.B)
    val wRegDataSrc_ctrl_uMEM_MEM = RegInit(false.B)
    val wrMemByteSelScr_ctrl_uMEM_MEM = RegInit(0.U(2.W))
    val memReadDataExt_ctrl_uMEM_MEM = RegInit(false.B)
    val weReg_ctrl_uWB_MEM = RegInit(false.B)
    val flush = io.flushStageMEM
    val stall = io.stallStageMEM
    val resetSignal = io.reset
    aluResult_MEM := MuxCase(io.aluResult_EXE, Seq(
        stall -> aluResult_MEM,
        resetSignal -> 0.U,
        flush -> 0.U
    ))
    wRegAddr_MEM := MuxCase(io.wRegAddr_EXE, Seq(
        stall -> wRegAddr_MEM,
        resetSignal -> 0.U,
        flush -> 0.U
    ))
    wMemData_MEM := MuxCase(io.wMemData_EXE, Seq(
        stall -> wMemData_MEM,
        resetSignal -> 0.U,
        flush -> 0.U
    ))
    weMEM_ctrl_uMEM_MEM := MuxCase(io.weMEM_ctrl_uMEM_EXE, Seq(
        stall -> weMEM_ctrl_uMEM_MEM,
        resetSignal -> false.B,
        flush -> false.B
    ))
    wRegDataSrc_ctrl_uMEM_MEM := MuxCase(io.wRegDataSrc_ctrl_uMEM_EXE, Seq(
        stall -> wRegDataSrc_ctrl_uMEM_MEM,
        resetSignal -> false.B,
        flush -> false.B
    ))
    wrMemByteSelScr_ctrl_uMEM_MEM := MuxCase(io.wrMemByteSelScr_ctrl_uMEM_EXE, Seq(
        stall -> wrMemByteSelScr_ctrl_uMEM_MEM,
        resetSignal -> 0.U,
        flush -> 0.U
    ))
    memReadDataExt_ctrl_uMEM_MEM := MuxCase(io.memReadDataExt_ctrl_uMEM_EXE, Seq(
        stall -> memReadDataExt_ctrl_uMEM_MEM,
        resetSignal -> false.B,
        flush -> false.B
    ))
    weReg_ctrl_uWB_MEM := MuxCase(io.weReg_ctrl_uWB_EXE, Seq(
        stall -> weReg_ctrl_uWB_MEM,
        resetSignal -> false.B,
        flush -> false.B
    ))
    io.aluResult_MEM := aluResult_MEM
    io.wRegAddr_MEM := wRegAddr_MEM
    io.wMemData_MEM := wMemData_MEM
    io.weMEM_ctrl_uMEM_MEM := weMEM_ctrl_uMEM_MEM
    io.wRegDataSrc_ctrl_uMEM_MEM := wRegDataSrc_ctrl_uMEM_MEM
    io.wrMemByteSelScr_ctrl_uMEM_MEM := wrMemByteSelScr_ctrl_uMEM_MEM
    io.memReadDataExt_ctrl_uMEM_MEM := memReadDataExt_ctrl_uMEM_MEM
    io.weReg_ctrl_uWB_MEM := weReg_ctrl_uWB_MEM
}

object EXE_MEM extends App{
    emitVerilog(new EXE_MEM(), Array("--target-dir", "verilog"))
}

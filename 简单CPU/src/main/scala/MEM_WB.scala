import chisel3._ 
import chisel3.util._ 
import common.Instructions._ 
import common.Consts._ 

class MEM_WB extends Module {
    val io = IO(new Bundle {
        val flushStageWB = Input(Bool())
        val stallStageWB = Input(Bool())
        val reset = Input(Bool())
        val wRegData_MEM = Input(UInt(WORD_LEN.W)) 
        val wRegAddr_MEM = Input(UInt(ADD_LEN.W)) 
        val weReg_ctrl_uWB_MEM = Input(Bool())
        val wRegData_WB = Output(UInt(WORD_LEN.W))
        val wRegAddr_WB = Output(UInt(ADD_LEN.W))
        val weReg_ctrl_uWB_WB = Output(Bool())
    })

    val wRegData = RegInit(0.U(WORD_LEN.W))
    val wRegAddr = RegInit(0.U(ADD_LEN.W))
    val weReg_ctrl_uWB = RegInit(false.B)
    val flush = io.flushStageWB
    val stall = io.stallStageWB
    val resetSignal = io.reset

    wRegData := MuxCase(io.wRegData_MEM, Seq(
        stall -> wRegData,
        resetSignal -> 0.U,
        flush -> 0.U
    ))
    wRegAddr := MuxCase(io.wRegAddr_MEM, Seq(
        stall -> wRegAddr,
        resetSignal -> 0.U,
        flush -> 0.U
    ))
    weReg_ctrl_uWB := MuxCase(io.weReg_ctrl_uWB_MEM, Seq(
        stall -> weReg_ctrl_uWB,
        resetSignal -> false.B,
        flush -> false.B
    ))

    io.wRegData_WB := wRegData
    io.wRegAddr_WB := wRegAddr
    io.weReg_ctrl_uWB_WB := weReg_ctrl_uWB
}

object MEM_WB extends App{
    emitVerilog(new MEM_WB(), Array("--target-dir", "verilog"))
}
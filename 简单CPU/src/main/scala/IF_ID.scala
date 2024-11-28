
import chisel3._ 
import chisel3.util._ 
import common.Instructions._ 
import common.Consts._ 

class IF_ID extends Module{
    val io = IO(new Bundle {
        val PC_IF = Input(UInt(WORD_LEN.W))
        val instr_IF = Input(UInt(WORD_LEN.W))
        val flushStageID = Input(Bool())
        val stallStageID = Input(Bool())
        val reset = Input(Bool())
        val PC_ID = Output(UInt(WORD_LEN.W))
        val instr_ID = Output(UInt(WORD_LEN.W))
    })

    val PC_ID_reg = RegInit(0.U(WORD_LEN.W))
    val instr_ID_reg = RegInit(0.U(WORD_LEN.W))
    val flush = io.flushStageID
    val stall = io.stallStageID
    val restSignal = io.reset

    PC_ID_reg := MuxCase(io.PC_IF, Seq(
        stall -> PC_ID_reg,
        restSignal -> START_ADDR,
        flush -> 0.U
    ))


    instr_ID_reg := MuxCase(io.instr_IF, Seq(
        stall -> instr_ID_reg,
        restSignal -> START_ADDR,
        flush -> 0.U
    ))

    io.PC_ID := PC_ID_reg
    io.instr_ID := instr_ID_reg
}

object IF_ID extends App{
    emitVerilog(new IF_ID(), Array("--target-dir", "verilog"))
}

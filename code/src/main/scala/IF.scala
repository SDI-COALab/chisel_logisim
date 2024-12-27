import chisel3._ 
import chisel3.util._ 
import common.Instructions._ 
import common.Consts._ 
import chisel3.util.experimental.loadMemoryFromFile

class IF extends Module{
    val io = IO(new Bundle {
        val stallStageIF = Input(Bool())
        val branchTarget_ID = Input(UInt(WORD_LEN.W))
        val branchFlag_ID = Input(Bool())
        val reset = Input(Bool())
        val PC_IF = Output(UInt(WORD_LEN.W))
        val instr_IF = Output(UInt(WORD_LEN.W))
    })
    
    val stallStageIF = io.stallStageIF
    val branchTarget = io.branchTarget_ID
    val branchFlag   = io.branchFlag_ID
    val resetSignal  = io.reset

    val mem = Mem(128, UInt(8.W))
    loadMemoryFromFile(mem, "src/loong/loong_core1.hex")
    val PC = RegInit(START_ADDR)
    
    val PC_IF = PC

    val nextPC = MuxCase(PC_IF + 4.U(WORD_LEN.W), Seq(
        branchFlag -> branchTarget
    ))

    PC := MuxCase(nextPC, Seq(
        stallStageIF -> PC,
        resetSignal -> START_ADDR,
        branchFlag -> branchTarget
    ))
    
    val instr_IF = Cat(mem(PC + 3.U(WORD_LEN.W)), mem(PC + 2.U(WORD_LEN.W)), mem(PC + 1.U(WORD_LEN.W)), mem(PC))

    io.PC_IF := PC_IF
    io.instr_IF := instr_IF
    
    // printf(p"PC_IF: ${Hexadecimal(PC_IF)}\n")
    // printf(p"instr_IF: ${Hexadecimal(instr_IF)}\n")
    // printf(p"nextPC: ${Hexadecimal(nextPC)}\n")
}

object IF extends App{
    emitVerilog(new IF(), Array("--target-dir", "verilog"))
}

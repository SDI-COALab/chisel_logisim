import chisel3._ 
import chisel3.util._ 
import common.Instructions._ 
import common.Consts._ 

class EXE extends Module { 
  val io = IO(new Bundle {
    val aluOP_ctrl_uEXE_EXE = Input(UInt(OP.W)) 
    val data1_EXE = Input(UInt(32.W)) 
    val data2_EXE = Input(UInt(32.W))  
    val aluResult_EXE = Output(UInt(32.W)) 
  })

  val exe_alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
    (io.aluOP_ctrl_uEXE_EXE === ALU_ADD)  -> (io.data1_EXE + io.data2_EXE),
    (io.aluOP_ctrl_uEXE_EXE === ALU_SRL)  -> (io.data1_EXE >> io.data2_EXE(4,0)),
    (io.aluOP_ctrl_uEXE_EXE === ALU_SRA)  -> (io.data1_EXE.asSInt() >> io.data2_EXE(4,0)).asUInt(),
    (io.aluOP_ctrl_uEXE_EXE === ALU_SLTI) -> (io.data1_EXE.asSInt() < io.data2_EXE.asSInt())
  ))
  io.aluResult_EXE := exe_alu_out
}

object EXE extends App{
    emitVerilog(new EXE(), Array("--target-dir", "verilog"))
}





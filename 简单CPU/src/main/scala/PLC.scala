import chisel3._ 
import chisel3.util._ 

class PLC extends Module {
    val io = IO(new Bundle {
        val stallReqOfID = Input(Bool())
        val flushReqOfID = Input(Bool())
        val stallStageIF = Output(Bool())
        val stallStageID = Output(Bool())
        val flushStageID = Output(Bool())
        val stallStageEXE = Output(Bool())
        val flushStageEXE = Output(Bool())
        val stallStageMEM = Output(Bool())
        val flushStageMEM = Output(Bool())
        val stallStageWB = Output(Bool())
        val flushStageWB = Output(Bool())
    })

    io.stallStageIF := io.stallReqOfID
    io.stallStageID := io.stallReqOfID
    io.flushStageID := ~io.stallReqOfID & io.flushReqOfID
    io.stallStageEXE := false.B
    io.flushStageEXE := io.stallReqOfID
    io.stallStageMEM := false.B
    io.flushStageMEM := false.B
    io.stallStageWB := false.B
    io.flushStageWB := false.B

}

object PLC extends App{
    emitVerilog(new PLC(), Array("--target-dir", "verilog"))
}

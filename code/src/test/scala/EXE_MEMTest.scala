import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class EXE_MEMTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test EXE_MEM stage" in {
    test(new EXE_MEM) { c =>
        // Set up the inputs
        c.io.aluResult_EXE.poke(10.U)
        c.io.wRegAddr_EXE.poke(10.U)
        c.io.wMemData_EXE.poke(10.U)
        c.io.weMEM_ctrl_uMEM_EXE.poke(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_EXE.poke(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_EXE.poke(2.U)
        c.io.memReadDataExt_ctrl_uMEM_EXE.poke(false.B)
        c.io.weReg_ctrl_uWB_EXE.poke(false.B)
        c.io.flushStageMEM.poke(false.B)
        c.io.stallStageMEM.poke(false.B)
        c.io.reset.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.aluResult_MEM.expect(10.U)
        c.io.wRegAddr_MEM.expect(10.U)
        c.io.wMemData_MEM.expect(10.U)
        c.io.weMEM_ctrl_uMEM_MEM.expect(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_MEM.expect(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_MEM.expect(2.U)
        c.io.memReadDataExt_ctrl_uMEM_MEM.expect(false.B)
        c.io.weReg_ctrl_uWB_MEM.expect(false.B)

        // Set up the inputs
        c.io.aluResult_EXE.poke(20.U)
        c.io.wRegAddr_EXE.poke(20.U)
        c.io.wMemData_EXE.poke(20.U)
        c.io.weMEM_ctrl_uMEM_EXE.poke(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_EXE.poke(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_EXE.poke(2.U)
        c.io.memReadDataExt_ctrl_uMEM_EXE.poke(false.B)
        c.io.weReg_ctrl_uWB_EXE.poke(false.B)
        c.io.flushStageMEM.poke(false.B)
        c.io.stallStageMEM.poke(true.B)
        c.io.reset.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.aluResult_MEM.expect(10.U)
        c.io.wRegAddr_MEM.expect(10.U)
        c.io.wMemData_MEM.expect(10.U)
        c.io.weMEM_ctrl_uMEM_MEM.expect(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_MEM.expect(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_MEM.expect(2.U)
        c.io.memReadDataExt_ctrl_uMEM_MEM.expect(false.B)
        c.io.weReg_ctrl_uWB_MEM.expect(false.B)

    }
  }
}
// sbt "testOnly *EXE_MEMTest"
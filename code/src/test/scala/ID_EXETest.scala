import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ID_EXETest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test ID_EXE stage" in {
    test(new ID_EXE) { c =>
        c.io.flushStageID.poke(false.B)
        c.io.stallStageID.poke(false.B)
        c.io.reset.poke(false.B)
        c.io.aluOP_ctrl_uEXE_ID.poke(10.U)
        c.io.data1_ID.poke(10.U)
        c.io.data2_ID.poke(10.U)
        c.io.wRegAddr_ID.poke(10.U)
        c.io.wMemData_ID.poke(10.U)
        c.io.weMEM_ctrl_uMEM_ID.poke(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_ID.poke(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_ID.poke(2.U)
        c.io.memReadDataExt_ctrl_uMEM_ID.poke(false.B)
        c.io.weReg_ctrl_uWB_ID.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.aluOP_ctrl_uID_EXE.expect(10.U)
        c.io.data1_EXE.expect(10.U)
        c.io.data2_EXE.expect(10.U)
        c.io.wRegAddr_EXE.expect(10.U)
        c.io.wMemData_EXE.expect(10.U)
        c.io.weMEM_ctrl_uMEM_EXE.expect(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_EXE.expect(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_EXE.expect(2.U)
        c.io.memReadDataExt_ctrl_uMEM_EXE.expect(false.B)
        c.io.weReg_ctrl_uWB_EXE.expect(false.B)
    }
  }
}
// sbt "testOnly *ID_EXETest"
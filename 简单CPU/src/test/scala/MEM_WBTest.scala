import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MEM_WBTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test MEM_WB stage" in {
    test(new MEM_WB) { c =>
        // Set up the inputs
        c.io.flushStageWB.poke(false.B)
        c.io.stallStageWB.poke(false.B)
        c.io.reset.poke(false.B)
        c.io.wRegData_MEM.poke(10.U)
        c.io.wRegAddr_MEM.poke(10.U)
        c.io.weReg_ctrl_uWB_MEM.poke(false.B)
        
        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.wRegData_WB.expect(10.U)
        c.io.wRegAddr_WB.expect(10.U)
        c.io.weReg_ctrl_uWB_WB.expect(false.B)
    }
  }
}
// sbt "testOnly *MEM_WBTest"
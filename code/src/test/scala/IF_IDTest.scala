import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IF_IDTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test IF_ID stage" in {
    test(new IF_ID) { c =>
        // Initialize the inputs
        c.io.PC_IF.poke(8.U)
        c.io.instr_IF.poke("b00000010100000000001000000000001".U)
        c.io.flushStageID.poke(false.B)
        c.io.stallStageID.poke(false.B)
        c.io.reset.poke(false.B)

        // Step the clock
        c.clock.step(1)

        // Check the outputs
        c.io.PC_ID.expect(8.U)
        c.io.instr_ID.expect("b00000010100000000001000000000001".U)
    }
  }
}
// sbt "testOnly *IF_IDTest"
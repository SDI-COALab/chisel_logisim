import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IFTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test IF stage" in {
    test(new IF) { c =>
        // Set up the inputs
        c.io.stallStageIF.poke(false.B)
        c.io.branchTarget_ID.poke(0.U)
        c.io.branchFlag_ID.poke(false.B)
        c.io.reset.poke(true.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.PC_IF.expect(0.U)
        c.io.instr_IF.expect(0x02800401.U)
        
        // Set up the inputs
        c.io.stallStageIF.poke(false.B)
        c.io.branchTarget_ID.poke(0.U)
        c.io.branchFlag_ID.poke(false.B)
        c.io.reset.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.PC_IF.expect(4.U)
        c.io.instr_IF.expect(0x02800802.U)

        // Set up the inputs
        c.io.stallStageIF.poke(false.B)
        c.io.branchTarget_ID.poke(0.U)
        c.io.branchFlag_ID.poke(false.B)
        c.io.reset.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.PC_IF.expect(8.U)
        c.io.instr_IF.expect(0x02800c03.U)

        // Set up the inputs
        c.io.stallStageIF.poke(true.B)
        c.io.branchTarget_ID.poke(0.U)
        c.io.branchFlag_ID.poke(false.B)
        c.io.reset.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.PC_IF.expect(8.U)
        c.io.instr_IF.expect(0x02800c03.U)
        
        // Set up the inputs
        c.io.stallStageIF.poke(false.B)
        c.io.branchTarget_ID.poke(20.U)
        c.io.branchFlag_ID.poke(true.B)
        c.io.reset.poke(false.B)

        // Step the circuit
        c.clock.step()

        // Check the outputs
        c.io.PC_IF.expect(20.U)
        c.io.instr_IF.expect(0x02801405.U)
    }
  }
}

// sbt "testOnly *IFTest"
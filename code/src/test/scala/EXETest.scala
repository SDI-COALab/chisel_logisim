import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class EXETest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test EXE stage" in {
    test(new EXE) { c =>
        // Test ALU_ADD
        c.io.aluOP_ctrl_uEXE_EXE.poke(1.U)
        c.io.data1_EXE.poke(10.U)
        c.io.data2_EXE.poke(20.U)
        c.clock.step()
        c.io.aluResult_EXE.expect(30.U)

        // Test ALU_SRL
        c.io.aluOP_ctrl_uEXE_EXE.poke(2.U)
        c.io.data1_EXE.poke(16.U)
        c.io.data2_EXE.poke(2.U)
        c.clock.step()
        c.io.aluResult_EXE.expect(4.U)

        // Test ALU_SRA
        c.io.aluOP_ctrl_uEXE_EXE.poke(3.U)
        c.io.data1_EXE.poke(16.U)
        c.io.data2_EXE.poke(2.U)
        c.clock.step()
        c.io.aluResult_EXE.expect(4.U)

        // Test ALU_SLTI
        c.io.aluOP_ctrl_uEXE_EXE.poke(9.U)
        c.io.data1_EXE.poke(10.U)
        c.io.data2_EXE.poke(20.U)
        c.clock.step()
        c.io.aluResult_EXE.expect(true.B)
    }
  }
}
// sbt "testOnly *EXETest"
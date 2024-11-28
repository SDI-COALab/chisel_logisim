import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IDTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test ID stage" in {
    test(new ID) { c =>
      // Initialize the inputs
      c.io.PC_ID.poke(0.U)
      c.io.instr_ID.poke("b00000010100000000000010000000001".U)
      c.io.reset.poke(false.B)
      c.io.wRegAddr_EXE.poke(0.U)
      c.io.wRegAddr_MEM.poke(0.U)
      c.io.aluResult_EXE.poke(0.U)
      c.io.wRegData_MEM.poke(0.U)
      c.io.wRegDataSrc_ctrl_uMEM_EXE.poke(false.B)
      c.io.wReg_ctrl_WB.poke(false.B)
      c.io.wRegaddr_WB.poke(0.U)
      c.io.wRegData_WB.poke(0.U)

      // Step the clock
      c.clock.step(1)

      // Check the outputs
      c.io.data1_ID.expect(0.U)
      c.io.data2_ID.expect(1.U)
      c.io.wRegAddr_ID.expect(1.U)
      c.io.wMemData_ID.expect(0.U)
      c.io.branchTarge_ID.expect(1.U)
      c.io.branchFlag_ID.expect(false.B)
      c.io.stallReqOfID_ID.expect(false.B)
      c.io.flushReqOfID_ID.expect(false.B)
      c.io.weReg_ctrl_uWB_ID.expect(true.B)
      c.io.memReadDataExt_ctrl_uMEM_ID.expect(false.B)
      c.io.wrMemByteSelScr_ctrl_uMEM_ID.expect(0.U)
      c.io.wRegDataSrc_ctrl_uMEM_ID.expect(false.B)
      c.io.weMEM_ctrl_uMEM_ID.expect(false.B)
      c.io.aluOP_ctrl_uEXE_ID.expect(1.U)

      // Initialize the inputs
      c.io.PC_ID.poke(12.U)
      c.io.instr_ID.poke(0x02801004.U)
      c.io.reset.poke(false.B)
      c.io.wRegAddr_EXE.poke(3.U)
      c.io.wRegAddr_MEM.poke(2.U)
      c.io.aluResult_EXE.poke(3.U)
      c.io.wRegData_MEM.poke(2.U)
      c.io.wRegDataSrc_ctrl_uMEM_EXE.poke(false.B)
      c.io.wReg_ctrl_WB.poke(true.B)
      c.io.wRegaddr_WB.poke(1.U)
      c.io.wRegData_WB.poke(1.U)

      // Step the clock
      c.clock.step(1)

      // Check the outputs
      c.io.data1_ID.expect(0.U)
      c.io.data2_ID.expect(4.U)
      c.io.wRegAddr_ID.expect(4.U)
      c.io.wMemData_ID.expect(0.U)
      c.io.branchTarge_ID.expect(16.U)
      c.io.branchFlag_ID.expect(false.B)
      c.io.stallReqOfID_ID.expect(false.B)
      c.io.flushReqOfID_ID.expect(false.B)
      c.io.weReg_ctrl_uWB_ID.expect(true.B)
      c.io.memReadDataExt_ctrl_uMEM_ID.expect(false.B)
      c.io.wrMemByteSelScr_ctrl_uMEM_ID.expect(0.U)
      c.io.wRegDataSrc_ctrl_uMEM_ID.expect(false.B)
      c.io.weMEM_ctrl_uMEM_ID.expect(false.B)
      c.io.aluOP_ctrl_uEXE_ID.expect(1.U)

      // Initialize the inputs
      c.io.PC_ID.poke(16.U)
      c.io.instr_ID.poke(0x4c001885.U)
      c.io.reset.poke(false.B)
      c.io.wRegAddr_EXE.poke(4.U)
      c.io.wRegAddr_MEM.poke(3.U)
      c.io.aluResult_EXE.poke(4.U)
      c.io.wRegData_MEM.poke(3.U)
      c.io.wRegDataSrc_ctrl_uMEM_EXE.poke(false.B)
      c.io.wReg_ctrl_WB.poke(true.B)
      c.io.wRegaddr_WB.poke(2.U)
      c.io.wRegData_WB.poke(2.U)

      // Step the clock
      c.clock.step(1)

      // Check the outputs
      c.io.data1_ID.expect(16.U)
      c.io.data2_ID.expect(4.U)
      c.io.wRegAddr_ID.expect(5.U)
      c.io.wMemData_ID.expect(0.U)
      c.io.branchTarge_ID.expect(28.U)
      c.io.branchFlag_ID.expect(true.B)
      c.io.stallReqOfID_ID.expect(false.B)
      c.io.flushReqOfID_ID.expect(true.B)
      c.io.weReg_ctrl_uWB_ID.expect(true.B)
      c.io.memReadDataExt_ctrl_uMEM_ID.expect(false.B)
      c.io.wrMemByteSelScr_ctrl_uMEM_ID.expect(0.U)
      c.io.wRegDataSrc_ctrl_uMEM_ID.expect(false.B)
      c.io.weMEM_ctrl_uMEM_ID.expect(false.B)
      c.io.aluOP_ctrl_uEXE_ID.expect(1.U)
    }
  }
}
// sbt "testOnly *IDTest"
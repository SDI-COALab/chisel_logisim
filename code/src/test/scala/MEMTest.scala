import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MEMTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test MEM stage" in {
    test(new MEM) { c =>
        // 初始化输入值
        c.io.aluResult_MEM.poke(1.U)
        c.io.wMemData_MEM.poke(0x01020408.U)
        c.io.weMEM_ctrl_uMEM_MEM.poke(true.B)
        c.io.wRegDataSrc_ctrl_uMEM_MEM.poke(false.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_MEM.poke(3.U)
        c.io.memReadDataExt_ctrl_uMEM_MEM.poke(true.B)
        c.io.reset.poke(false.B)

        // 执行一个时钟周期
        c.clock.step()

        // 检查输出
        c.io.wRegData_MEM.expect(1.U) // 这里需要你填写期望的输出值

        
        // 初始化输入值
        c.io.aluResult_MEM.poke(1.U)
        c.io.wMemData_MEM.poke(0x01020408.U)
        c.io.weMEM_ctrl_uMEM_MEM.poke(false.B)
        c.io.wRegDataSrc_ctrl_uMEM_MEM.poke(true.B)
        c.io.wrMemByteSelScr_ctrl_uMEM_MEM.poke(3.U)
        c.io.memReadDataExt_ctrl_uMEM_MEM.poke(true.B)
        c.io.reset.poke(false.B)

        // 执行一个时钟周期
        c.clock.step()

        // 检查输出
        c.io.wRegData_MEM.expect(0x01020408.U) // 这里需要你填写期望的输出值
    }
  }
}

// sbt "testOnly *MEMTest"
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MyCpuTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "test MyCpu stage" in {
    test(new MyCpu) { c =>
        c.io.reset.poke(true.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
        c.io.reset.poke(false.B)
        c.clock.step()
    }
  }
}

// sbt "testOnly *MyCpuTest"
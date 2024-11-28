import chisel3._ 
import chisel3.util._ 
import common.Instructions._
import common.Consts._
import chisel3.util.experimental.loadMemoryFromFile

class MEM extends Module{
    val io = IO(new Bundle{
        val aluResult_MEM = Input(UInt(WORD_LEN.W))
        val wMemData_MEM = Input(UInt(WORD_LEN.W))
        val weMEM_ctrl_uMEM_MEM = Input(Bool())
        val wRegDataSrc_ctrl_uMEM_MEM = Input(Bool())
        val wrMemByteSelScr_ctrl_uMEM_MEM = Input(UInt(2.W))
        val memReadDataExt_ctrl_uMEM_MEM = Input(Bool())
        val reset = Input(Bool())
        val wRegData_MEM = Output(UInt(WORD_LEN.W))
    })

    val mem = Mem(16384, UInt(8.W))
    loadMemoryFromFile(mem, "src/loong/loong_mem.hex")
    
    val readMemData = RegInit(0.U(WORD_LEN.W))

    val aluResualt = io.aluResult_MEM
    val byteAddr = io.aluResult_MEM(1,0)
    val addr = io.aluResult_MEM(6,2)
    val wMemData = io.wMemData_MEM
    val weMEM_ctrl = io.weMEM_ctrl_uMEM_MEM
    val wRegDataSrc_ctrl = io.wRegDataSrc_ctrl_uMEM_MEM
    val wrMemByteSelScr_ctrl = io.wrMemByteSelScr_ctrl_uMEM_MEM
    val memReadDataExt_ctrl_uMEM = io.memReadDataExt_ctrl_uMEM_MEM

    val wMemDAtaB = Cat(wMemData(7,0),wMemData(7,0),wMemData(7,0),wMemData(7,0))
    val wMemDataH = Cat(wMemData(15,0),wMemData(15,0))
    
    val wMeMData_end = MuxCase(0.U(WORD_LEN.W), Seq(
        (wrMemByteSelScr_ctrl === MASK_8) -> wMemDAtaB,
        (wrMemByteSelScr_ctrl === MASK_16) -> wMemDataH,
        (wrMemByteSelScr_ctrl === MASK_32) -> wMemData
    ))

    val wdata0 = wMeMData_end(7, 0)
    val wdata1 = wMeMData_end(15, 8)
    val wdata2 = wMeMData_end(23, 16)
    val wdata3 = wMeMData_end(31, 24)

    val typeB = MuxCase(0.U(4.W), Seq(
        (byteAddr === 0.U) -> 1.U,
        (byteAddr === 1.U) -> 2.U,
        (byteAddr === 2.U) -> 4.U,
        (byteAddr === 3.U) -> 8.U
    ))

    val typeH = MuxCase(0.U(4.W), Seq(
        (byteAddr(1) === 0.U) -> 3.U,
        (byteAddr(1) === 1.U) -> 12.U,
    ))

    val byteSel = MuxCase(0.U(4.W), Seq(
        (wrMemByteSelScr_ctrl === MASK_8) -> typeB,
        (wrMemByteSelScr_ctrl === MASK_16) -> typeH,
        (wrMemByteSelScr_ctrl === MASK_32) -> 15.U
    ))

    when(weMEM_ctrl === MEM_W){
        mem(addr) := wdata0 & Fill(8, byteSel(0))
        mem(addr + 1.U(WORD_LEN.W)) := wdata1 & Fill(8, byteSel(1))
        mem(addr + 2.U(WORD_LEN.W)) := wdata2 & Fill(8, byteSel(2))
        mem(addr + 3.U(WORD_LEN.W)) := wdata3 & Fill(8, byteSel(3))
    }.elsewhen(weMEM_ctrl === MEM_R){
        val rdata0 = mem(addr)
        val rdata1 = mem(addr + 1.U(WORD_LEN.W))
        val rdata2 = mem(addr + 2.U(WORD_LEN.W))
        val rdata3 = mem(addr + 3.U(WORD_LEN.W))
        val readWordData = Cat(rdata3, rdata2, rdata1, rdata0)
        val DataB = MuxCase(0.U(8.W), Seq(
            (byteAddr === 0.U) -> rdata0,
            (byteAddr === 1.U) -> rdata1,
            (byteAddr === 2.U) -> rdata2,
            (byteAddr === 3.U) -> rdata3
        ))
        val readByteData = MuxCase(0.U(32.W), Seq(
            (memReadDataExt_ctrl_uMEM === EXT_U) -> Cat(Fill(24, 0.U), DataB),
            (memReadDataExt_ctrl_uMEM === EXT_S) -> Cat(Fill(24, DataB(7)), DataB)
        ))
        val DataH = MuxCase(0.U(16.W), Seq(
            (byteAddr(1) === 0.U) -> Cat(rdata1, rdata0),
            (byteAddr(1) === 1.U) -> Cat(rdata3, rdata2)
        ))
        val readHalfWordData = MuxCase(0.U(32.W), Seq(
            (memReadDataExt_ctrl_uMEM === EXT_U) -> Cat(Fill(16, 0.U), DataH),
            (memReadDataExt_ctrl_uMEM === EXT_S) -> Cat(Fill(16, DataH(15)), DataH)
        ))
        readMemData := MuxCase(0.U(32.W), Seq(
            (wrMemByteSelScr_ctrl === MASK_8)  -> readByteData,
            (wrMemByteSelScr_ctrl === MASK_16) -> readHalfWordData,
            (wrMemByteSelScr_ctrl === MASK_32) -> readWordData
        ))
    }

    val wRegData_MEM = MuxCase(0.U(WORD_LEN.W), Seq(
        (wRegDataSrc_ctrl === W_MEM)  -> readMemData,
        (wRegDataSrc_ctrl === W_ALU)  -> aluResualt
    ))

    io.wRegData_MEM := wRegData_MEM
}

object MEM extends App{
    emitVerilog(new MEM(), Array("--target-dir", "verilog"))
}
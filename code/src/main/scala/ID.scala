import chisel3._ 
import chisel3.util._ 
import common.Instructions._ 
import common.Consts._ 

class ID extends Module{
    val io = IO(new Bundle {
        val PC_ID = Input(UInt(WORD_LEN.W))
        val instr_ID = Input(UInt(WORD_LEN.W))
        val reset = Input(Bool())
        val wRegAddr_EXE = Input(UInt(ADD_LEN.W))
        val wRegAddr_MEM = Input(UInt(ADD_LEN.W))
        val aluResult_EXE = Input(UInt(WORD_LEN.W))
        val wRegData_MEM = Input(UInt(WORD_LEN.W))
        val wRegDataSrc_ctrl_uMEM_EXE = Input(Bool())
        val wReg_ctrl_WB = Input(Bool())
        val wRegaddr_WB = Input(UInt(ADD_LEN.W))
        val wRegData_WB = Input(UInt(WORD_LEN.W))
        val data1_ID = Output(UInt(WORD_LEN.W))
        val data2_ID = Output(UInt(WORD_LEN.W))
        val wRegAddr_ID = Output(UInt(ADD_LEN.W))
        val wMemData_ID = Output(UInt(WORD_LEN.W))
        val branchTarge_ID = Output(UInt(WORD_LEN.W))
        val branchFlag_ID = Output(Bool())
        val stallReqOfID_ID = Output(Bool())
        val flushReqOfID_ID = Output(Bool())
        val weReg_ctrl_uWB_ID = Output(Bool())
        val memReadDataExt_ctrl_uMEM_ID = Output(Bool())
        val wrMemByteSelScr_ctrl_uMEM_ID = Output(UInt(2.W))
        val wRegDataSrc_ctrl_uMEM_ID = Output(Bool())
        val weMEM_ctrl_uMEM_ID = Output(Bool())
        val aluOP_ctrl_uEXE_ID = Output(UInt(OP.W))
    })

    val stFlag_EXE = io.wRegDataSrc_ctrl_uMEM_EXE

    val regfile = Mem(32, UInt(WORD_LEN.W)) // 临时的

    when(io.wReg_ctrl_WB === WB_W){
        regfile(io.wRegaddr_WB) := io.wRegData_WB
    }

    val si12 = io.instr_ID(21, 10)
    val ext_si12 = Cat(Fill(20, si12(11)), si12)
    val o16 = io.instr_ID(25, 10)
    // printf("o16: %d\n", o16)
    val ext_o16 = Cat(Fill(16, o16(15)), o16 << 2.U)
    // printf("ext_o16: %d\n", ext_o16)
    val si20 = io.instr_ID(24, 5)
    val ext_si20 = Cat(si20, Fill(12, 0.U))
    val o26 = Cat(io.instr_ID(9, 0), io.instr_ID(25, 10))
    val ext_o26 = Cat(Fill(6, o26(25)), o26 << 2.U)
    val rj_addr = io.instr_ID(9, 5)
    val rk_addr = io.instr_ID(14, 10)
    val ui5_addr = io.instr_ID(14, 10)
    val rd_addr = io.instr_ID(4, 0)
    
    // printf("io.instr_ID: %b\n", io.instr_ID)
    val csignals = ListLookup(
            io.instr_ID,List(ALU_X,    ADD1_X,  ADD2_X,  DATA1_X,   DATA2_X,   WADD_X,  MASK_X,  MASK_X,  IMM_X,    MEM_R, WB_R, EXT_U, W_ALU),
        Array(
            ADD_W   ->  List(ALU_ADD,  ADD1_RJ, ADD2_RK, DATA1_REG, DATA1_REG, WADD_RD, MASK_X,  MASK_X,  IMM_X,    MEM_R, WB_W, EXT_U, W_ALU),
            SRL_W   ->  List(ALU_SRL,  ADD1_RJ, ADD2_RK, DATA1_REG, DATA1_REG, WADD_RD, MASK_X,  MASK_X,  IMM_X,    MEM_R, WB_W, EXT_U, W_ALU),
            SRA_W   ->  List(ALU_SRA,  ADD1_RJ, ADD2_RK, DATA1_REG, DATA1_REG, WADD_RD, MASK_X,  MASK_X,  IMM_X,    MEM_R, WB_W, EXT_U, W_ALU),
            ADDI_W  ->  List(ALU_ADD,  ADD1_RJ, ADD2_X,  DATA1_REG, DATA2_IMM, WADD_RD, MASK_X,  MASK_X,  IMM_SI12, MEM_R, WB_W, EXT_U, W_ALU),
            LD_B    ->  List(ALU_ADD,  ADD1_RJ, ADD2_X,  DATA1_REG, DATA2_IMM, WADD_RD, MASK_8,  MASK_X,  IMM_SI12, MEM_R, WB_W, EXT_S, W_MEM),
            LD_H    ->  List(ALU_ADD,  ADD1_RJ, ADD2_X,  DATA1_REG, DATA2_IMM, WADD_RD, MASK_16, MASK_X,  IMM_SI12, MEM_R, WB_W, EXT_S, W_MEM),
            LD_W    ->  List(ALU_ADD,  ADD1_RJ, ADD2_X,  DATA1_REG, DATA2_IMM, WADD_RD, MASK_32, MASK_X,  IMM_SI12, MEM_R, WB_W, EXT_S, W_MEM),
            ST_B    ->  List(ALU_ADD,  ADD1_RJ, ADD2_RD, DATA1_REG, DATA2_IMM, WADD_X,  MASK_X,  MASK_8,  IMM_SI12, MEM_W, WB_R, EXT_U, W_ALU),
            ST_H    ->  List(ALU_ADD,  ADD1_RJ, ADD2_RD, DATA1_REG, DATA2_IMM, WADD_X,  MASK_X,  MASK_16, IMM_SI12, MEM_W, WB_R, EXT_U, W_ALU),
            ST_W    ->  List(ALU_ADD,  ADD1_RJ, ADD2_RD, DATA1_REG, DATA2_IMM, WADD_X,  MASK_X,  MASK_32, IMM_SI12, MEM_W, WB_R, EXT_U, W_ALU),
            LUI21_W ->  List(ALU_X,    ADD1_X,  ADD2_X,  DATA1_X,   DATA2_IMM, WADD_RD, MASK_X,  MASK_X,  IMM_SI20, MEM_R, WB_W, EXT_U, W_ALU),
            BL      ->  List(BR_BL,    ADD1_X,  ADD2_X,  DATA1_X,   DATA2_X,   WADD_1,  MASK_X,  MASK_X,  IMM_O26,  MEM_R, WB_W, EXT_U, W_ALU),
            JIRL    ->  List(ALU_ADD,  ADD1_RJ, ADD2_X,  DATA1_PC,  DATA2_E,   WADD_RD, MASK_X,  MASK_X,  IMM_O16,  MEM_R, WB_W, EXT_U, W_ALU),         
            BEQ     ->  List(BR_BEQ,   ADD1_RJ, ADD2_RD, DATA1_REG, DATA2_REG, WADD_X,  MASK_X,  MASK_X,  IMM_O16,  MEM_R, WB_R, EXT_U, W_ALU),
            BGE     ->  List(BR_BGE,   ADD1_RJ, ADD2_RD, DATA1_REG, DATA2_REG, WADD_X,  MASK_X,  MASK_X,  IMM_O16,  MEM_R, WB_R, EXT_U, W_ALU),
            BLTU    ->  List(BR_BLTU,  ADD1_RJ, ADD2_RD, DATA1_REG, DATA2_REG, WADD_X,  MASK_X,  MASK_X,  IMM_O16,  MEM_R, WB_R, EXT_U, W_ALU),
            SLTI    ->  List(ALU_SLTI, ADD1_RJ, ADD2_X,  DATA1_REG, DATA2_IMM, WADD_RD, MASK_X,  MASK_X,  IMM_SI12, MEM_R, WB_W, EXT_U, W_ALU),
            SRLI_W  ->  List(ALU_SRL,  ADD1_RJ, ADD2_UI5,DATA1_REG, DATA2_REG, WADD_RD, MASK_X,  MASK_X,  IMM_X,    MEM_R, WB_W, EXT_U, W_ALU)
       )
    )
    
    val operate :: raddr1_f :: raddr2_f :: data1_f :: data2_f :: wadd :: rmask_len :: wmask_len :: imm :: mem_r_w :: wb_r_w :: ext :: wRegDataSrc_ctrl_uMEM :: Nil = csignals
    // printf("operate: %d \n", operate)
    val raddr_1 = MuxCase(0.U(ADD_LEN.W),Seq(
        (raddr1_f === ADD1_RJ)  -> rj_addr,
    ))
    val raddr_2 = MuxCase(0.U(ADD_LEN.W), Seq(
        (raddr2_f === ADD2_RK)  -> rk_addr,
        (raddr2_f === ADD2_RD)  -> rd_addr,
        (raddr2_f === ADD2_UI5) -> ui5_addr
    ))

    val stall_case1 = (raddr_1 =/= 0.U) && (raddr_1 === io.wRegAddr_EXE) && stFlag_EXE
    val stall_case2 = (raddr_2 =/= 0.U) && (raddr_2 === io.wRegAddr_EXE) && stFlag_EXE
    // printf("raddr_1: %d\n", raddr_1)
    // printf("raddr_2: %d\n", raddr_2)
    val stallReg = (stall_case1 || stall_case2)

    val wb_addr = MuxCase(0.U(ADD_LEN.W), Seq(
        (wadd === WADD_1)  -> 1.U(ADD_LEN.W),
        (wadd === WADD_RD) -> rd_addr
    ))

    val data1 = MuxCase(regfile(raddr_1), Seq(
        ((raddr_1 === io.wRegAddr_MEM) && (io.wRegDataSrc_ctrl_uMEM_EXE === W_MEM)) -> io.wRegData_MEM,
        ((raddr_1 === io.wRegAddr_EXE) && (io.wRegDataSrc_ctrl_uMEM_EXE === W_ALU)) -> io.aluResult_EXE,
        ((raddr_1 === io.wRegaddr_WB)  && (io.wReg_ctrl_WB === WB_W)) -> io.wRegData_WB
    ))
    // printf("data1: %d\n", data1)

    val data2 = MuxCase(regfile(raddr_2), Seq(
        ((raddr_2 === io.wRegAddr_MEM) && (io.wRegDataSrc_ctrl_uMEM_EXE === W_MEM)) -> io.wRegData_MEM,
        ((raddr_2 === io.wRegAddr_EXE) && (io.wRegDataSrc_ctrl_uMEM_EXE === W_ALU)) -> io.aluResult_EXE,
        ((raddr_2 === io.wRegaddr_WB)  && (io.wReg_ctrl_WB === WB_W)) -> io.wRegData_WB
    ))
    
    val op1_data = MuxCase(0.U(WORD_LEN.W), Seq(
        (data1_f === DATA1_REG) -> data1,
        (data1_f === DATA1_PC)  -> io.PC_ID
    ))
    // printf("op1_data: %d\n", op1_data)
    val imm_data = MuxCase(0.U(WORD_LEN.W), Seq(
        (imm === IMM_SI12) -> ext_si12,
        (imm === IMM_SI20) -> ext_si20,
        (imm === IMM_O16)  -> ext_o16,
        (imm === IMM_O26)  -> ext_o26
    ))
    // printf("imm_data: %d\n", imm_data)
    val op2_data =MuxCase(0.U(WORD_LEN.W), Seq(
        (data2_f === DATA2_REG) -> data2,
        (data2_f === DATA2_IMM) -> imm_data,
        (data2_f === DATA2_E)   -> 4.U(WORD_LEN.W)
    ))
    // printf("op2_data: %d\n", op2_data)
    val wMemData = MuxCase(regfile(raddr_2), Seq(
        ((wmask_len === MASK_8))  -> (regfile(raddr_2) & "b0000000000000000000000011111111".U),
        ((wmask_len === MASK_16)) -> (regfile(raddr_2) & "b0000000000000001111111111111111".U)
    ))



    // 分支处理
    val branchFlag =  MuxCase(false.B, Seq(
        (io.instr_ID === BEQ)   -> (op1_data === op2_data),
        (io.instr_ID === BGE)   -> (op1_data.asSInt() === op2_data.asSInt()),
        (io.instr_ID === BLTU)  -> (op1_data < op2_data),
        (io.instr_ID === BL)    -> true.B,
        (io.instr_ID === JIRL)  -> true.B

    ))

    val flushReg = branchFlag

    val branchTarge = MuxCase(io.PC_ID, Seq(
        (io.instr_ID === JIRL) -> data1
    )) + imm_data


    io.data1_ID                              := op1_data
    io.data2_ID                              := op2_data
    io.wRegAddr_ID                           := wb_addr
    io.wMemData_ID                           := wMemData
    io.branchTarge_ID                        := branchTarge
    io.branchFlag_ID                         := branchFlag
    io.stallReqOfID_ID                       := stallReg
    io.flushReqOfID_ID                       := flushReg
    io.weReg_ctrl_uWB_ID                     := wb_r_w
    io.memReadDataExt_ctrl_uMEM_ID           := ext
    io.wrMemByteSelScr_ctrl_uMEM_ID          := rmask_len
    io.wRegDataSrc_ctrl_uMEM_ID              := wRegDataSrc_ctrl_uMEM
    io.weMEM_ctrl_uMEM_ID                    := mem_r_w
    io.aluOP_ctrl_uEXE_ID                    := operate
}

object ID extends App{
    emitVerilog(new ID(), Array("--target-dir", "verilog"))
}

/*
 = "b0010000001110111100000110".U
 = "b0000000001110101110000110".U
 = "b0000000010110101110000110".U
 = "b0110000001000011000000110".U
 = "b0110000001001011000000110".U
 = "b0000000011110101110000110".U
 = "b0100000011100111100000110".U
 = "b0100000100100111100000110".U
 = "b0000000100110101110000110".U
 = "b0000000101110101110000110".U
 = "b1000000110100111100000110".U
 = "b1000000111100111100000110".U
 = "b1011100001101011100000110".U
 = "b0000100000000000000000000".U
 = "b0000110000100000110000000".U
 = "b0000010000100000110000000".U
 = "b1011000001001011000001110".U
 = "b0010000001100111111100000".U
 = "b0010000001100111111110000".U
 = "b0010000001110111101000111".U
 = "b0010000001110111101010111".U
 = "b0000001010110101110000110".U
 = "b0010001000100111100000110".U
 = "b1000001001100111100000110".U
 = "b0001010000100000110000000".U
*/


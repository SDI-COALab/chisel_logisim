package common

import chisel3._ 
import chisel3.util._ 

object Consts{
    val WORD_LEN              = 32
    val ADD_LEN               = 5
    val START_ADDR            = 0.U(WORD_LEN.W)
    val BUBBLE                = 0.U(WORD_LEN.W)

    val ADD1_LEN              = 1
    val ADD1_X                = 0.U(ADD1_LEN.W)
    val ADD1_RJ               = 1.U(ADD1_LEN.W)

    val ADD2_LEN              = 2
    val ADD2_X                = 0.U(ADD2_LEN.W)
    val ADD2_RK               = 1.U(ADD2_LEN.W)
    val ADD2_RD               = 2.U(ADD2_LEN.W)
    val ADD2_UI5              = 3.U(ADD2_LEN.W)

    val DATA1_LEN             = 2
    val DATA1_X               = 0.U(DATA1_LEN.W)
    val DATA1_REG             = 1.U(DATA1_LEN.W)
    val DATA1_PC              = 2.U(DATA1_LEN.W)

    val DATA2_LEN             = 2
    val DATA2_X               = 0.U(DATA2_LEN.W)
    val DATA2_REG             = 1.U(DATA2_LEN.W)
    val DATA2_IMM             = 2.U(DATA2_LEN.W)
    val DATA2_E               = 3.U(DATA2_LEN.W)

    val WADD_LEN              = 2
    val WADD_X                = 0.U(WADD_LEN.W)
    val WADD_1                = 1.U(WADD_LEN.W)
    val WADD_RD               = 2.U(WADD_LEN.W)

    val MASK_LEN              = 2
    val MASK_X                = 0.U(MASK_LEN.W)
    val MASK_8                = 1.U(MASK_LEN.W)
    val MASK_16               = 2.U(MASK_LEN.W)
    val MASK_32               = 3.U(MASK_LEN.W)

    val IMM_LEN               = 3
    val IMM_X                 = 0.U(IMM_LEN.W)
    val IMM_SI12              = 1.U(IMM_LEN.W)
    val IMM_SI20              = 2.U(IMM_LEN.W)
    val IMM_O16               = 3.U(IMM_LEN.W)
    val IMM_O26               = 4.U(IMM_LEN.W)
 
    val OP                    = 4
    val ALU_X                 = 0.U(OP.W)
    val ALU_ADD               = 1.U(OP.W)
    val ALU_SRL               = 2.U(OP.W)
    val ALU_SRA               = 3.U(OP.W)
    val BR_BEQ                = 4.U(OP.W)
    val BR_BGE                = 5.U(OP.W)
    val BR_BLTU               = 6.U(OP.W)
    val BR_BL                 = 7.U(OP.W)
    val ALU_JIRL              = 8.U(OP.W)
    val ALU_SLTI              = 9.U(OP.W)

    val MEM_LEN               = 1
    val MEM_R                 = false.B
    val MEM_W                 = true.B

    val WB_LEN                = 1
    val WB_R                  = false.B
    val WB_W                  = true.B

    val EXT_LEN               = 1
    val EXT_U                 = false.B
    val EXT_S                 = true.B

    val W_ADD_LEN             = 1
    val W_ALU                 = false.B
    val W_MEM                 = true.B


    //***************************
    val alu_op_x   = 0.U(4.W)
    val alu_op_add = 1.U(4.W)
    val alu_op_sub = 2.U(4.W)
    val alu_op_or  = 3.U(4.W)
    val alu_op_and = 4.U(4.W)
    val alu_op_xor = 5.U(4.W)
    val alu_op_srl = 6.U(4.W)
    val alu_op_sll = 7.U(4.W)
    val alu_op_slt = 8.U(4.W)
    val alu_op_sra = 9.U(4.W)
    val alu_op_mul = 10.U(4.W)

    val branch_op_x    = 0.U(3.W) 
    val branch_op_bne  = 1.U(3.W)
    val branch_op_b    = 2.U(3.W)
    val branch_op_beq  = 3.U(3.W)
    val branch_op_bl   = 4.U(3.W)
    val branch_op_bge  = 5.U(3.W)
    val branch_op_jirl = 6.U(3.W)

    val raddr1_x  = false.B
    val raddr1_rj = true.B

    val raddr2_rd = false.B
    val raddr2_rk = true.B

    val src1_x = false.B
    val src1_rj = true.B

    val src2_x = false.B
    val src2_rk = true.B

    val raddr_N = false.B
    val raddr_Y = true.B

    val memce_N = false.B
    val memce_Y = true.B

    val memwe_N = false.B
    val memwe_Y = true.B

    val word = false.B
    val byte = true.B

    val wbwe_N = false.B
    val wbwe_Y = true.B

    val reg_x  = 0.U(2.W)
    val reg_rd = 1.U(2.W)
    val reg_1  = 2.U(2.W)

    val imm_x    = 0.U(3.W)
    val imm_si12 = 1.U(3.W)
    val imm_ui12 = 2.U(3.W)
    val imm_si20 = 3.U(3.W)
    val imm_ui5  = 4.U(3.W)
    val imm_u4   = 5.U(3.W)

    val null_type = 0.U(2.W)
    val reg_type  = 1.U(2.W)
    val pc_type   = 2.U(2.W)
    val imm_type  = 3.U(2.W)
    

    val wb_alu = false.B
    val wb_mem = true.B

    val mem_byte = true.B
    val mem_word = false.B
}
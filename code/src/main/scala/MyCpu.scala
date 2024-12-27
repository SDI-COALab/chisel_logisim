import chisel3._ 
import chisel3.util._
import common.Instructions._
import common.Consts._ 

class MyCpu extends Module{
    val io = IO(new Bundle {
        val reset = Input(Bool())
    })

    val ifd = Module(new IF)
    val if_id = Module(new IF_ID)
    val id = Module(new ID)
    val id_exe = Module(new ID_EXE)
    val exe = Module(new EXE)
    val exe_mem = Module(new EXE_MEM)
    val mem = Module(new MEM)
    val mem_wb = Module(new MEM_WB)
    val plc = Module(new PLC)

    ifd.io.reset := reset
    if_id.io.reset := reset
    id.io.reset := reset
    id_exe.io.reset := reset
    exe_mem.io.reset := reset
    mem.io.reset := reset
    mem_wb.io.reset := reset

    ifd.io.stallStageIF := plc.io.stallStageIF
    // printf(p"stallStageIF: ${plc.io.stallStageIF}\n")
    if_id.io.flushStageID := plc.io.flushStageID
    if_id.io.stallStageID := plc.io.stallStageID
    id_exe.io.flushStageID := plc.io.flushStageEXE
    id_exe.io.stallStageID := plc.io.stallStageEXE
    exe_mem.io.stallStageMEM := plc.io.stallStageMEM
    exe_mem.io.flushStageMEM := plc.io.flushStageMEM
    mem_wb.io.stallStageWB := plc.io.stallStageWB
    mem_wb.io.flushStageWB := plc.io.flushStageWB

    printf(p"branchTarget_ID: ${Hexadecimal(id.io.branchTarge_ID)}\n")
    printf("********************************************************\n")
    ifd.io.branchTarget_ID := id.io.branchTarge_ID
    ifd.io.branchFlag_ID := id.io.branchFlag_ID
    printf(p"PC_IF: ${Hexadecimal(ifd.io.PC_IF)}\n")
    printf(p"instr_IF: ${Hexadecimal(ifd.io.instr_IF)}\n")
    printf("********************************************************\n")

    if_id.io.PC_IF := ifd.io.PC_IF
    if_id.io.instr_IF := ifd.io.instr_IF
    printf(p"PC_ID: ${Hexadecimal(if_id.io.PC_ID)}\n")
    printf(p"instr_ID: ${Hexadecimal(if_id.io.instr_ID)}\n")
    printf("********************************************************\n")
    
    id.io.PC_ID := if_id.io.PC_ID 
    id.io.instr_ID := if_id.io.instr_ID
    id.io.wRegaddr_WB := mem_wb.io.wRegAddr_WB
    id.io.wRegData_WB := mem_wb.io.wRegData_WB
    id.io.wReg_ctrl_WB := mem_wb.io.weReg_ctrl_uWB_WB
    id.io.aluResult_EXE := exe.io.aluResult_EXE
    id.io.wRegAddr_EXE := id_exe.io.wRegAddr_EXE
    id.io.wRegAddr_MEM := exe_mem.io.wRegAddr_MEM
    id.io.wRegData_MEM := mem.io.wRegData_MEM
    id.io.wRegDataSrc_ctrl_uMEM_EXE := id_exe.io.wRegDataSrc_ctrl_uMEM_EXE
    printf(p"data1_ID: ${Hexadecimal(id.io.data1_ID)}\n")
    printf(p"data2_ID: ${Hexadecimal(id.io.data2_ID)}\n")
    printf(p"aluOP_ctrl_uEXE_ID: ${Hexadecimal(id.io.aluOP_ctrl_uEXE_ID)}\n")
    printf(p"wRegAddr_ID: ${Hexadecimal(id.io.wRegAddr_ID)}\n")
    printf(p"wMemData_ID: ${Hexadecimal(id.io.wMemData_ID)}\n")
    printf(p"branchTarget_ID: ${Hexadecimal(id.io.branchTarge_ID)}\n")
    printf(p"branchFalg_ID: ${Hexadecimal(id.io.branchFlag_ID)}\n")
    printf("********************************************************\n")
    

    id_exe.io.aluOP_ctrl_uEXE_ID := id.io.aluOP_ctrl_uEXE_ID
    id_exe.io.data1_ID := id.io.data1_ID
    id_exe.io.data2_ID := id.io.data2_ID
    id_exe.io.wRegAddr_ID := id.io.wRegAddr_ID
    id_exe.io.wMemData_ID := id.io.wMemData_ID
    id_exe.io.weMEM_ctrl_uMEM_ID := id.io.weMEM_ctrl_uMEM_ID
    id_exe.io.wRegDataSrc_ctrl_uMEM_ID := id.io.wRegDataSrc_ctrl_uMEM_ID
    id_exe.io.wrMemByteSelScr_ctrl_uMEM_ID := id.io.wrMemByteSelScr_ctrl_uMEM_ID
    id_exe.io.memReadDataExt_ctrl_uMEM_ID := id.io.memReadDataExt_ctrl_uMEM_ID
    id_exe.io.weReg_ctrl_uWB_ID := id.io.weReg_ctrl_uWB_ID
    printf(p"aluResult_EXE: ${Hexadecimal(exe.io.aluResult_EXE)}\n")
    printf(p"wRegAddr_EXE: ${Hexadecimal(id_exe.io.wRegAddr_EXE)}\n")
    printf(p"wRegData_EXE: ${Hexadecimal(id_exe.io.wMemData_EXE)}\n")
    printf(p"weMEM_ctrl_EXE: ${Hexadecimal(id_exe.io.weMEM_ctrl_uMEM_EXE)}\n")
    printf(p"wRegDataSrc_ctrl_uMEM_EXE: ${Hexadecimal(id_exe.io.wRegDataSrc_ctrl_uMEM_EXE)}\n")
    printf(p"weReg_ctrl_uWB_EXE: ${Hexadecimal(id_exe.io.weReg_ctrl_uWB_EXE)}\n")
    printf("********************************************************\n")
    
    exe.io.aluOP_ctrl_uEXE_EXE := id_exe.io.aluOP_ctrl_uID_EXE
    exe.io.data1_EXE := id_exe.io.data1_EXE
    exe.io.data2_EXE := id_exe.io.data2_EXE
    
    exe_mem.io.aluResult_EXE := exe.io.aluResult_EXE
    exe_mem.io.wRegAddr_EXE := id_exe.io.wRegAddr_EXE
    exe_mem.io.wMemData_EXE := id_exe.io.wMemData_EXE
    exe_mem.io.weMEM_ctrl_uMEM_EXE := id_exe.io.weMEM_ctrl_uMEM_EXE
    exe_mem.io.wRegDataSrc_ctrl_uMEM_EXE := id_exe.io.wRegDataSrc_ctrl_uMEM_EXE
    exe_mem.io.wrMemByteSelScr_ctrl_uMEM_EXE := id_exe.io.wrMemByteSelScr_ctrl_uMEM_EXE
    exe_mem.io.memReadDataExt_ctrl_uMEM_EXE := id_exe.io.memReadDataExt_ctrl_uMEM_EXE
    exe_mem.io.weReg_ctrl_uWB_EXE := id_exe.io.weReg_ctrl_uWB_EXE
    printf(p"wRegAddr_MEM: ${Hexadecimal(exe_mem.io.wRegAddr_MEM)}\n")
    printf(p"weReg_ctrl_uWB_MEM: ${Hexadecimal(exe_mem.io.weReg_ctrl_uWB_MEM)}\n")
    printf(p"wMemData_MEM: ${Hexadecimal(exe_mem.io.wMemData_MEM)}\n")
    printf(p"weMEM_ctrl_uMEM_MEM: ${Hexadecimal(exe_mem.io.weMEM_ctrl_uMEM_MEM)}\n")
    printf(p"wRegDataSrc_ctrl_uMEM_MEM: ${Hexadecimal(exe_mem.io.wRegDataSrc_ctrl_uMEM_MEM)}\n")
    printf(p"aluResult_MEM: ${Hexadecimal(exe_mem.io.aluResult_MEM)}\n")
    printf("********************************************************\n")

    mem.io.aluResult_MEM := exe_mem.io.aluResult_MEM
    mem.io.wMemData_MEM := exe_mem.io.wMemData_MEM
    mem.io.weMEM_ctrl_uMEM_MEM := exe_mem.io.weMEM_ctrl_uMEM_MEM
    mem.io.wRegDataSrc_ctrl_uMEM_MEM := exe_mem.io.wRegDataSrc_ctrl_uMEM_MEM
    mem.io.wrMemByteSelScr_ctrl_uMEM_MEM := exe_mem.io.wrMemByteSelScr_ctrl_uMEM_MEM
    mem.io.memReadDataExt_ctrl_uMEM_MEM := exe_mem.io.memReadDataExt_ctrl_uMEM_MEM
    printf(p"wRegData_MEM: ${Hexadecimal(mem.io.wRegData_MEM)}\n")
    printf("********************************************************\n")

    mem_wb.io.wRegData_MEM := mem.io.wRegData_MEM
    mem_wb.io.weReg_ctrl_uWB_MEM := exe_mem.io.weReg_ctrl_uWB_MEM
    mem_wb.io.wRegAddr_MEM := exe_mem.io.wRegAddr_MEM
    printf(p"wRegData_WB: ${Hexadecimal(mem_wb.io.wRegData_WB)}\n")
    printf(p"wRegAddr_WB: ${Hexadecimal(mem_wb.io.wRegAddr_WB)}\n")
    printf(p"weReg_ctrl_uWB_WB: ${Hexadecimal(mem_wb.io.weReg_ctrl_uWB_WB)}\n")
    printf("********************************************************\n")
    
    plc.io.stallReqOfID := id.io.stallReqOfID_ID
    plc.io.flushReqOfID := id.io.flushReqOfID_ID
}

object MyCpu extends App{
    emitVerilog(new MyCpu(), Array("--target-dir", "verilog"))
}


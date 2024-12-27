module BindsTo_0_MEM(
  input         clock,
  input         reset,
  input  [31:0] io_aluResult_MEM,
  input  [31:0] io_wMemData_MEM,
  input         io_weMEM_ctrl_uMEM_MEM,
  input         io_wRegDataSrc_ctrl_uMEM_MEM,
  input  [1:0]  io_wrMemByteSelScr_ctrl_uMEM_MEM,
  input         io_memReadDataExt_ctrl_uMEM_MEM,
  input         io_reset,
  output [31:0] io_wRegData_MEM
);

initial begin
  $readmemh("src/loong/loong_mem.hex", MEM.mem);
end
                      endmodule

bind MEM BindsTo_0_MEM BindsTo_0_MEM_Inst(.*);
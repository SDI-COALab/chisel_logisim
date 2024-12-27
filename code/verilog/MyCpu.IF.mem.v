module BindsTo_0_IF(
  input         clock,
  input         reset,
  input         io_stallStageIF,
  input  [31:0] io_branchTarget_ID,
  input         io_branchFlag_ID,
  input         io_reset,
  output [31:0] io_PC_IF,
  output [31:0] io_instr_IF
);

initial begin
  $readmemh("src/loong/loong_core1.hex", IF.mem);
end
                      endmodule

bind IF BindsTo_0_IF BindsTo_0_IF_Inst(.*);
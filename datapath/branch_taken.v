module branch_taken();
    always @(inst_funct3 or alu_result_equal_zero) begin
    case (inst_funct3)
    `FUNCT3_BRANCH_EQ: take_branch = alu_result_equal_zero;
    `FUNCT3_BRANCH_NE: take_branch = !alu_result_equal_zero;
    `FUNCT3_BRANCH_LT: take_branch = alu_result_equal_zero;
    `FUNCT3_BRANCH_GE: take_branch = !alu_result_equal_zero;
    `FUNCT3_BRANCH_LTU: take_branch = alu_result_equal_zero;
    `FUNCT3_BRANCH_GEU: take_branch = !alu_result_equal_zero;
    default: take_branch = 1'bx;
    endcase
    end
endmodule
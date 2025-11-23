module branch_taken();
    always @(inst_funct3 or alu_result_equal_zero) begin
    case (inst_funct3)
    `FUNCT3_BRANCH_EQ: take_branch = alu_result_equal_zero; //nella BEQ se la sottrazione genera zero allora il salto avviene
    `FUNCT3_BRANCH_NE: take_branch = !alu_result_equal_zero; //nella BNE se la sottrazione non genera zero allora il salto avviene
    `FUNCT3_BRANCH_LT: take_branch = alu_result_equal_zero; //nella BLT se la sottrazione genera un risultato negativo (ovvero il bit di segno è 1) allora il salto avviene 
    `FUNCT3_BRANCH_GE: take_branch = !alu_result_equal_zero; //nella BGE se la sottrazione genera un risultato positivo o zero (ovvero il bit di segno è 0) allora il salto avviene
    `FUNCT3_BRANCH_LTU: take_branch = alu_result_equal_zero; //nella BLTU se la sottrazione genera un risultato negativo (ovvero il bit di segno è 1) allora il salto avviene
    `FUNCT3_BRANCH_GEU: take_branch = !alu_result_equal_zero; //nella BGEU se la sottrazione genera un risultato positivo o zero (ovvero il bit di segno è 0) allora il salto avviene
    default: take_branch = 1'bx;
    endcase
    end
endmodule
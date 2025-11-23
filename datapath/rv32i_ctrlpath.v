module rv32i_ctrlpath(
    input[6:0] inst_opcode,
    input[2:0] inst_funct3,
    input[6:0] inst_funct7,
    input alu_result_equal_zero, //arriva dalla ALU e indica se il risultato della sottrazione tra due registri è zero
    output pc_write_enable, //modifica il PC se attivo, altrimenti di default PC+4
    output regfile_write_enable, //abilita la scrittura nel registro di destinazione
    output alu_operand_a_select, //se è 0 prende il valore in rs1, se è 1 prende il valore del PC
    output alu_operand_b_select, //se è 0 prende il valore in rs2, se è 1 prende l'immediato 
    output data_mem_read_enable, //abilita la lettura dalla memoria dati 
    output data_mem_write_enable, //abilita la scrittura nella memoria dati 
    output[1:0] reg_writeback_select, //selezione del registro di destinazione
    output[1:0] alu_op_type, //tipo di operazione che la ALU deve eseguire
    output[1:0] next_pc_select //seleziona il prossimo valore del PC
);
    //definizione degli opcode
    localparam OPCODE_RTYPE = 7'b0110011;
    localparam OPCODE_ITYPE_ALU = 7'b0010011;
    localparam OPCODE_ITYPE_LOAD = 7'b0000011;
    localparam OPCODE_STYPE = 7'b0100011;
    localparam OPCODE_BTYPE = 7'b1100011;
    localparam OPCODE_JAL = 7'b1101111;
    localparam OPCODE_JALR = 7'b1100111;
    //definizione dei segnali di controllo
    reg pc_write_enable_reg;
    reg[1:0] next_pc_select_reg;
    //logica combinatoria per generare i segnali di controllo
    always @(*) begin 
        //valori di default 
        pc_write_enable_reg = 1'b1;
        regfile_write_enable = 1'b0;
        alu_operand_a_select = 1'b0;
        alu_operand_b_select = 1'b0;
        data_mem_read_enable = 1'b0;
        data_mem_write_enable = 1'b0;
        reg_writeback_select = 2'b00;
        alu_op_type = 2'b00;
        next_pc_select_reg = 2'b00;

        case (inst_opcode)
            OPCODE_RTYPE:begin 
                regfile_write_enable=1'b1;
                alu_op_type=2'b10; 
                /*Il risultato andrà scritto su un registro e l'operazione che dovrà 
                eseguire la ALU sarà */
            end
            OPCODE_ITYPE_ALU:begin 
                regfile_write_enable=1'b1;
                alu_op_type=2'b11; //operazione ALU definita da funct3
                alu_operand_b_select=1'b1; //prende l'immediato
                /*Il risultato dovrà essere scritto su un registro, il secondo dato dell'ALU 
                sarà un immedaiato*/
            end
            OPCODE_ITYPE_LOAD:begin 
                regfile_write_enable=1'b1; 
                alu_op_type=2'b00; //operazione di somma per calcolare l'indirizzo
                alu_operand_b_select=1'b1; //prende l'immediato
                data_mem_read_enable=1'b1; //abilita la lettura dalla memoria dati
                reg_writeback_select=2'b01; //scrive nel registro il dato letto dalla memoria
                /*il risultato verrà scritto sul register file, il secondo valore nell'ALU 
                è un immediato, dovremo leggere il dato della memoria dati e dovremo poi riscrivere 
                il risultato nel register file nel registro specificato*/
            end
            OPCODE_STYPE:begin 
                alu_op_type=2'b00; //operazione di somma per calcolare l'indirizzo
                alu_operand_b_select=1'b1; //prende l'immediato
                data_mem_write_enable=1'b1; //abilita la scrittura nella memoria dati
                /*dovremo calcolare l'indirizzo sommando rs1 e l'immediato, il secondo 
                operando dell'ALU è un immediato e dovremo scrivere nella memoria dati*/
            end
            OPCODE_BTYPE:begin 
                alu_op_type=2'b01; //operazione di sottrazione per confrontare i due registri
                if(alu_result_equal_zero) begin 
                    pc_write_enable_reg=1'b1; //aggiorna il PC con il valore calcolato
                    next_pc_select_reg=2'b01; //seleziona il PC+immediato
                end else begin 
                    pc_write_enable_reg=1'b1; //aggiorna il PC con il valore calcolato
                    next_pc_select_reg=2'b00; //seleziona il PC+4
                end
                /*dovremo confrontare i due registri sottraendoli, se il risultato è 
                zero allora aggiorniamo il PC con il valore calcolato (PC+immediato), altrimenti 
                andiamo avanti di 4*/
            end
            OPCODE_JAL:begin 
                regfile_write_enable=1'b1; //scrive il valore del PC+4 nel registro di destinazione
                alu_operand_a_select=1'b1; //prende il valore del PC
                alu_operand_b_select=1'b1; //prende l'immediato
                next_pc_select_reg=2'b10; //seleziona il PC+immediato
                /*dovremo salvare nel registro di destinazione il valore del PC+4, 
                il primo operando dell'ALU è il PC, il secondo è l'immediato e il prossimo 
                valore del PC sarà PC+immediato*/
            end
            OPCODE_JALR:begin 
                regfile_write_enable=1'b1; //scrive il valore del PC+4 nel registro di destinazione
                alu_operand_b_select=1'b1; //prende l'immediato
                next_pc_select_reg=2'b11; //seleziona rs1+immediato
                /*dovremo salvare nel registro di destinazione il valore del PC+4, 
                il secondo operando dell'ALU è l'immediato e il prossimo valore del PC sarà 
                rs1+immediato*/
            end
            default: begin 
                //istruzione non riconosciuta, mantieni i valori di default
            end
    end
endmodule 
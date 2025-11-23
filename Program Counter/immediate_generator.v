module immediateGenerator(
    input reg[31:0] instruction, 
    output reg[31:0] immediate
);
    always @(instruction) begin
        case(instruction[6:0])
            7'b0010011, // I-type
            7'b0000011,
            7'b1100111: begin
                immediate = {{20{instruction[31]}}, instruction[31:20]}; //20{instruction[31]} ripete 20 voltil bit di segno, concatena poi i bit da 31 a 20
                // i 20 bit di segno servono per l'estensione del segno (funge da riempitivo) e 12 bit da 31 a 20  sono i bit effettivi dell'immediato
            end
            7'b0100011: begin // S-type
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            7'b1100011: begin // B-type
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end
            7'b1101111: begin // J-type
                immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end
            7'b0110111, // U-type
            7'b0010111: begin
                immediate = {instruction[31:12], 12'b0};
            end
            default: begin
                immediate = 32'b0;
            end
    end
endmodule
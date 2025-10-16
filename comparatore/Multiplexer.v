module multiplexer(input a1, input a2, input a3, input a4, input [1:0] sel, output signal);
    always @(*) begin   //si aggiorna ad ogni variazione del segnale in input
        case: 
            2'b00: signal = a1; 
            2'b01: signal = a2; 
            2'b10: signal = a3;
            2'b11: signal = a4;
        endcase
    end
endmodule
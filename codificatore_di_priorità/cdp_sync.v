module cdp_sync(input [3:0] in, output reg [1:0] out, input wire clk, output reg valid);
    always @(posedge clk) begin
        valid = 1'b1;
        casez(in)
            4'b1???: out = 2'b00;   //priorità al bit più significativo
            4'b01??: out = 2'b01;   //se il bit più significativo è 0, controlla il successivo
            4'b001?: out = 2'b10;   //se i primi due bit sono 0, controlla il terzo
            4'b0001: out = 2'b11;   //se i primi tre bit sono 0, l'ultimo è 1
            default: begin  //caso in cui tutti i bit sono 0
                out = 2'b00;
                valid = 1'b0;
            end
        endcase
    end
endmodule

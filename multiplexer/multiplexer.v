module multiplexer(input a1, input a2, input a3, input a4, input [1:0] sel, output reg signal);
    always @(*) begin //in una rete combinatoria permette di rivalutare l'output al cambiamento di un input
        if(sel == 2'b00) begin
            signal = a1;
        end
        else if(sel == 2'b01) begin
            signal = a2;
        end
        else if(sel == 2'b10) begin
            signal = a3;
        end
        else begin
            signal = a4;
        end
    end
endmodule

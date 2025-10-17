module contatore(input wire clk, input wire reset, input wire enable, input wire up_down, output reg [3:0] data_out);
    always @(posedge clk or posedge reset) begin //ad ognifronte di clock o presentarsi del segnale di reset
        if(reset) begin  //se reset è impostato allora resetta il valore
            data_out<=4'b0000; //valore di default del contatore (0)
        end
        else if(enable) begin //se il componente è attivo
            if(up_down) begin //se up_down è 1, allora incrementa il contatore. 
                data_out<=data_out+1'b1;
            end else begin  //altrimenti 
            data_out<=data_out-1'b1; //decrementa il contatore 
        end
        end
    end
endmodule
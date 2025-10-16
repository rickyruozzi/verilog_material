module counter_mod8(input wire clk, input wire reset, input wire enable, output reg [2:0] count);
    always @(posedge clk or posedge reset) begin
        if(reset==1'b1) begin 
            count<=3'b000; //>= assegna alla fine del ciclo il valore
        end 
        else if(enable==1'b1) begin //se enable non è attivo non dovremmo poter incrementare il valore 
            if(count==3'b111) begin //se siamo arrivati a 7 resettiamo al valore 0 
                count<=3'b000;
            end
            else begin //altrimenti incrementiamo il valore di count
                count<=count+1;
            end
        end
    end
endmodule
module three_bit_counter #(parameter N=8)( //ricordarsi # per impostare i parametri
    input clk,
    input reset,
    input enable, 
    output reg [N-1:0] count
);
    always @(negedge clk or negedge reset) begin
        if (reset == 1'b0) begin
            count<=0;
        end
        else if(enable) begin
            count <= count+1;
        end
    end
endmodule
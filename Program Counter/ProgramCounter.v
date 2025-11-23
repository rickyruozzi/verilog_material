module programCounter(
    parameter width = 32,
    parameter initial_value = 0
)(
    input clk, 
    input reset,
    input write_enable,
    input [31:0] pc_in, 
    output reg [31:0] pc_out);

    initial value= initial_value; 
    always(posedege clk or posedge reset) begin
        if(reset) begin 
            pc_out<=initlial_value;
        end
        else if(write_enable) begin 
            pc_out<=pc_in;
        end
    end
endmodule
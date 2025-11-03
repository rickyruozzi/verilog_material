MODULE SRAM1KX32-BIT(
    input wire clk,
    input wire we,
    input wire [9:0] addr,
    input wire [31:0] data_in,
    output wire [31:0] data_out
);
    reg [31:0] memory [0:1023];
    always @(posedge clk) begin 
        if (we) begin 
            memory[addr]<=data_in;
        end
    end
    always @(*) begin 
        data_out<=memory[addr];
    end
endmodule
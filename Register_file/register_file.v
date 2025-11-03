module register_file#(parameter nregs=32, parameter xlen=32, parameter log2_nregs=$clog2(nregs))(
    input clk, input reset, input write_enable, input [log2_nregs-1:0] write_addr, input [xlen-1:0] write_data,
    input [log2_nregs-1:0] read_addr1, input [log2_nregs-1:0] read_addr2,
    output reg [xlen-1:0] read_data1, output reg [xlen-1:0] read_data2); 
    /*
    INPUT: 
    - clk: clock signal
    - reset: active low reset signal
    - write_enable: signal to enable writing to the register file
    - write_addr: address of the register to write to
    - write_data: data to write to the register
    - read_addr1: address of the first register to read from
    - read_addr2: address of the second register to read from
    OUTPUT:
    - read_data1: data read from the first register
    - read_data2: data read from the second register
    PARAMETERS:
    - nregs: number of registers in the register file (default: 32)
    - xlen: width of each register in bits (default: 32)
    - log2_nregs: number of bits needed to address nregs registers
    */
    integer i; //iteratore 
    reg [xlen-1:0] registers [0:nregs-1]; //registers emulation array
    always @(posedge clk or negedge reset) begin //clock and reset detection
        if(!reset) begin //active low reset
            for(i=0; i<nregs; i=i+1) begin //registers reset
                registers[i]<={xlen{1'b0}};
            end
            if(write_enable and write_addr!={log2_nregs{1'b0}}) begin //write operation in the correct register
                registers[write_addr]<=write_data;
            end
        end
    end
    assign read_data1 = (read_addr1 == {log2_nregs{1'b0}} ? {xlen{1'b0}} : registers[read_addr1]); //read operation from the correct register
    assign read_data2 = (read_addr2 == {log2_nregs{1'b0}} ? {xlen{1'b0}} : registers[read_addr2]); //the operation will happen at first because it is not waiting for the clock edge, so we can place it here.
endmodule
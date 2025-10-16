module sequence_detector(input wire clk, input wire in_bit, input wire reset, output reg found);
    parameter s0 = 2'b00; 
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state<=s0;
        end
        else
        begin 
            state<=next_state;
        end
    end

    always @(*) begin 
        found=0; 
        case(state)
            s0 : next_state = in_bit ? s1 : s0;
            s1 : next_state = in_bit ? s1 : s2;
            s2 : begin 
                next_state = in_bit ? s1 : s0 ;
                if(in_bit==1'b1) begin 
                    found = 1; 
                end
            end
        default : next_state=s0;
    endcase
    end
endmodule
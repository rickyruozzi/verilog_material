module distributore(input clk, input reset, input d_i, input v_i, output reg output_o);
reg [1:0] state, next_state;
parameter s0=2'b00, s1=2'b01, s2=2'b10;
always @(negedge clk or negedge reset) begin 
    if(!reset) begin 
        state <=s0;
    end
    else begin
        state<=next_state;
     end
end
always @(d_i or v_i or state) begin
    case(state)
        s0: begin
            if(d_i) begin
                next_state = s1;
            end
            else if(v_i) begin
                next_state= s2;
            end else begin next_state=state; end
        end
        s1: begin
            if(v_i) begin
                next_state = s0;
            end
            else if(d_i) begin
                next_state = s1;
            end
            else begin
                next_state=state;
            end
        end
        s2 : begin
            if(d_i) begin
                next_state = s0;
            end
            else if(v_i) begin
                next_state = s2;
            end
            else begin
                next_state=state;
             end
        end
        default: next_state = state;
    endcase
end

always @(d_i or v_i or state) begin
    case(state)
        s0: output_o = 1'b0;
        s1: begin
            if(v_i) begin
                output_o = 1'b1;
            end
            else begin
                output_o = 1'b0;
            end
        end
        s2: begin
            if(d_i || v_i) begin
                output_o = 1'b1;
            end
            else begin
                output_o = 1'b0;
            end
        end
        default: output_o = 1'b0;
    endcase
end
endmodule

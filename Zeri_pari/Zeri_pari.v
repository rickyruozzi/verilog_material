module zeri_pari(input clk, input reset, input data, input reset, output data_o);
    reg state, nextstate; 
    parameter s0=1'b0, s1=1'b1;
    always @(negedge clk or negedge reset) begin //L'aggiornamento dello stato è sincrono
        if (!reset) begin 
            state <= s0;
        end
        else begin 
            state <= nextstate;
        end
    end

    always @(data or state) begin //Aggiornamento asincrono del next state
        case(state)
            s0: begin 
                if (data) begin 
                    next_state = s0; 
                end
                else begin 
                    nextstate=s1;
                end
            end
            s1 : begin 
                if (data) begin 
                    nextstate=s1;
                end
                else begin 
                    nextstate=s0;
                end
            end
    end

    always @(data or state) begin  //Aggiornamento asincrono dell'output
        case(state)
            s0: data_o = 1'b1;
            s1: data_o = 1'b0;
    end
endmodule
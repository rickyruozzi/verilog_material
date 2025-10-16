module full_adder3(input [2:0] a_i, input [2:0] b_i, input c_i, output [2:0] s_o, output c_o);
    wire c1, c2;
    Full_adder fa0(a_i[0], b_i[0], c_i, s_o[0], c1);
    Full_adder fa1(a_i[1], b_i[1], c1, s_o[1], c2);
    Full_adder fa2(a_i[2], b_i[2], c2, s_o[2], c_o);
endmodule

module triFullAdder();
    reg [2:0] t_a;
    reg [2:0] t_b;
    reg t_cin;
    wire [2:0] t_s;
    wire t_cout;

    full_adder3 i_full_adder3 (
        .a_i(t_a),
        .b_i(t_b),
        .c_i(t_cin),
        .s_o(t_s),
        .c_o(t_cout)
    );
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, triFullAdder);

        t_a = 3'b000;
        t_b = 3'b000;
        t_cin = 0;
        #10;
        if(t_cout == 0 && t_s == 3'b000) begin
            $display("t_a:%b + t_b:%b + t_cin:%b = t_cout:%b t_s:%b (Success)",
            t_a, t_b, t_cin, t_cout, t_s);
        end
        else begin
            $display("t_a:%b + t_b:%b + t_cin:%b = t_cout:%b t_s:%b (Fail!)",
            t_a, t_b, t_cin, t_cout, t_s);
            $finish;
        end

        t_a = 3'b000;
        t_b = 3'b001;
        t_cin = 0;
        #10;
        if(t_cout == 0 && t_s == 3'b001) begin
            $display("t_a:%b + t_b:%b + t_cin:%b = t_cout:%b t_s:%b (Success)",
            t_a, t_b, t_cin, t_cout, t_s);
        end
        else begin
            $display("t_a:%b + t_b:%b + t_cin:%b = t_cout:%b t_s:%b (Fail!)",
            t_a, t_b, t_cin, t_cout, t_s);
            $finish;
        end

        //TODO Completa con tutti i test
        $finish;
    end

endmodule
module full_adder3(input [2:0] a_i, input [2:0] b_i, input c_i, output [2:0] s_o, output c_o);
    wire c1, c2;
    Full_adder fa0(a_i[0], b_i[0], c_i, s_o[0], c1);
    Full_adder fa1(a_i[1], b_i[1], c1, s_o[1], c2);
    Full_adder fa2(a_i[2], b_i[2], c2, s_o[2], c_o);
endmodule

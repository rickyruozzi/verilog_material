module Full_adder(input a, input b, input cin, output s, output cout);
    wire u1, u2, u3;
    assign u1 = a ^ b;
    assign s = u1 ^ cin;
    assign u2 = a & b;
    assign u3 = u1 & cin;
    assign cout = u2 | u3;
endmodule

module RC(input a, input b, output z, output w);
    assign z= a & b;
    assign w= a | b;
endmodule
module testbench();
    reg [3:0] A;
    reg [3:0] B;
    wire GT, EQ, LT;
    comparatore4 C(A, B, GT, EQ, LT);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        A = 4'b0000; B = 4'b0000; #10;
        A = 4'b0000; B = 4'b0001; #10;
        A = 4'b0001; B = 4'b0000; #10;
        A = 4'b0010; B = 4'b0001; #10;
        A = 4'b0010; B = 4'b0010; #10;
        A = 4'b0010; B = 4'b0011; #10;
        A = 4'b1111; B = 4'b1111; #10;
        A = 4'b1111; B = 4'b1110; #10;
        A = 4'b1110; B = 4'b1111; #10;
        $stop;
    end
endmodule

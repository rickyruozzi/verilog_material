module tb_tri();
    reg a, b, cin;
    wire s, cout;

    tri_FullAdder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_tri);
endmodule
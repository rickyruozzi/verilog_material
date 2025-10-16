module testbench();
    reg a, b, cin;
    wire s, cout;
    Full_adder fa(a, b, cin, s, cout);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        cin=0;
        a=0; b=0; #10;
        if(s !== 0 || cout !== 0) $display("Error for 00");
        a=0; b=1; #10;
        if(s !== 1 || cout !== 0) $display("Error for 01");
        a=1; b=0; #10;
        if(s !== 1 || cout !== 0) $display("Error for 10");
        a=1; b=1; #10;
        if(s !== 0 || cout !== 1) $display("Error for 11");
        $display("Test Complete");
        $finish;
    end
endmodule

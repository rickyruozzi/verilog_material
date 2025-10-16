module testbench();
    reg a1,a2,a3,a4;
    wire signal;
    reg[1:0] sel;
    multiplexer mux(a1,a2,a3,a4,sel,signal);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,testbench);

        // Set inputs
        a1 = 1;
        a2 = 0;
        a3 = 1;
        a4 = 0;

        // Test all select combinations
        sel = 2'b00; #10;
        $display("sel=%b, signal=%b", sel, signal);

        sel = 2'b01; #10;
        $display("sel=%b, signal=%b", sel, signal);

        sel = 2'b10; #10;
        $display("sel=%b, signal=%b", sel, signal);

        sel = 2'b11; #10;
        $display("sel=%b, signal=%b", sel, signal);

        $finish;
    end
endmodule

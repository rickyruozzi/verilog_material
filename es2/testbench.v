module testbench();
    reg a,b;
    wire z,w;
    RC instance1(a,b,z,w); //istanza del circuito RC che abbiamo creato
    initial begin
        $dumpfile("waveform.vcd"); // The testbench must consider all possibilities to be correct
        $dumpvars(0,testbench); // $dumpfile and $dumpvars are required on Windows as parameters
        a=0; b=0; #10; //#10 rappresenta un delay per risettare i valori delle entrate senza causare problemi
        if(z!==0 || w!==0) $display("Error"); // z = a & b = 0, w = a | b = 0
        a=0; b=1; #10;
        if(z!==0 || w!==1) $display("Error"); // z = 0, w = 1
        a=1; b=0; #10;
        if(z!==0 || w!==1) $display("Error"); // z = 0, w = 1
        a=1; b=1; #10;
        if(z!==1 || w!==1) $display("Error"); // z = 1, w = 1
        $display("Test Complete");
        $finish;
        //se non coprissimo tutti i casi dovremmo implementare un caso di default
    end
endmodule

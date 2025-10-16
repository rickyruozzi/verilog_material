module testbench();
    reg a,b;
    wire y;
    CC instance1(a,b,y);
    initial begin
        $dumpfile("waveform.vcd"); //il testbench deve tennere conto di tutte le possibilità per essere corretto 
        $dumpvars(0,testbench); //o,testbench sono richiesti su windows come parametri
        a=0; b=0; #10;
        if(y!==0) $display("Error"); //stiamo simulando un or, quindi dobbiamo verificare che non si verifichi alcun tipo di errore
        a=0; b=1; #10;
        if(y!==1) $display("Error");
        a=1; b=0; #10;
        if(y!==1) $display("Error");
        a=1; b=1; #10;
        if(y!==1) $display("Error");
        $display("Test Complete");
        $finish;
    end
endmodule
module tb_sequence_detector();

    // segnali del testbench
    reg clk = 0;
    reg reset;
    reg in_bit;
    wire found;

    // istanza del modulo sotto test
    sequence_detector uut (
        .clk(clk),
        .in_bit(in_bit),
        .reset(reset),
        .found(found)
    );

    // generatore di clock: periodo 10 unità di tempo
    always #5 clk = ~clk;

    initial begin
        // Dump dei segnali per VCD (per simulazione con waveform)
        $dumpfile("sequence_detector.vcd");
        $dumpvars(0, tb_sequence_detector);

        // inizializzazione
        reset = 1;
        in_bit = 0;
        #10 reset = 0;  // fine reset

        // Flusso di test: esempio con sequenze 101
        // sequenza: 1 0 1 0 1 1 0 1
        in_bit = 1; #10;
        in_bit = 0; #10;
        in_bit = 1; #10;  // qui found dovrebbe diventare 1
        in_bit = 0; #10;
        in_bit = 1; #10;  // qui found di nuovo 1
        in_bit = 1; #10;
        in_bit = 0; #10;
        in_bit = 1; #10;  // found ancora 1

        // fine simulazione
        #20 $finish;
    end

endmodule

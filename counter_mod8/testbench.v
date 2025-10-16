module tb_counter_mod8;
    reg clk = 0;
    reg reset; //si usa reg per i segnali generati e wire per quelli ricevuti
    reg enable;
    wire [2:0] count;

    // istanza del modulo
    counter_mod8 uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count) //.nome_nel_modulo(nome_nel_testbench)
    );

    // generatore di clock
    always #5 clk = ~clk; //clock invertito ogni 5 unità di tempo

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,tb_counter_mod8);
        reset = 1;
        enable = 0;
        #10 reset = 0;
        enable = 1;

        #100 $finish; // fine simulazione
    end
endmodule

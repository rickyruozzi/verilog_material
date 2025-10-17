`timescale 1ns/1ps

module tb_contatore;

    // segnali di test
    reg clk;
    reg reset;
    reg enable;
    reg up_down;
    wire [3:0] data_out;

    // istanza del modulo da testare
    contatore uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .up_down(up_down),
        .data_out(data_out)
    );

    // generatore di clock: periodo = 10 ns
    always #5 clk = ~clk;

    // blocco di stimolo
    initial begin
        // file per waveform
        $dumpfile("contatore.vcd");
        $dumpvars(0, tb_contatore);

        // inizializzazione
        clk = 0;
        reset = 1;
        enable = 0;
        up_down = 1;
        #10 reset = 0;  // rilascia il reset

        // inizio conteggio in su
        enable = 1;
        up_down = 1;
        #100; // aspetta un po' di clock

        // pausa
        enable = 0;
        #30;

        // conteggio in giù
        enable = 1;
        up_down = 0;
        #100;

        // fine simulazione
        $finish;
    end

endmodule

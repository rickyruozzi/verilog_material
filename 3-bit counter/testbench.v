`timescale 1ns/1ps

module tb_3;

  // Parametri
  parameter N = 8;

  // Segnali del testbench
  reg clk;
  reg reset;
  reg enable;
  wire [N-1:0] count;

  // Istanza del modulo da testare
  three_bit_counter #(N) uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .count(count)
  );

  // Generatore di clock (periodo = 10 ns)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // toggla ogni 5ns -> periodo 10ns
  end

  // Stimoli di test
  initial begin
    // Inizializza segnali
    reset = 0;
    enable = 0;

    $dumpfile("3-bit_counter.vcd");
    $dumpvars(0, tb_3);

    // Mostra intestazione
    $display("Time\tReset\tEnable\tCount");
    $monitor("%4t\t%b\t%b\t%0d", $time, reset, enable, count);
  

    // Rilascia il reset dopo 10 ns
    #10 reset = 1;

    // Attiva enable dopo un po’
    #10 enable = 1;

    // Lascia contare per un po’
    #100 enable = 0;

    // Resetta di nuovo
    #20 reset = 0;
    #10 reset = 1;

    // Riabilita il contatore
    #10 enable = 1;

    // Continua per un po’ e poi termina
    #100 $finish;
  end

endmodule

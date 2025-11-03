//L'implementazione che vedrete emula il funzionamento di una SRAM 4x2 bit
module SRAM(input wire clk, input wire we, input wire [1:0] addr,
input wire [1:0] data_in, 
output reg [1:0] data_out);
/* Ci serve il clock per sincronizzare il funzionamento del componente
un wire enable per abilitare il componente, un indirizzo dove scrivere
un dato da due bit in input e un in output. */
    reg [1:0] memory [0:3]; //Array di 4 locazioni da due bit
    always @(posedge clk) begin , //operazione sincrona
        if (we) begin 
            memory[addr]<=data_in; //aggiornamento del contenuto della locazione di memoria con data in
        end
    end
    always @(*) begin 
        data_out<=memory[addr]; //aggiornamento di data out 
    end
endmodule
module sram16k32 (
    input  wire clk,
    input  wire we,
    input  wire [13:0] addr,
    input  wire [31:0] data_in,
    output wire [31:0] data_out
);
    wire [31:0] mod_data_out [0:15];  // array di uscite dai 16 moduli
    wire [3:0] sel_mod = addr[13:10]; // selezione modulo, serve per scegliere quale modulo attivare tra i 16 (2^4).
    genvar i; // serve per generare un iteratore che ci servirà successivamente
    generate //istanziamo 16 moduli SRAM1KX32-BIT
        for (i = 0; i < 16; i = i + 1) begin : gen_mods //gen_mods serve per dare un nome al blocco generato
            sram1kx32 u_sram1kx32 (
                .clk(clk),
                .we(we & (sel_mod == i)),   // abilita scrittura solo sul modulo selezionato (macro-componente attivo AND (sel_mod == i))
                .addr(addr[9:0]),          // indirizzo interno modulo
                .data_in(data_in),
                .data_out(mod_data_out[i])
            );
            //(sel_mod == i) è vero solo per il modulo selezionato, quindi solo quel modulo può scrivere
        end
    endgenerate
    // selezione dell'uscita del modulo attivo
    assign data_out = mod_data_out[sel_mod]; // instradamento dell'uscita del modulo selezionato a data_out
/*Notiamo che i primi 4 bit del modulo servono per indicare il modulo, per questo abbiamo :
bit 13:10 -> selezione del modulo (16 moduli)
bit 9:0 -> selezione dell'indirizzo interno.
in alternativa avremmo potuto anche se scomodamente creare un canale apposito per la selezione del modulo  
*/
endmodule
module three_bit_counter #(parameter N=8)( //ricordarsi # per impostare i parametri
    input clk,  //segnale di clock
    input reset, //segnale di reset basso attivo
    input enable, //abilitazione contatore
    output reg [N-1:0] count //canale di output
);
    always @(negedge clk or negedge reset) begin //sensibile al clock e alla variazione di reset
        if (reset == 1'b0) begin //se reset è attivo azzera il contatore
            count<=0;   //assegnazione non bloccante
        end
        else if(enable) begin //se enable e attivo incrementa il contatore visto che se siamo qui il trigger proviene dal clock
            count <= count+1; //assegnazione non bloccante
        end
    end
endmodule
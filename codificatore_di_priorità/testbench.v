module testbench();
    reg [3:0] in;
    wire [1:0] out_async, out_sync;
    wire valid_async, valid_sync;
    reg clk;

    cdp_async UUT_async (in, out_async, valid_async);
    cdp_sync UUT_sync (in, out_sync, clk, valid_sync);


//Blocco di gestione del clock
    initial begin
        clk = 0;  // Inizializza il clock a 0
    end

    always #5 clk = ~clk;  // Genera clock con periodo 10 unità di tempo


    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);

        // Test case 1: Input 4'b1000
        in = 4'b1000;
        #10; // Wait for 10 time units (1 ciclo di clock)
        $display("Input: %b, Async Output: %b, Async Valid: %b, Sync Output: %b, Sync Valid: %b", in, out_async, valid_async, out_sync, valid_sync);

        // Test case 2: Input 4'b0100
        in = 4'b0100;
        #10; // Wait for 10 time units
        $display("Input: %b, Async Output: %b, Async Valid: %b, Sync Output: %b, Sync Valid: %b", in, out_async, valid_async, out_sync, valid_sync);

        // Test case 3: Input 4'b0010
        in = 4'b0010;
        #10; // Wait for 10 time units
        $display("Input: %b, Async Output: %b, Async Valid: %b, Sync Output: %b, Sync Valid: %b", in, out_async, valid_async, out_sync, valid_sync);

        // Test case 4: Input 4'b0001
        in = 4'b0001;
        #10; // Wait for 10 time units
        $display("Input: %b, Async Output: %b, Async Valid: %b, Sync Output: %b, Sync Valid: %b", in, out_async, valid_async, out_sync, valid_sync);

        // Test case 5: Input 4'b0000 (no valid input)
        in = 4'b0000;
        #10; // Wait for 10 time units
        $display("Input: %b, Async Output: %b, Async Valid: %b, Sync Output: %b, Sync Valid: %b", in, out_async, valid_async, out_sync, valid_sync);

        // Test case 6: Input with multiple high bits (e.g., 4'b1100)
        in = 4'b1100;
        #10; // Wait for 10 time units
        $display("Input: %b, Async Output: %b, Async Valid: %b, Sync Output: %b, Sync Valid: %b", in, out_async, valid_async, out_sync, valid_sync);

        // End simulation
        $finish;
    end
endmodule

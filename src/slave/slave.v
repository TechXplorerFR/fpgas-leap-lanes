module slave (
    input wire i_Clk,       // Clock signal
    output wire io_PMOD_1   // Signal to master
);

    reg [23:0] counter = 0; // Counter for half-second interval
    reg pmod_signal = 0;    // Signal to send to master

    always @(posedge i_Clk) begin
        // Reset counter at 12.5M counts (assuming 25 MHz clock)
        if (counter >= 12500000) begin
            counter <= 0;
            pmod_signal <= 1;  // Set PMOD signal high every half second
        end else begin
            counter <= counter + 1;
            pmod_signal <= 0;  // Set PMOD signal low otherwise
        end
    end

    assign io_PMOD_1 = pmod_signal;  // Assign PMOD signal to output

endmodule

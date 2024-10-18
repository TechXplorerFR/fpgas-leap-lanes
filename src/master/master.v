module master (
    input wire io_PMOD_1,  // Signal from slave
    input wire i_Clk,      // Clock signal
    output reg [6:0] o_Segment1,
    output reg [6:0] o_Segment2,
    output reg o_LED_1     // Debug LED to indicate updates
);

    reg [23:0] half_sec_counter = 0;  // Counter for half second interval
    reg [6:0] count = 0;              // Counter for 0-99
    reg prev_pmod1 = 0;               // Register to store previous state of io_PMOD_1
    reg r_Led_Status = 0;             // Register to store LED status

    // Main clocking block, checking PMOD every half second
    always @(posedge i_Clk) begin
        // Reset half-second counter at 12.5M counts (assuming 25 MHz clock)
        if (half_sec_counter >= 12500000) begin
            half_sec_counter <= 0;
        end else begin
            half_sec_counter <= half_sec_counter + 1;
        end
    end

    // Logic for detecting rising edge and incrementing count based on io_PMOD_1 signal
    always @(posedge i_Clk) begin
        // Detect rising edge: When io_PMOD_1 transitions from 0 to 1
        if (io_PMOD_1 == 1 && prev_pmod1 == 0) begin
            if (count >= 99) begin
                count <= 0;  // Reset counter to 0 if it reaches 99
            end else begin
                count <= count + 1;  // Increment the count
            end
            r_Led_Status <= 1;  // Turn on debug LED on each count update
        end else begin
            r_Led_Status <= 0;  // Turn off debug LED otherwise
        end

        // Store previous state of io_PMOD_1 for edge detection
        prev_pmod1 <= io_PMOD_1;

        // Display tens digit on o_Segment1
        case (count / 10)
            0: o_Segment1 = 7'b1000000;  // Display 0
            1: o_Segment1 = 7'b1111001;  // Display 1
            2: o_Segment1 = 7'b0100100;  // Display 2
            3: o_Segment1 = 7'b0110000;  // Display 3
            4: o_Segment1 = 7'b0011001;  // Display 4
            5: o_Segment1 = 7'b0010010;  // Display 5
            6: o_Segment1 = 7'b0000010;  // Display 6
            7: o_Segment1 = 7'b1111000;  // Display 7
            8: o_Segment1 = 7'b0000000;  // Display 8
            9: o_Segment1 = 7'b0010000;  // Display 9
            default: o_Segment1 = 7'b1000000;  // Blank display
        endcase

        // Display ones digit on o_Segment2
        case (count % 10)
            0: o_Segment2 = 7'b1000000;  // Display 0
            1: o_Segment2 = 7'b1111001;  // Display 1
            2: o_Segment2 = 7'b0100100;  // Display 2
            3: o_Segment2 = 7'b0110000;  // Display 3
            4: o_Segment2 = 7'b0011001;  // Display 4
            5: o_Segment2 = 7'b0010010;  // Display 5
            6: o_Segment2 = 7'b0000010;  // Display 6
            7: o_Segment2 = 7'b1111000;  // Display 7
            8: o_Segment2 = 7'b0000000;  // Display 8
            9: o_Segment2 = 7'b0010000;  // Display 9
            default: o_Segment2 = 7'b1000000;  // Blank display
        endcase
    end

    assign o_LED_1 = r_Led_Status;  // Assign LED status to output

endmodule

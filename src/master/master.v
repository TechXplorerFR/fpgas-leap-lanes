module master (
    input wire io_PMOD_1,
    input wire io_PMOD_2,
    input wire io_PMOD_3,
    input wire io_PMOD_4,
    input wire io_PMOD_7,
    input wire io_PMOD_8,
    input wire io_PMOD_9,
    input wire io_PMOD_10,
    input wire i_Clk,
    output reg [6:0] o_Segment1,
    output reg [6:0] o_Segment2,
);

begin
    reg readPMOD;
    reg [8:0] byte;
    reg [3:0] counter;
    always @(posedge i_Clk)
    begin
        readPMOD = !readPMOD;
        if(readPMOD)
        begin
            byte[counter]= io_PMOD_1;
            counter = counter + 1;
            if(counter > 8)
            begin
                counter = 0;
            end
        end
        case (byte / 10)
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

        case (byte % 10)
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
end

endmodule
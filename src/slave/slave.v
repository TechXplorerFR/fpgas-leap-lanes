module slave (
    output wire io_PMOD_1,
,
    input wire i_Clk,
    output reg [6:0] o_Segment1,
    output reg [6:0] o_Segment2,
);

begin
    reg readPMOD;
    reg [8:0] byte = 12;
    reg [3:0] counter = 0;
    always @(posedge i_Clk)
    begin
        readPMOD = !readPMOD;
        if(readPMOD)
        begin
            io_PMOD_1 = byte[counter];
            counter = counter + 1;
            if(counter > 8)
            begin
                counter = 0;
            end
        end
    end

endmodule
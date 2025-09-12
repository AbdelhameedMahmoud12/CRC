//=============================================================================
// Module      : LFSR_CRC
// Description : Implements an LFSR-based CRC generator with:
//               - Tap configuration via parameter
//               - Serial data input and CRC output
//               - Active enable signal for shifting
//               - Output valid indication for 8-bit CRC stream
// Author      : Abdelhameed Mahmoud
//=============================================================================


module LFSR_CRC #(
    parameter N     = 8,                     // Width of the LFSR
    parameter TAPS  = 8'b01000100            // Tap configuration for CRC
)(
    input  wire       Data,                  // Serial input bit
    input  wire       ACTIVE,                // Enable signal for LFSR shift
    input  wire       CLK,                   // Clock input
    input  wire       RST,                   // Asynchronous active-low reset
    output reg        CRC,                   // Serial CRC output
    output reg        Valid                  // Output valid flag
);

    //=========================================================================
    // Internal Registers and Signals
    //=========================================================================
    reg [N-1:0] LFSR;
    reg [3:0]   Enable;                      // Bit counter for output
    wire        Feed_Back;
    integer    i;

    assign Feed_Back = LFSR[0] ^ Data;

    //=========================================================================
    // Sequential Logic:
    //=========================================================================
    always @(posedge CLK or negedge RST ) begin
	    Valid  <= 1'b0;

        if (!RST) begin
            LFSR   <= 8'hD8;                 // Initial seed value
            Valid  <= 1'b0;
            Enable <= N;
            CRC    <= 1'b0;
        end
        else begin

            if (ACTIVE) begin
                // Shift LFSR with feedback and taps
                for (i = 0; i < N-1; i = i + 1) begin
                    if (TAPS[i])
                        LFSR[i] <= LFSR[i+1] ^ Feed_Back;
                    else
                        LFSR[i] <= LFSR[i+1];
                end
                LFSR[N-1] <= Feed_Back;
                Enable    <= 0;              // Reset counter to start output phase later
            end
            else if (Enable < N) begin
                CRC    <= LFSR[0];
                LFSR   <= LFSR >> 1;
                Enable <= Enable + 1;
                Valid  <= 1'b1;
            end
			else begin
                // Fix: Reset counter and Valid after operation finishes
                Enable <= N;
                Valid  <= 1'b0;
			end
    end

endmodule


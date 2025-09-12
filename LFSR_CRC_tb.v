//*****************************************************************************
// File        : LFSR_CRC_tb.v
// Description : Testbench for LFSR_CRC module, reads test vectors from
//               memory, drives input, and compares CRC output.
// Author      : Abdelhameed Mahmoud
//*****************************************************************************

`timescale 1us / 1us  

//*****************************************************************************
// Module Declaration
//*****************************************************************************
module LFSR_CRC_tb;

//*****************************************************************************
// Parameters
//*****************************************************************************
parameter DATA_IN_WIDTH = 8;
parameter CRC_OUT_WIDTH = 8;
parameter TEST_CASES    = 10;
parameter CLOCK_PERIOD  = 20;

//*****************************************************************************
// Memory Arrays
//*****************************************************************************
reg [DATA_IN_WIDTH-1:0] DATA_IN [TEST_CASES-1 : 0];
reg [CRC_OUT_WIDTH-1:0] CRC_OUT [TEST_CASES-1 : 0];

//*****************************************************************************
// DUT I/O Signals
//*****************************************************************************
reg  DATA_tb;
reg  ACTIVTE_tb;
reg  CLK_tb;
reg  RST_tb;

wire CRC_tb;
wire VALID_tb;

integer i, op;

//*****************************************************************************
// DUT Instantiation
//*****************************************************************************
LFSR_CRC uut (
    .Data   (DATA_tb),
    .ACTIVE (ACTIVTE_tb),
    .CLK    (CLK_tb),
    .RST    (RST_tb),
    .CRC    (CRC_tb),
    .Valid  (VALID_tb)
);

//*****************************************************************************
// Clock Generator (50 KHz)
//*****************************************************************************
always #(CLOCK_PERIOD / 2) CLK_tb = ~CLK_tb;

//*****************************************************************************
// Initialization Task
//*****************************************************************************
task INITIALIZE;
begin
    CLK_tb     = 1'b0;
    RST_tb     = 1'b0;
    DATA_tb    = 1'b0;
    ACTIVTE_tb = 1'b0;
    i          = 0;
    #(CLOCK_PERIOD);
end
endtask

//*****************************************************************************
// Reset Task
//*****************************************************************************
task RESET;
begin
    RST_tb = 1'b0;
    #(2 * CLOCK_PERIOD);
    RST_tb = 1'b1;
end
endtask

//*****************************************************************************
// Stimulus Task - Apply Data
//*****************************************************************************
task MAKE_OPERATION(input [DATA_IN_WIDTH-1:0] data_op);
begin
    ACTIVTE_tb = 1'b1;
    for (i = 0; i < 8; i = i + 1) begin
        DATA_tb = data_op[i];
        #(CLOCK_PERIOD);
    end
    ACTIVTE_tb = 1'b0;
end
endtask

//*****************************************************************************
// Check CRC Output Task
//*****************************************************************************
task CHECK_OUT(
    input [CRC_OUT_WIDTH-1 : 0] crc_check,
    input [DATA_IN_WIDTH-1 : 0] data,
    input integer test_num
);
    reg [CRC_OUT_WIDTH-1 : 0] STORED_CRC;
    reg [CRC_OUT_WIDTH-1 : 0] check;
begin
    #(CLOCK_PERIOD);
    for (i = 0; i <= 7; i = i + 1) begin
        check[i]      = crc_check[i] ^ CRC_tb;
        STORED_CRC[i] = CRC_tb;
        #(CLOCK_PERIOD);
    end

    $display("*************** Test Case #%0d ***************", test_num + 1);
    if (~^check) begin
        $display("Status          : PASSED");
    end else begin
        $display("Status          : FAILED");
    end
    $display("Data In         : %b", data);
    $display("Expected CRC    : %b", crc_check);
    $display("Observed CRC    : %b", STORED_CRC);
    $display("***********************************************\n");

    #(CLOCK_PERIOD);
    RESET();
end
endtask

//*****************************************************************************
// Simulation Initialization
//*****************************************************************************
initial begin
    $dumpfile("LFSR_CRC.vcd");
    $dumpvars;

    // Load test vectors
    $readmemh("DATA_h.txt",    DATA_IN);
    $readmemh("CRC_OUT_h.txt", CRC_OUT);

    INITIALIZE();
    RESET();

    for (op = 0; op < TEST_CASES; op = op + 1) begin
        MAKE_OPERATION(DATA_IN[op]);
        CHECK_OUT(CRC_OUT[op], DATA_IN[op], op);
    end

    #(2 * CLOCK_PERIOD);
    $stop;
end

endmodule

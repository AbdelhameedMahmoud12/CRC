# Verilog CRC Generator using LFSR

## Description

This project implements a Cyclic Redundancy Check (CRC) generator in Verilog using a Linear Feedback Shift Register (LFSR). The CRC generator is configurable and comes with a testbench to verify its functionality.

## File Descriptions

- `LFSR_CRC.v`: This file contains the main Verilog module for the CRC generator. It implements a configurable LFSR to generate the CRC bits.
- `LFSR_CRC_tb.v`: This is the testbench for the `LFSR_CRC` module. It reads test vectors from `DATA_h.txt` and `CRC_OUT_h.txt` to verify the CRC implementation.
- `DATA_h.txt`: This file contains the input data for the testbench. Each line represents an 8-bit data word in hexadecimal format.
- `CRC_OUT_h.txt`: This file contains the expected 8-bit CRC values for the corresponding input data in `DATA_h.txt`.

## How to run the simulation

To run the simulation, you will need a Verilog simulator that supports `$readmemh`. You can use tools like ModelSim, Vivado, or Icarus Verilog.

1.  Compile the Verilog files: `LFSR_CRC.v` and `LFSR_CRC_tb.v`.
2.  Run the simulation of the `LFSR_CRC_tb` module.
3.  The testbench will read the input data and expected CRC values, run the simulation, and print the results of the test cases to the console.

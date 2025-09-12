# 📘 LFSR-Based CRC Generator & Checker  

## 🔎 Overview  
This project implements a **Cyclic Redundancy Check (CRC)** using a **Linear Feedback Shift Register (LFSR)** in Verilog HDL.  
CRC is widely used for **error detection** in communication systems and digital storage. The design generates and validates CRC codes for input data streams using polynomial division realized by an LFSR.  

The project includes:  
- Verilog module for CRC generation (`LFSR_CRC.v`)  
- A Verilog testbench (`LFSR_CRC_tb.v`)  
- Input and output data files (`DATA_h.txt`, `CRC_OUT_h.txt`)  
- Simulation script for automation (`Simulate.do`)  
- Report with results (`LFSR_CRC_RESULTS.pdf`)  
- Assignment specification (`Assignment_V_5.0.pdf`)  

---

## ⚙️ Features  
- Implements **polynomial-based CRC calculation** using shift-register feedback.  
- Configurable to different CRC polynomials.  
- Validates input data sequences against pre-computed CRC values.  
- Includes a **testbench** for automatic verification.  
- Generates simulation output files for analysis.  

---

## 🏗 Project Structure  

```
Verilog5_0_Abdelhameed_Mahmoud/
│── LFSR_CRC.v              # Main Verilog module (LFSR-based CRC)
│── LFSR_CRC_tb.v           # Testbench for simulation
│── Simulate.do             # Simulation script (for ModelSim/QuestaSim)
│── DATA_h.txt              # Input data for CRC calculation
│── CRC_OUT_h.txt           # Output results from simulation
│── LFSR_CRC_RESULTS.pdf    # Report with simulation waveforms and analysis
│── Assignment_V_5.0.pdf    # Full specification and requirements
```

---

## 📐 Design Explanation  

### 🔸 Linear Feedback Shift Register (LFSR)  
- LFSR is a shift register whose input bit is a **linear function** of its previous state.  
- In CRC, the feedback taps correspond to the **generator polynomial**.  
- Each clock cycle shifts data through the register, applying XOR at tap positions to simulate polynomial division.  

### 🔸 CRC Operation  
1. Input data bits are shifted into the LFSR.  
2. The LFSR applies feedback based on the chosen polynomial.  
3. The final register state represents the **CRC checksum**.  
4. For error detection, the received data+CRC is processed; a **zero remainder** means no error.  

---

## 📑 System Specifications  
  
- **Seed Initialization:** All registers are initialized to `8'hD8` using asynchronous active-low reset.  
- **Data Length:** Supports variable input length (1 to 4 bytes, typically 1 byte).  
- **Active Signal:** `ACTIVE=1` during data transmission.  
- **CRC Output:** 8-bit CRC shifted serially through output port.  
- **Valid Signal:** High during CRC transmission.  

**Operation Flow**  
1. Initialize registers (R7–R0) with `8'hD8`.  
2. Shift data bits (LSB first) into the LFSR.  
3. After last data bit, registers hold CRC result.  
4. Shift out CRC bits in order (R0 = LSB).  

---

## 🧑‍💻 How to Run  

### 🔹 Using ModelSim/QuestaSim  
1. Open ModelSim.  
2. Compile the design:  
   ```tcl
   vlog LFSR_CRC.v LFSR_CRC_tb.v
   ```  
3. Run the provided simulation script:  
   ```tcl
   do Simulate.do
   ```  
4. View waveforms and check results in `CRC_OUT_h.txt`.  

---

## 📝 Testbench Description (`LFSR_CRC_tb.v`)  
- Feeds input data from `DATA_h.txt` to the CRC module.  
- Monitors the generated CRC and writes results to `CRC_OUT_h.txt`.  
- Includes multiple test cases for validation.  

---

## 📂 Input Test Data  

File: **`DATA_h.txt`**  
```
93
72
36
1B
A6
C0
55
F2
5E
11
```

---

## 📂 CRC Output Results  

File: **`CRC_OUT_h.txt`**  
```
78
44
11
d2
09
b2
36
80
2C
63
```

---

## 📊 Results  
- Each input byte from `DATA_h.txt` is processed by the LFSR-CRC.  
- The generated CRC values (`CRC_OUT_h.txt`) match the expected results.  
- Full waveforms and detailed analysis are documented in **LFSR_CRC_RESULTS.pdf**.  

---

## 🔮 Future Enhancements  
- Support for multiple standard CRC polynomials (CRC-8, CRC-16, CRC-32).  
- Hardware implementation on FPGA for real-time CRC checking.  
- Optimized parallel CRC computation for high-speed applications.  

---

## 📚 References  
- W. Stallings, *Data and Computer Communications*.  
- IEEE Std. 802.3 (Ethernet CRC).  
- [LFSR and CRC Theory](https://en.wikipedia.org/wiki/Cyclic_redundancy_check)  

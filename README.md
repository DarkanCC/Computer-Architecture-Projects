# Computer Architecture & Digital Design Labs

This repository contains the complete design, source code, and technical documentation for three major laboratory projects completed for the **Computer Architecture & Laboratory** course (2023-1) at the **University of Antioquia (Universidad de Antioquia - UdeA)**.

The projects span fundamental digital logic synthesis, low-level MIPS assembly programming, and single-cycle processor microarchitecture extension and simulation.

---

## 📌 Repository Overview

This collection showcases a bottom-up journey through computer systems engineering:
- **Hardware Fundamentals:** Designing finite state machines, excitation/output equations using Karnaugh maps, and logic-gate implementations.
- **Assembly Language & Software-Hardware Interface:** Developing modular, register-compliant MIPS32 assembly programs and managing standard I/O via system calls.
- **Processor Architecture:** Building a functional 32-bit single-cycle MIPS CPU, expanding its Datapath and Control Unit, and running custom software programs directly on top of hardware components.

---

## 🔬 Lab 1: Sequential Digital Circuit & Bit Sequence Detector

📁 **Directory:** [`Projects/Lab1`](./Projects/Lab1) | 📄 **Report:** [`Development Report.pdf`](./Projects/Lab1/Development%20Report.pdf)

### 🎯 Objective
Design, implement, structurally model, and simulate a sequential digital system capable of continuously detecting three specific binary bit sequences from a serial input stream and tracking occurrence counts on 7-segment decimal displays.

### 🏗️ Architecture & Features
- **Moore Finite State Machine (FSM):** Designed to continuously evaluate a 1-bit serial input synchronous with a clock signal. Supports overlapping sequence detection without resetting position unless an asynchronous reset occurs.
- **Sequence Detection Outputs ($S_1, S_2, S_3$):** Pulses high whenever sequence 1, 2, or 3 is matched in the input stream.
- **Custom Event Counters:** Constructed entirely from discrete flip-flops (SR/JK), avoiding pre-built vendor counter modules.
- **Visualization Component:**
  - Decoders built from truth tables and minimized Boolean expressions (Karnaugh maps).
  - Displays the current state of the FSM and decimal occurrence counts ($C_1, C_2, C_3$) using 7-segment display logic standards.
  - Implemented exclusively using fundamental **AND**, **OR**, and **NOT** gates.
- **Operational Specifications:** Operates up to **8 Hz clock frequency** for up to **30 seconds** of continuous operation.

---

## 🔬 Lab 2: MIPS Assembly Word Search Solver

📁 **Directory:** [`Projects/Lab2`](./Projects/Lab2) | 📄 **Report:** [`Development Report.pdf`](./Projects/Lab2/Development%20Report.pdf) | 📜 **Source Code:** [`word-search.asm`](./Projects/Lab2/word-search.asm)

### 🎯 Objective
Study the 32-bit MIPS Instruction Set Architecture (ISA) by designing, coding, assembling, simulating, and debugging a low-level algorithm that solves a letter search grid ("sopa de letras").

### 🏗️ Software Architecture & Features
- **Grid Input:** Parses a $50 \times 50$ matrix of uppercase English letters provided via a flat text file ([`wordsearch.txt`](./Projects/Lab2/wordsearch.txt)).
- **Multi-directional Search Engine:**
  - Evaluates words entered by the user interactively at runtime.
  - Searches in **horizontal** and **vertical** directions, reading **forward and backward**.
  - Output details exact starting coordinates `(Row, Column)` and search direction upon match detection.
- **Modular Design & Standards:**
  - Strictly follows the **MIPS Register Convention** (caller/callee saved registers, argument passing via `$a0-$a3`, returns via `$v0-$v1`).
  - Utilizes procedural decomposition and stack management (`$sp`) for nested calls.
- **Interactive I/O:** Uses MIPS `SYSCALL` services for text output, user prompts, file standard I/O, and status feedback.

---

## 🔬 Lab 3: Extended Single-Cycle MIPS32 Processor Design

📁 **Directory:** [`Projects/Lab3`](./Projects/Lab3) | 📄 **Report:** [`Development Report.pdf`](./Projects/Lab3/Development%20Report.pdf) | 💻 **CPU Model:** [`monocicle-cpu.circ`](./Projects/Lab3/monocicle-cpu.circ)

### 🎯 Objective
Construct, extend, and verify a complete functional **Single-Cycle 32-bit MIPS Processor** (Datapath + Control Unit) using **Logisim Evolution**, then validate hardware execution using a custom MIPS assembly test program compiled into machine code.

### 🏗️ Hardware Architecture & Features
- **Core MIPS Architecture:**
  - Baseline execution support for `lw`, `sw`, `add`, `sub`, `and`, `or`, `nor`, `slt`, `beq`, and `j`.
  - Extended branch and procedure jump support with `jal` (Jump and Link) and `jr` (Jump Register).
- **Hierarchical Register File Design:**
  - Multi-port 32x32-bit Register File constructed using fundamental 32-bit registers, decoders, and multiplexers.
  - Asynchronous read ports, synchronous write port.
  - Hardwired `$zero` register returning `0` constantly, protected against write overrides.
- **Instruction Set Expansion:**
  - Extended hardware datapath and main/ALU control logic to support custom assigned instruction pairs.
- **Hardware Program Execution:**
  - Hardware validated by running structured MIPS programs ([`Traduccion.asm`](./Projects/Lab3/Traduccion.asm)) loaded into Instruction/Data memory.

---

## 🛠️ Tools & Technologies

- **Logisim Evolution (v3.7.2+):** Digital logic design, schematic entry, structural modeling, and CPU simulation (`.circ`).
- **MARS (MIPS Assembler and Runtime Simulator):** Development, assembly, register tracing, and runtime execution of MIPS32 assembly programs (`Mars4_5.jar`).
- **Digital Logic Design:** Truth tables, Boolean algebra minimization, Karnaugh Maps (K-Maps), Prime/Essential Implicants extraction.
- **Assembly & Microarchitecture:** MIPS32 ISA, binary machine code encoding, Datapath & Control Unit design.

---

## 📁 Repository Structure

```text
.
├── Projects/
│   ├── Lab1/
│   │   ├── Development Report.pdf      # Lab 1 technical report
│   │   ├── Flip Flops Table.xlsx       # Flip-flop excitation tables & calculations
│   │   ├── Guide.pdf                   # Lab assignment guidelines
│   │   ├── README.md                   # Lab 1 specific documentation
│   │   └── sequence-counter.circ       # Logisim circuit implementation
│   │
│   ├── Lab2/
│   │   ├── Development Report.pdf      # Lab 2 technical report
│   │   ├── Guide.pdf                   # Lab assignment guidelines
│   │   ├── Mars4_5.jar                 # MARS MIPS simulator tool
│   │   ├── README.md                   # Lab 2 specific documentation
│   │   ├── word-search.asm             # Main MIPS assembly program
│   │   └── wordsearch.txt              # 50x50 letter matrix grid input
│   │
│   └── Lab3/
│       ├── Alternative.circ            # Alternative CPU implementation draft
│       ├── Development Report.pdf      # Lab 3 technical report
│       ├── Guide.pdf                   # Lab assignment guidelines
│       ├── Mars4_5.jar                 # MARS MIPS simulator tool
│       ├── monocicle-cpu.circ          # Main single-cycle MIPS CPU design
│       ├── RAM                         # Data memory contents / test data
│       ├── README.md                   # Lab 3 specific documentation
│       ├── ROM                         # Instruction memory machine code
│       └── Traduccion.asm              # Test program source code in assembly
│
└── README.md                           # Main repository documentation

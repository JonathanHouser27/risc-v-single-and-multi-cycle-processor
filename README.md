#RISC-V Processor Project

##Overview

This repository contains the design and implementation of a simple RISC-V processor using Verilog. The project aims to build a single-cycle processor initially and then expand to a multi-cycle design with increasing pipeline stages. The final goal is to compare the performance of different pipeline depths when running on a DE10-Lite FPGA.

##Objectives

Single-cycle Implementation: Design and implement a simple RISC-V processor with a single-cycle datapath.

Multi-cycle Expansion: Transition from a single-cycle to a multi-cycle design, starting with two stages and progressively increasing to a five-stage pipeline.

Performance Analysis: Evaluate and compare the performance of the different implementations in terms of speed and resource usage.

FPGA Deployment: Test implementations on a DE10-Lite FPGA.

Debugging: Learn and apply debugging techniques in both Quartus and ModelSim.

##Implementation Plan

Single-cycle Processor

Basic instruction fetch, decode, execute, memory, and write-back. c

Simple control and ALU logic. (Completed)

Two-stage Pipeline. (Completed)

Introduce an initial latch between stages. (Completed)

Handle hazards and ensure correctness. (Completed)

Five-stage Pipeline. (In-Progress)

Implement IF (Instruction Fetch), ID (Instruction Decode), EX (Execute), MEM (Memory Access), and WB (Write Back) stages. (In-Progress)

Optimize forwarding and hazard detection. (In-Progress)

Testing and Debugging. (In-Progress)

Simulate using ModelSim.

Synthesize in Quartus and test on DE10-Lite FPGA.

Compare execution times and resource utilization.

##Tools Used

Verilog: Hardware description language for processor design.

Quartus: FPGA development and synthesis.

ModelSim: Simulation and debugging.

DE10-Lite: FPGA board for hardware testing.

##Repository Structure



##Future Work

Implement additional RISC-V instructions.

Improve hazard handling and pipeline efficiency.

Optimize for lower power and higher performance.

Explore superscalar or out-of-order execution.

##Contact

For any questions or contributions, feel free to open an issue or submit a pull request!

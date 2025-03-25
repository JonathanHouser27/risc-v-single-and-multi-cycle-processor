# RISC-V Processor Project

## Overview

This repository contains the design and implementation of a simple RISC-V processor using Verilog. The project aims to build a single-cycle processor initially and then expand to a multi-cycle design with increasing pipeline stages. The final goal is to compare the performance of different pipeline depths when running on a DE10-Lite FPGA.

## Objectives

**Single-cycle Implementation:** Design and implement a simple RISC-V processor with a single-cycle datapath.

**Multi-cycle Expansion:** Transition from a single-cycle to a multi-cycle design, starting with two stages and progressively increasing to a five-stage pipeline.

**Performance Analysis:** Evaluate and compare the performance of the different implementations in terms of speed and resource usage.

**FPGA Deployment:** Test implementations on a DE10-Lite FPGA.

**Debugging:** Learn and apply debugging techniques in both Quartus and ModelSim.

## Implementation Plan

1. **Single-cycle Processor**  
   a. Basic instruction fetch, decode, execute, memory, and write-back.  
   b. Simple control and ALU logic.  

2. **Two-stage Pipeline**  
   a. Introduce an initial latch between stages.  
   b. Handle hazards and ensure correctness.  

3. **Five-stage Pipeline**  
   a. Implement IF (Instruction Fetch), ID (Instruction Decode), EX (Execute), MEM (Memory Access), and WB (Write Back) stages.  
   b. Optimize forwarding and hazard detection.  

4. **Testing and Debugging**  
   a. Simulate using ModelSim.  
   b. Synthesize in Quartus and test on DE10-Lite FPGA.  
   c. Compare execution times and resource utilization.  


## Tools Used

**Verilog:** Hardware description language for processor design.

**Quartus:** FPGA development and synthesis.

**ModelSim:** Simulation and debugging.

**DE10-Lite:** FPGA board for hardware testing.

## Repository Structure



## Future Work

1. Implement additional RISC-V instructions.

2. Improve hazard handling and pipeline efficiency.

3. Optimize for lower power and higher performance.

4. Explore superscalar or out-of-order execution.

## Contact

For any questions or contributions, feel free to open an issue or submit a pull request!

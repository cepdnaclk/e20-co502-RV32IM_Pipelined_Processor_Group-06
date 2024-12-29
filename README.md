RISC-V Computer Architecture with Pipelined Implementation
This project focuses on implementing a RISC-V computer architecture with a pipelined design. RISC-V is a free and open Instruction Set Architecture (ISA) designed to support a wide range of applications, from microcontrollers to high-performance processors. Its simplicity, modularity, and extensibility make it an ideal platform for both academic and industrial purposes.

In this implementation, we develop a pipelined architecture to enhance instruction throughput by overlapping the execution of multiple instructions. Key components include:

Instruction Fetch (IF): Retrieves instructions from memory.
Instruction Decode (ID): Decodes instructions and reads register data.
Execute (EX): Performs arithmetic, logical, and memory operations.
Memory Access (MEM): Handles data transfer between registers and memory.
Write Back (WB): Updates register values with execution results.

This repository includes the RTL design for core components, the register file, pipeline stages, and testbenches for verification.


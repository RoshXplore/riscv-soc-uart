# 32-bit RISC-V Processor with UART

This is a simple 32-bit (RV32I) RISC-V CPU core implemented in Verilog. It is integrated into a System-on-a-Chip (SoC) with data RAM, instruction ROM, and a memory-mapped UART for external communication.

This project is intended for simulation and as a learning tool for computer architecture.

## 🚀 Core Features

* **RISC-V Core (`top_riscv.v`):** A single-cycle RV32I processor that implements:
    * [cite_start]R-type instructions (ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND) [cite: 243-253]
    * [cite_start]I-type instructions (ADDI, SLLI, SLTI, SLTIU, XORI, SRLI, SRAI, ORI, ANDI, LW, JALR) [cite: 66, 77]
    * [cite_start]S-type instructions (SW) [cite: 81]
    * [cite_start]B-type instructions (BEQ, BNE, BLT, BGE, BLTU, BGEU) [cite: 86-94]
    * [cite_start]U-type instructions (LUI, AUIPC) [cite: 94-96]
    * [cite_start]J-type instructions (JAL) [cite: 97]
* [cite_start]**UART Peripheral (`uart_top.v`):** A full UART transmitter and receiver with a 16-byte FIFO buffer for received data[cite: 24, 34].
* [cite_start]**SoC (`soc.v`):** The top-level module that connects the CPU, RAM, and UART using memory-mapped I/O [cite: 176, 182-184].
* **Memory:**
    * [cite_start]`instruction_memory.v`: A 1KB ROM, pre-loaded with a test program [cite: 37, 42-49].
    * [cite_start]`data_memory.v`: A 32-word (128-byte) RAM for the CPU to read and write[cite: 107].

## 🗺️ Memory Map

The CPU interacts with its peripherals by reading from and writing to specific addresses.

| Address | R/W | Description |
| --- | --- | --- |
| `0x00000000` - `0x0000007C` | R/W | [cite_start]32-word Data RAM [cite: 184, 186, 191] |
| `0x10000000` | R/W | [cite_start]**UART Data Register** [cite: 177] [cite_start]<br> **Write:** Sends a byte to the TX FIFO [cite: 185, 187-188]. [cite_start]<br> **Read:** Reads a byte from the RX FIFO[cite: 189]. |
| `0x10000004` | R | [cite_start]**UART Status Register** [cite: 177] [cite_start]<br> `bit 0`: `rx_ready` (1 = byte waiting in FIFO)[cite: 190]. [cite_start]<br> `bit 1`: `tx_busy` (1 = UART is currently sending)[cite: 190]. |

## 📁 Key Modules

* [cite_start]`soc.v`: Top-level System-on-a-Chip[cite: 176].
* [cite_start]`top_riscv.v`: The complete RISC-V CPU[cite: 193].
    * [cite_start]`control_unit.v`: Decodes instructions and generates control signals[cite: 50].
    * [cite_start]`data_path.v`: Contains the ALU, registers, and multiplexers[cite: 1].
    * [cite_start]`alu.v`: The Arithmetic Logic Unit[cite: 242].
    * [cite_start]`register_file.v`: The 32 CPU registers (x0-x31)[cite: 228].
* [cite_start]`uart_top.v`: The complete UART peripheral[cite: 24].
    * [cite_start]`uart_tx.v`: Transmit FSM[cite: 156].
    * [cite_start]`uart_rx.v`: Receive FSM[cite: 129].
    * [cite_start]`FIFO_buffer.v`: 16-byte storage for received data[cite: 212].
    * [cite_start]`baud_gen.v`: Generates the UART clock ticks[cite: 118].
* [cite_start]`data_memory.v`: The CPU's RAM[cite: 105].
* [cite_start]`instruction_memory.v`: The CPU's ROM with the hard-coded program[cite: 36].

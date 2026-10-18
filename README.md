# UART Transmitter & Receiver 

I built this project to understand how serial communication works at the RTL level, from transmitting parallel data one bit at a time to reconstructing it at the receiver.

The design uses a Finite State Machine (FSM) to control UART transmission and reception, PISO and SIPO shift registers for data conversion, and a counter-based baud generator for bit timing.

### Design Highlights
- 8-bit UART communication with start and stop bits
- LSB-first serial transmission
- FSM-based TX and RX control
- Counter-based baud timing
- Integrated TX-to-RX loopback using a top-level module
- Receiver completion and framing-error signals

### Simulation Results

Verified the complete loopback design in Vivado simulation.

| Transmitted | Received | Status |
|---|---|---|
| `9D` | `9D` | Pass |
| `AA` | `AA` | Pass |

### Tech Stack
Verilog HDL · Xilinx Vivado · RTL Simulation

### Key Learning
Hands-on practice with sequential logic, FSM design, shift registers, timing control, and modular RTL integration.


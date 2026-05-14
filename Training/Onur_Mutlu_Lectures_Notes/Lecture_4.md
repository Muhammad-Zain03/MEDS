# Lecture 4: Sequential Logic Design, FSMs, and FPGAs

## 1. Asynchronous vs. Synchronous
| Asynchronous | Synchronous |
| :--- | :--- |
| State transition occurs when they occur. | State transition takes place after a fixed unit of time. |
| Difficult to debug. | Easy to debug. |

**Clock signal** is used to keep track of time. 

---

## 2. Finite State Machine (FSM)
Pictorially shows the state and how a transition occurs.

**5 Elements of an FSM:**
1. Finite States
2. Finite external input
3. Finite external output
4. Specification of all state transitions
5. Specification of what determines each external output value

**3 Main Parts:**
1. Next state logic
2. State Register
3. Output logic

### FSM Types
*   **Moore FSM** $\rightarrow$ Output only depends on the *current state*.
*   **Mealy FSM** $\rightarrow$ Output depends on the *current state* AND *input*.

### How to Solve FSM Problems:
1. Analyze
2. State transition diagram
3. Truth table (Includes state encoding)
4. Schematic (Timing Diagram for verification)

### FSM State Encodings
| 1. Fully Encoded | 2. 1-Hot Encoded | 3. Output Encoded |
| :--- | :--- | :--- |
| Uses minimal bits. Needs log_2 (num_states) to represent. | Uses num_states bits to represent state. Exactly 1 bit is "hot". | Outputs are directly accessible in the state encoding. |

---

## 3. The Problem with D-Latches
It is **transparent**. Unwanted changes propagate immediately when the clock/enable is high.

**Solution: D-Flip Flop**
*   Uses two back-to-back D-Latches.
*   Resolves the issue of transparency / metastability.
*   It is an **Edge-triggered** state element (samples only on the rising/falling edge of the clock).

---

## 4. What is an FPGA?
**Field Programmable Gate Array (FPGA):** A software-reconfigurable hardware substrate.
*   Contains **Look-Up Tables (LUTs)**, switches, and interconnects.
*   **LUTs:** Act like memory arrays used to perform any truth table / logic function.
*   **Tradeoffs:** High flexibility, lower development cost, and short time to market compared to ASICs. However, they are not as fast or power-efficient as dedicated ASICs.

---

## 5. Hardware Description Languages (HDL) & Verilog
We use HDLs to describe, simulate, and synthesize hardware. 

**Two Main Styles:**
1.  **Structural:** Gate-level description. Describes how modules are interconnected (like drawing a schematic in text).
2.  **Behavioral:** High-level functional description (uses logical/math operators, if-else, etc.).

### Blocking vs. Non-Blocking Assignments (Crucial!)

*   **Blocking (=):**
    Assignments are made immediately. Process waits until the first is complete (blocks progress).
    Used for **Combinational** logic (inside always @(*)).

*   **Non-Blocking (<=):**
    Assignments are made in parallel at the end of the block.
    Used for **Sequential** logic (inside always @(posedge clk)).



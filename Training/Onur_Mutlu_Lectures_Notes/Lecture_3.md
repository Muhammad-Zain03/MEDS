# Lecture 3: Sequential Logic & Advanced Combinational Blocks

## 1. More Combinational Blocks
Combinational circuits are memoryless and depend only on current inputs.

*   **Comparator:** Checks if $N$-input values are exactly the same (e.g., an Equality Checker).
*   **ALU (Arithmetic Logic Unit):** Combines a variety of arithmetic and logical operations into a single unit.
*   **Tri-State Buffer:** Enables gating of different signals onto a single wire.
    *   **Uses:** Prevents collisions of values when connecting multiple components (like CPU and Memory) to a shared bus, and helps in making Multiplexers.
    *   **Implementation:** Uses CMOS (p-type and n-type transistors) with an Enable (EN) signal.

---

## 2. Logic Simplification
**Why simplify?** To reduce the number of gates/inputs, which lowers implementation cost and latency.

*   **The Uniting Theorem:** Eliminate the expression that is not making a difference. If an input changes its value but the output stays the same, that input is eliminated.
*   **Karnaugh Maps (K-Maps):** A pictorial way of minimizing circuits by visualizing opportunities for simplification.

---

## 3. Sequential Circuits
**Sequential Circuit = Combinational Circuit + Storage Element**
Unlike combinational logic, sequential logic **has memory** (it depends on past and current inputs).

**Storage Technology Tradeoffs (Cost & Speed):**
> Latches & Flip-Flops (Fastest, Expensive) > Static RAM > Dynamic RAM > Other Storage Tech (Slowest, Cheapest)

### Basic Storage Elements
*   **Cross-Coupled Inverters:** Has two stable states (0 or 1), but lacks a control mechanism to set the value.
*   **SR (Set-Reset) Latch:** Uses two cross-coupled NAND gates.
    *   $S=1, R=1 \rightarrow$ Idle (Holds $Q_{prev}$).
    *   $S=0, R=1 \rightarrow Q=1$ (Set).
    *   $R=0, S=1 \rightarrow Q=0$ (Reset).
    *   $S=0, R=0 \rightarrow$ **Forbidden!** Causes metastability.
*   **Gated D-Latch:** Uses a "Write Enable" (WE) signal to control when the input (D) is captured for reliable storage[cite: 3]. This prevents the forbidden $S=0, R=0$ state.
*   **D Flip-Flop:** Solves the transparency problem of latches[cite: 3]. It is **edge-triggered**, meaning it only captures data on the rising edge of the clock (when it transitions from 0 to 1), making the data available for the full clock cycle.

---

## 4. Registers and Memory

*   **Register:** A parallel combination of D Flip-Flops used for storing multiple bits simultaneously.
*   **Memory:** A combination of registers where every memory location has a unique address.
    *   **Addressing Memory:** Done using an Address Decoder + Registers + Multiplexers.
    *   Data is written only when the Write Enable (WE) signal is active.

---

## 5. Finite State Machines (FSM)
An FSM is a discrete-time model of a stateful system. A "State" is a snapshot of all relevant elements of the system at a specific time. Transitions between states are synchronized by a **Clock**.

**FSMs consist of:** State Registers, Next State Logic, and Output Logic.

| FSM Type | Output Logic Behavior |
| :--- | :--- |
| **Moore Machine** | Outputs depend **only** on the current state. |
| **Mealy Machine** | Outputs depend on the current state **AND** the current inputs. |


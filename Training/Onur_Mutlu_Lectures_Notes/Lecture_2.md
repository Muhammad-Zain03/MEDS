# Lecture 2: Combinational Logic

## 1. Underlying Operational Characteristics of CMOS
*   **n-type:** Good at passing **0** (pulling down), but bad at pulling up.
*   **p-type:** Good at passing **1** (pulling up), but bad at pulling down.
*   *Reason:* It goes down to physics (electrons vs. holes).
*   **Series combination** of MOS transistors increases latency due to higher wire resistance.

---

## 2. Power Consumption
*   **Static Power:** Power used while the circuit is idle (not switching).
    *   Formula: $V * I_{leakage}$.
*   **Dynamic Power:** Power used to charge capacitance while switching states.
    *   Formula: $C * V^2 * f$.
    *   ($C$ = capacitance, $V$ = supply voltage, $f$ = frequency).
    *   Capacitance $\propto$ wire length.
*   **Energy Consumption:** Power * Time.

---

## 3. Moore's Law
*   The number of transistors on an integrated circuit doubles approximately every two years (keeping area constant).
*   Implies the manufacturing cost of transistors decreases over time.

---

## 4. How We Build Logic Circuits
*   **Logic Circuit:** Inputs $\rightarrow$ [ Functional Spec + Timing Spec ] $\rightarrow$ Outputs.
    *   *Functional Spec:* The input/output relation.
    *   *Timing Spec:* The latency/delay.
*   **Types of Logic Circuits:**
    1.  **Combinational Logic:** Memoryless (output strictly depends on current inputs).
    2.  **Sequential Logic:** Has memory (output depends on historical and current inputs).

---

## 5. Boolean Algebra & DeMorgan's Law
*   **Duality:** You can flip a true expression into its dual form.
    *   Swap: AND $\leftrightarrow$ OR, $1 \leftrightarrow 0$.
    *   Literals and their complements won't change.
*   **DeMorgan's Law:** Helpful in keeping gates of choice in your design.
    *   (X + Y + Z ...)' = X' . Y' . Z' ...
    *   (X . Y . Z ...)' = X' + Y' + Z' ...
*   **Why simplify?** To reduce implementation cost, gates, and latency.

---

## 6. Function Representation
Standard (canonical) ways to represent a truth table:
*   **SOP (Sum of Products):** Sum of **Minterms** $\rightarrow$ evaluates all input combinations that result in a **1**.
*   **POS (Product of Sums):** Product of **Maxterms** $\rightarrow$ evaluates all input combinations that result in a **0**.
*   *Conversion Example:* $\Sigma m(1,3,5) \leftrightarrow \Pi M(0,2,4,6,7)$.

---

## 7. Combinational Blocks
Groups of combinational circuits packed into larger building blocks.

### 1. Decoder
*   $n$ inputs $\rightarrow$ [ Decoder ] $\rightarrow 2^n$ outputs.
*   Exactly one output is 1 (one-hot), the rest are 0s.
*   Used to interpret a bit pattern (e.g., an address in memory).

### 2. Multiplexer (MUX)
*   $N$ inputs $\rightarrow$ [ MUX ] $\rightarrow 1$ output.
*   Selects an input to connect to the output based on the **select signal**.

### 3. Full Adder
*   $a, b, C_{in} \rightarrow$ [ Adder ] $\rightarrow S, C_{out}$.
*   Performs 1-bit binary addition.
*   A series combo gives an **N-bit adder** (but increases latency).

### 4. Programmable Logic Array (PLA)
*   $n$ inputs $\rightarrow$ [ PLA ] $\rightarrow$ outputs.
*   Consists only of AND, OR, and Inverter gates.
*   **We program the connections:** Connect the output of an AND gate to the input of an OR gate if the corresponding minterm is included in the SOP.

# Lecture 1: Introduction, Fundamentals, Transistors, Gates

## 1. How Does a Computer Solve Problems?
By orchestrating electrons to play as per the requirement.

**The Transformation Hierarchy:**
> **Problem** $\rightarrow$ **Algorithm** $\rightarrow$ **Program/Language** $\rightarrow$ **System Software** $\rightarrow$ **SW/HW Interface (ISA)** $\rightarrow$ **Micro-architecture** $\rightarrow$ **Logic** $\rightarrow$ **Devices** $\rightarrow$ **Electrons**

*   **ISA (Instruction Set Architecture):** The contract/interface between software and hardware.
*   **Micro-architecture:** The specific implementation of the ISA (flexible and can vary).

---

## 2. What is a Computer?
A computer consists of 3 key components:
1.  **Computation** (Computing Unit)
2.  **Communication** (Communication Unit)
3.  **Memory/Storage** (Memory System & Storage System)

---

## 3. General Purpose vs. Special Purpose Systems

| General Purpose Systems (e.g., CPU) | Special Purpose Systems (e.g., ASICs) |
| :--- | :--- |
| **Flexible:** Can run any program. | **Not flexible:** Limited to specific tasks. |
| **Easier** to program and handle. | **Difficult** to program and handle. |
| **Not the best** for max performance/efficiency. | **Highly efficient** for its specific application. |

---

## 4. Transistors (The Building Blocks)
Transistors are fundamentally used as **switches** to make logic gates. Modern computers use **MOS** (Metal-Oxide-Semiconductor) transistors.

**Two Types of MOS Transistors:**

*   **n-type MOS:**
    *   Gate = **3V (High)** $\rightarrow$ Switch **CLOSED** (Circuit is ON).
    *   Gate = **0V (Low)** $\rightarrow$ Switch **OPEN** (Circuit is OFF).
    *   *Characteristic:* Good at pulling **DOWN** to 0V.
*   **p-type MOS:**
    *   Gate = **0V (Low)** $\rightarrow$ Switch **CLOSED** (Circuit is ON).
    *   Gate = **3V (High)** $\rightarrow$ Switch **OPEN** (Circuit is OFF).
    *   *Characteristic:* Good at pulling **UP** to 3V.

---

## 5. Logic Gates (CMOS)
We build logic gates using **CMOS** technology.
> **nMOS + pMOS = CMOS (Complementary MOS)**

**General CMOS Structure:**
*   **p-MOS Pull-up Network:** Connects the output to the High Voltage (3V).
*   **n-MOS Pull-down Network:** Connects the output to the Low Voltage (0V).
*   *Rule:* Only one network should be ON at a time to prevent a short circuit.

**Transistor Configurations:**
*   **Parallel:** Network is ON if **one** transistor is ON.
*   **Series:** Network is ON if **all** transistors are ON.

**Example: CMOS NOT Gate (Inverter)**
*   If Input (A) = **3V (High)** $\rightarrow$ nMOS is ON, pMOS is OFF $\rightarrow$ Output (Y) = **0V (Low)**.
*   If Input (A) = **0V (Low)** $\rightarrow$ pMOS is ON, nMOS is OFF $\rightarrow$ Output (Y) = **3V (High)**.
*   *Logic:* Y = NOT A

***

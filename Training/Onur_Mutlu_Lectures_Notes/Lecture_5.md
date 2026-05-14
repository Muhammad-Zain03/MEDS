# Lecture 5: Hardware Description Languages, Timing, and Verification

## Design Methodology

There are two main approaches to digital design:

| Approach | Direction | Flow |
|----------|-----------|------|
| **Top-Down** | High → Low | Top Module → Sub-modules → Leaf cells |
| **Bottom-Up** | Low → High | Leaf cells → Sub-modules → Top Module |

> **Leaf cells** are the basic gates at the lowest level of abstraction.

---

## Defining a Module in Verilog

A **module** is the basic building block in Verilog. You define its inputs, outputs, and internal logic.


```verilog
module example (a, b, c, y);
    input a;
    input b;
    input c;
    output y;

endmodule
```


### Manipulating Bits

| Operation | Syntax | Description |
|-----------|--------|-------------|
| Multi-bit definition | [3:0] a | Creates a 4-bit bus |
| Bit slicing | a[3:1] | Grabs a portion of the bits |
| Bit concatenation | a[2], a[0] | Combines specific bits together |
| Bit duplication | 4{a[0]} | Copies a bit multiple times |

### Number Representation

Numbers follow the format: **N'Bxx**

| Symbol | Meaning |
|--------|---------|
| N | Number of bits |
| B | Base (b binary, h hex, d decimal, o octal) |
| xx | The actual value |

**Example:**
8'b0000_0001   // 8-bit binary number (value = 1)
---

## HDL Implementation Styles

| Style | Description |
|-------|-------------|
| **Structural** | Gate-level. Sub-modules are instantiated and connected via wires. Shows exactly how hardware is wired. |
| **Behavioral** | Functional. Behavior is defined using operators rather than explicit gates. Higher level of abstraction. |

---

## HDL Workflow

HDL Code  ──►  Synthesis  ──►  Simulation

## Parameterized Modules

Variables allow modules to be reused with different sizes:

#(parameter width = 8)


> Wherever width is used in the module, it will be replaced by 8.

---

## Good Practices

- Use consistent naming conventions
- Use **MSB to LSB** ordering for buses (e.g., [31:0])
- Keep **one module per file**
- File name should **match the module name**
- Always remember: Verilog **describes hardware behavior** — it is not standard software code

---

## Sequential Logic in Verilog

Sequential logic has **memory** and relies on clock transitions.

- State transitions are triggered by the clk signal
- Uses the 'always' construct with posedge (rising edge) or negedge (falling edge)

### Sync vs. Async Reset

| Reset Type | Behavior |
|------------|----------|
| **Synchronous** | Depends on the clock — reset only happens when the clock ticks |
| **Asynchronous** | Independent of the clock — resets instantly when the reset signal is triggered |

### The `always` Block

- Sequential statements must go inside an 'always' block
- The block is triggered by a change in its **sensitivity list**
- Any signal assigned inside an 'always' block must be declared as 'reg'
- Do **NOT** use the 'assign' keyword inside an 'always' block

> **Using 'always' for Combinational Logic:**
> You can use 'always' blocks for combinational logic if the output is *always* updated for every possible condition — this allows use of 'if', 'else', and 'case' statements.

### Blocking vs. Non-Blocking Assignments

| Assignment | Operator | Behavior |
|------------|----------|----------|
| **Blocking** | = | Each assignment is made immediately; the process waits (acts like standard software) |
| **Non-Blocking** | <= | All assignments are evaluated first, then made at the end of the block (parallel execution) |

**Rule of thumb:** Always use **non-blocking (<=)** for sequential logic!

---

## Circuit Timing Basics

In the real world, gates take time to process signals.

| Term | Symbol | Definition |
|------|--------|------------|
| **Contamination Delay** | $t_{cd}$ | Shortest possible delay — time until the output *starts* changing |
| **Propagation Delay** | $t_{pd}$ | Longest possible delay (Critical Path) — time until the output *finishes* changing |

> **Glitches:** When one input transition causes multiple temporary output transitions due to paths with different delays. Usually ignorable if only the final steady state matters.

---

## Timing in Sequential Circuits

Flip-flops require stable data to function correctly.

| Parameter | Definition |
|-----------|------------|
| **Setup Time** ($t_{setup}$) | Time data must be stable **before** the clock edge |
| **Hold Time** ($t_{hold}$) | Time data must be stable **after** the clock edge |

If data changes during either of these windows, **metastability** occurs — the output gets stuck between 0 and 1.

### Timing Constraints

**1. Setup Time Constraint**

The clock period must be long enough to accommodate:

$$T_c \geq t_{pcq} + t_{pd} + t_{setup}$$

| Symbol | Meaning |
|--------|---------|
| $T_c$ | Clock cycle time |
| $t_{pcq}$ | Clock-to-Q propagation delay |
| $t_{pd}$ | Logic propagation delay |
| $t_{setup}$ | Flip-flop setup time |

**2. Hold Time Constraint**

The shortest path must be long enough:

$$t_{ccq} + t_{cd} > t_{hold}$$

| Symbol | Meaning |
|--------|---------|
| $t_{ccq}$ | Clock-to-Q contamination delay |
| $t_{cd}$ | Logic contamination delay |
| $t_{hold}$ | Flip-flop hold time |

**Clock Skew:** Clock signals don't arrive everywhere simultaneously. Clock skew is the time difference between clock edges at different flip-flops — this makes meeting timing constraints harder.

---

## Verification

| Type | Description | Method |
|------|-------------|--------|
| **Functional Verification** | Checks if logic is correct (ignoring physical timing) | **Testbenches** — feed test vectors into the Device Under Test (DUT) and check outputs |
| **Timing Verification** | Checks setup, hold, and skew constraints | Done mostly by **synthesis tools** |




# Parameterized Weighted Round-Robin (WRR) Arbiter

A robust, fully parameterized hardware arbiter designed in SystemVerilog. This module guarantees fair and proportional access to a shared resource among multiple requesters based on dynamically programmable weights, while strictly preventing starvation. 

This project was developed as part of the **MEDS Lab Module 4: SystemVerilog for Digital Design** (Summer Training Programme 2026, Cohort 4).

## 📌 Features

* **Fully Parameterized:** Configurable number of requesters (`N`) and weight bit-width (`WEIGHT_W`).
* **Strict Ratio Enforcement:** Allocates grants proportionally based on each requester's assigned weight.
* **Zero Starvation:** Employs a dynamic priority rotator. Once a requester exhausts its weight or drops its request, priority physically rotates to the next requester, mathematically bounding the maximum wait time.
* **Registered Outputs:** Follows rigorous hardware design rules by decoupling the combinational brain from the sequential outputs. All grants and pointer updates emerge cleanly on the positive clock edge, preventing combinational glitches.
* **Credit Dropping:** Requesters that drop their request mid-turn immediately forfeit their remaining weight credits, preventing unfair "credit banking".

## 📂 Repository Structure

```text
├── rtl/
│   ├── weighted_rr_arbiter.sv  # Top-level FSM and registered output logic
│   ├── priority_rotator.sv     # Combinational pointer rotation and request masking
│   └── weight_counter.sv       # Down-counter for tracking active grant usage
├── tb/
│   ├── tb_directed.sv          # Sanity checks and edge-case verification
│   └── tb_random_fairness.sv   # Stress tests, ratio math, and starvation bounding
└── README.md
# Clock Dividers in Verilog

This repository provides Verilog implementations of various digital clock division techniques, ranging from structural counter designs to parameterized behavioral models and odd-division 50% duty cycle circuits. Each module includes a dedicated testbench and simulation waveform snippets.

---

## 📁 Repository Structure

```plaintext
Clock-Dividers/
├── 1.Synchronous_CLK_DIV/
│   ├── DFF.v
│   ├── SYNCH_DIV_CLK.v
│   ├── SYNCH_DIV_CLK_tb.v
│   └── Snippet1.jpg, Snippet2.jpg
├── 2.Asynchronous_CLK_DIV/
│   ├── DFF.v
│   ├── ASYNCH_DIV_CLK.v
│   ├── ASYNCH_DIV_CLK_tb.v
│   └── Snippet.jpg
├── 3.MODN_Counter/
│   ├── DFF.v
│   ├── NDFF.v
│   ├── MOD5_CLK_DIV.v
│   ├── Mod5_Clk_Div_tb.v
│   └── Snippet.jpg
├── 4.Behavioral_CLK_DIV/
│   ├── CLK_DIV.v
│   ├── CLK_DIV_tb.v
│   └── Snippet.jpg
└── 5.Ring_Counter_CLK_DIV/
    └── Ring_Counter_Div4.v
```

---

## ⚙️ Architecture & Implementations

### 1. Synchronous Clock Divider (`1.Synchronous_CLK_DIV`)
* **Division Factor:** Divide-by-8 ($2^3$)
* **Duty Cycle:** 50%
* **Architecture:** 
  * Built using three cascaded D Flip-Flops driven by a single common input clock (`clk`).
  * Implements synchronous next-state combinational logic:
    * $D_0 = \overline{Q_0}$
    * $D_1 = Q_1 \oplus Q_0$
    * $D_2 = Q_2 \oplus (Q_1 \cdot Q_0)$
  * Eliminates accumulated ripple delay and ensures synchronized clock edges.

---

### 2. Asynchronous (Ripple) Clock Divider (`2.Asynchronous_CLK_DIV`)
* **Division Factor:** Divide-by-8 ($2^3$)
* **Duty Cycle:** 50%
* **Architecture:**
  * Implements a 3-stage ripple counter using toggle D Flip-Flops.
  * The output of each flip-flop acts as the clock source for the next stage ($Q_0 \rightarrow \text{clk}_1$, $Q_1 \rightarrow \text{clk}_2$).
  * Demonstrates low hardware area, with trade-offs in accumulated propagation delay across stages.

---

### 3. Odd Integer Division with 50% Duty Cycle (`3.MODN_Counter`)
* **Division Factor:** Divide-by-5
* **Duty Cycle:** 50%
* **Architecture:**
  * Uses a Mod-5 counter (`0` to `4`) to produce an asymmetrical pulse active for 2 out of 5 cycles (`count_is_low = counter < 2`).
  * `signal_A` is registered on the **positive** edge of the clock.
  * `signal_B` registers `signal_A` on the **negative** edge of the clock (introducing a $0.5 \times T_{\text{clk}}$ phase shift).
  * The final clock output is generated via `o_clk = signal_A | signal_B`, extending the high duration to exactly 2.5 cycles for a 50% duty cycle.

---

### 4. Parameterized Behavioral Clock Divider (`4.Behavioral_CLK_DIV`)
* **Division Factor:** Configurable integer division
* **Duty Cycle:** 50%
* **Parameters:**
  * `INPUT_FREQ` (Default: `10_000_000` / 10 MHz)
  * `TARGET_FREQ` (Default: `1_000_000` / 1 MHz)
* **Architecture:**
  * Dynamically evaluates the counter threshold:
    $$\text{COUNTER\_THRESHOLD} = \frac{\text{INPUT\_FREQ}}{2 \times \text{TARGET\_FREQ}} - 1$$
  * Automatically calculates required counter bit-width using `$clog2(COUNTER_THRESHOLD + 1)`.
  * Toggles the output register `o_clk` upon reaching the threshold.

---

### 5. Ring Counter Clock Divider (`5.Ring_Counter_CLK_DIV`)
* **Division Factor:** Divide-by-4
* **Duty Cycle:** 50%
* **Architecture:**
  * Employs a 4-bit circulating shift register initialized to `4'b1000`.
  * Shifts right on each clock edge: `q <= {q[0], q[3:1]}`.
  * Output clock is formed using OR logic on the first two states (`o_clk_div4 = q[3] | q[2]`), maintaining a high state for 2 cycles and a low state for 2 cycles.

---

## 🛠️ Simulation & Verification

Each folder contains Verilog testbenches to verify timing behavior, reset conditions, and frequency scaling:
* **Simulators:** ModelSim / QuestaSim / Icarus Verilog / Vivado Simulator
* **Waveform Views:** Included `.jpg` snippets illustrate expected output transitions and duty cycle alignment.

---

## 📜 License
This project is open-source and available under the [MIT License](LICENSE).


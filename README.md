# 🧠 LPC2148 ADC and GPIO-Based LED Control

This project demonstrates **Analog-to-Digital Conversion (ADC)** and **GPIO control** on the **LPC2148 ARM7 microcontroller**. The program reads an analog signal using the on-chip ADC (AD0.1 on P0.28) and visualizes its digital value through LEDs connected to GPIO pins P0.0–P0.9.

---

## ⚙️ Features
- Configures **GPIO (P0.0–P0.9)** as LED output pins.
- Initializes **ADC channel AD0.1 (P0.28)** for 10-bit analog input.
- Continuously reads ADC values and displays the corresponding binary pattern on LEDs.
- Demonstrates **polling-based ADC conversion** and **bit manipulation** in ARM assembly.

---

## 🧩 Technical Details
| Component | Description |
|------------|-------------|
| **Microcontroller** | LPC2148 (ARM7TDMI-S) |
| **Language** | ARM Assembly |
| **Peripherals Used** | ADC0 (Channel 1), GPIO Port 0 |
| **ADC Resolution** | 10-bit |
| **LED Pins** | P0.0 – P0.9 |
| **ADC Input Pin** | P0.28 (AD0.1) |

---

## 🧱 Code Structure
| Section | Purpose |
|----------|----------|
| `LED_INIT` | Configures GPIO pins as outputs for LEDs |
| `ADC_INIT` | Configures P0.28 as AD0.1 and initializes ADC |
| `ADC_START` | Triggers ADC conversion |
| `wait_adc` | Waits until ADC conversion completes |
| `ADC_READ` | Reads ADC result and updates LED output |

---

## 🚀 How It Works
1. The program initializes GPIO pins (P0.0–P0.9) as LED outputs.
2. Sets up ADC0 channel 1 (P0.28) for analog input.
3. Continuously starts ADC conversions in a loop.
4. Once conversion completes, the 10-bit digital value is extracted and displayed as a binary pattern on the LEDs.

---

## 🧠 Learning Outcomes
- Hands-on understanding of **ADC initialization and data reading** in ARM7 assembly.
- Practical use of **GPIO control** through direct register access.
- Familiarity with **bitwise operations** for embedded control logic.

---

## 🛠️ Tools & Environment
- **Simulator:** [CPUlator](https://cpulator.01xz.net/?sys=arm) or Keil µVision
- **Processor:** LPC2148 (ARM7TDMI-S)
- **Assembler:** ARM Keil Assembler or GNU ARM toolchain

---

## 📁 File
- `Main.s` — complete source code (fully commented).

---

## ✍️ Author
**Mina Malak Habib**  
Backend & Embedded Systems Developer  
📍 Cairo, Egypt  
🔗 [LinkedIn](https://linkedin.com/in/mina-malak1)

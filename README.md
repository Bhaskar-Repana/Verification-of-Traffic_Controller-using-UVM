🚦 TRAFFIC LIGHT CONTROLLER
OVERVIEW

This project implements a single-direction Traffic Light Controller using a Finite State Machine (FSM).
The controller simulates real-world traffic signal behavior by cycling through RED, GREEN, and YELLOW states in a fixed, safe sequence.

The design is synchronous, lightweight, and suitable for educational use, RTL design practice, and integration into FPGA or ASIC-based systems.

FEATURES

• Traffic Signal Control
• Sequential control of RED, GREEN, and YELLOW lights

• FSM-Based Design
• Moore FSM implementation
• Deterministic and glitch-free outputs

• Synchronous Operation
• State transitions on rising edge of the clock

• Safe Reset Behavior
• System initializes to RED state on reset

• Extensible Architecture
• Can be extended with timers, pedestrian signals, or multi-direction control

INPUT PORTS
Signal	Description
clk	System clock
reset	Resets the controller to RED state
OUTPUT PORTS
Signal	Description
red	Red traffic signal
green	Green traffic signal
yellow	Yellow traffic signal

Only one output is asserted at any time.

FUNCTIONAL MODES
• a. RED Mode
The controller activates the RED signal, indicating that traffic must stop.

• b. GREEN Mode
The controller activates the GREEN signal, allowing vehicles to proceed.

• c. YELLOW Mode
The controller activates the YELLOW signal, warning that the signal will soon return to RED.

State Sequence
RED → GREEN → YELLOW → RED



Each state is maintained for a predefined number of clock cycles before transitioning to the next state.

STATE DIAGRAM
![image alt](https://github.com/Bhaskar-Repana/Verification-of-Traffic_Controller-using-UVM/blob/b6d55d9929acf9d295adb924775915ae8a83a687/ChatGPT%20Image%20Jan%2020%2C%202026%2C%2002_01_56%20PM.png)
BLOCK DIAGRAM
DESIGN NOTES

• Moore FSM ensures stable outputs
• Reset guarantees a safe startup condition
• Clock-driven design simplifies timing analysis

APPLICATIONS
• Traffic signal simulation
• FSM learning reference
• RTL design practice
• FPGA/ASIC prototyping

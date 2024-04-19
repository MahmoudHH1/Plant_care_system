# Automated Plant Care System

This project implements an automated plant care system with two stages: watering the plant and dispensing plant fertilizers. The system is designed to be started by the user using a button or equivalent input.

## Features:

**1. Stage 1: Watering the Plant**
   - The system activates a water pump for a specific duration, delivering water to the plant.
   - During this stage, an LED indicator is switched on to signify that watering is in progress.

**2. Stage 2: Dispensing Plant Fertilizers**
   - After Stage 1 completes, the system automatically dispenses plant fertilizers using a motor.
   - A separate LED indicator is activated during this stage to indicate fertilizer dispensation.

**3. Stop Button**
   - Users can stop the plant care system at any time using a dedicated stop button.

---

## How to Use:
1. Connect the necessary hardware components according to the provided schematic.
2. Upload the Arduino code to the microcontroller.
3. Start the system by pressing the start button.
4. The system will proceed through Stage 1 (watering) and then Stage 2 (fertilizer dispensation) automatically.
5. To stop the system, press the stop button.

## Hardware Requirements:
- Microcontroller (e.g., FPGA)
- Water pump
- Motor for fertilizer dispensation
- LEDs for stage indication
- Pushbuttons for start and stop functionalities

## Usage Notes:
- Ensure proper wiring and setup of hardware components.
- Adjust the duration of watering and fertilizer dispensation as per plant requirements.
- Use caution when handling electrical components and ensure safety measures are followed.

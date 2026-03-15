# 🤖 UV Robot — WiFi-Based UV Sterilization Rover

> A WiFi-controlled autonomous rover designed for UV-C light sterilization of indoor spaces, built on the ESP32 microcontroller with multi-mode operation and real-time obstacle avoidance.

**Course:** Sensors, Signaling, and Actuators for Robotics Projects  
**Institution:** Robotics & AI Program, International School of Engineering, Chulalongkorn University  
**Team:** Group 7

---

## 📸 Demo

<!-- Add your demo video/gif here -->
> 📹 [Watch Demo Video](https://drive.google.com/file/d/1JeQz50utpnxkjiIbzJG-_JRKKQNz1ejt/view?usp=drive_link) 
> 🖼️ [View Photos](https://drive.google.com/file/d/12jlzWtBlpQ9sVgGAVUVX2YMD9mKA2D8Q/view?usp=sharing)

---

## 🧠 Overview

UV Robot is a rover that sterilizes indoor floor surfaces using UV-C light while navigating autonomously or under user control via a browser interface. The entire system is hosted on the ESP32 — no dedicated app required.

The robot supports three operating modes:
- **Manual Mode** — directional control via web browser with adjustable speed
- **Autonomous Mode** — real-time obstacle avoidance using sensor fusion
- **Replay Mode** — records and replays a user-defined path

---

## ⚙️ Hardware Components

| Component | Role |
|---|---|
| ESP32 Microcontroller | Central control unit, WiFi access point, web server host |
| 2× DRV8825 Stepper Motor Driver | Precise differential drive motor control |
| HC-SR04 Ultrasonic Sensor | Forward-facing obstacle detection (2–400 cm) |
| 2× VCNL4040 Proximity Sensor | Left and right obstacle detection |
| UV-C Light Module (Blue LEDs) | Surface sterilization simulation |

---

## 🌐 Web Interface

The ESP32 hosts its own WiFi access point (`UVRobot-AP`) and serves a single-page control interface accessible from any browser — no installation needed.

**To connect:**
1. Connect to WiFi: `UVRobot-AP` / password: `uvrobot123`
2. Open browser and navigate to `192.168.4.1`

**Interface features:**
- Mode toggle: Manual / Auto / Replay
- Directional arrow controls with speed slider
- Live mode status display
- Auto-disables manual controls during autonomous mode

---

## 🚗 Autonomous Obstacle Avoidance Logic

```
Loop:
  Poll HC-SR04 (front) + 2× VCNL4040 (left, right)
  If any sensor detects obstacle within 20 cm:
    → Stop
    → Turn toward side with greater clearance
  Else:
    → Move forward
  (Can be interrupted by mode switch at any time)
```

---

## 🔁 Replay Mode

The robot records each motor command during a manual drive session. On replay, the exact sequence is re-executed — allowing repeatable sterilization coverage of a predefined area.

---

## 🖨️ Mechanical Design

The chassis and all sensor/component mounts were designed in **Fusion 360**, optimized for:
- Stable stepper motor mounting
- 3-directional sensor coverage (front, left, right)
- Underside LED placement for floor-level UV exposure

---

## 📂 Source Code

> 📄 [View Full Source Code](https://docs.google.com/document/d/1KcTgr6wMzwXce8EQF2wxJRzU5BR06szdUlokP8Rm3IM/edit?usp=sharing)

---

## 🔬 Key Findings

- ESP32 reliably handles **concurrent tasks**: WiFi AP, web server, sensor polling, and motor control in a single main loop
- Browser-based control proved more practical than Bluetooth or dedicated apps for multi-device classroom use
- Sensor fusion (ultrasonic + dual proximity) provides reliable 3-directional obstacle detection
- Stepper motors enable precise turning angles compared to DC motors

---

## ⚠️ Limitations & Future Work

- VCNL4040 limited to 2 units due to I²C address constraints (only 2 I²C ports available on ESP32)
- Blue LEDs used as UV-C proxy due to budget constraints — real UV-C module can be added via 12V power line
- Replay mode relies on open-loop timing; odometry or encoder feedback would improve path accuracy
- Future: ROS2 integration for full navigation stack and SLAM capability

---

## 👥 Team Contributions

| Member | Role |
|---|---|
| Pannavit Hurattanapirom | 3D mechanical design (Fusion 360), chassis & sensor mounts |
| Daniel Nooranal | Electrical design|
| Thanyathorn Boonthanom | Hardware|
| Ei Thinn Lae Aung | Hardware|
| Nanon Pattayanun | Webpage |
| Passakorn Chongnumcharoenchai | Electrical design|

> *Fill in your teammates' roles as appropriate*

---

## 📖 References

- Espressif Systems, [ESP32 Technical Reference Manual](https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf)
- Texas Instruments, [DRV8825 Datasheet](https://www.ti.com/lit/ds/symlink/drv8825.pdf)
- [HC-SR04 Ultrasonic Sensor Datasheet](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf)
- Walker & Ko, "Effect of Ultraviolet Germicidal Irradiation on Viral Aerosols," *Environmental Science & Technology*, 2007

---

*Robotics & AI Program · International School of Engineering · Chulalongkorn University*

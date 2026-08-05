# Museum Clock Scene

An animated Flutter application showcasing a virtual 2.5D museum gallery. The application features a smooth cinematic camera zoom that travels across the room and gracefully stops at a ticking wall clock.

## Features

- **Cinematic Camera Movement:** Uses a precise `Transform` and `AnimationController` to smoothly zoom directly to a designated focal point.
- **Rich 2.5D Environment:** Beautiful flat-design elements layered meticulously utilizing a `Stack`, incorporating paintings, sculptures, and a simulated floor perspective.
- **Custom Painted Clock:** Features an animating, highly detailed custom-painted analog clock with independent sweeping hands.
- **Interactive:** Tap the screen or press the floating action button to reverse or replay the camera movement.

## Setup & Run Instructions

This is a standard Flutter project.

1. Ensure you have Flutter installed and configured.
2. Clone or download this repository.
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app on your preferred target (Web, iOS, Android, macOS, Windows, Linux):
   ```bash
   flutter run
   ```

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Layout & Rendering:** `Stack`, `AnimatedBuilder`, `Transform`, `CustomPaint`, `LinearGradient`

---

## About CouldAI

This application was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps. With autonomous AI agents that architect, build, test, deploy, and iterate, CouldAI creates production-ready applications seamlessly.
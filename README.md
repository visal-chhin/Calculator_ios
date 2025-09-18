# calculator

A new Flutter project.

## Getting Started

# Flutter Calculator Project

This is a **Flutter calculator app** using BLoC for state management.  
You can run it on **mobile or web**.

---

## 📝 Features

- Basic operations: `+`, `-`, `×`, `÷`, `%` (modulo)
- Decimal support
- Clear, Delete, Equals buttons
- Toggle sign `+/-`

---

## 💻 Prerequisites

Make sure you have installed:

1. **Flutter SDK**: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. **Dart SDK** (comes with Flutter)
3. **VS Code** with **Flutter & Dart extensions**
4. Optional: Chrome or Edge for web testing

---

## 📂 Clone the Project

Open a terminal and run:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
Replace YOUR_USERNAME and YOUR_REPOSITORY with your GitHub info.

⚡ Run on Web
Ensure web support is enabled:

bash
Copy code
flutter config --enable-web
Check devices:

bash
Copy code
flutter devices
You should see Chrome or Edge listed.

Run the app:

bash
Copy code
flutter run -d chrome
This will launch the calculator in a browser.

⚡ Run on Mobile (Android/iOS)
Connect your device or start an emulator.

Check devices:

bash
Copy code
flutter devices
Run the app:

bash
Copy code
flutter run
The app will open on your connected device or emulator.

📂 Project Structure
vbnet
Copy code
lib/
 ├─ bloc/
 │   ├─ calculator_bloc.dart
 │   ├─ calculator_event.dart
 │   └─ calculator_state.dart
 └─ ui/
     └─ calculator.dart
bloc/: BLoC files handling the calculator logic

ui/: Flutter UI for the calculator

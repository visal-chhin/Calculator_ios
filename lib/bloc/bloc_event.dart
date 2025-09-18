// lib/bloc/bloc_event.dart
abstract class CalculatorEvent {}

class NumberPressed extends CalculatorEvent {
  final String number;
  NumberPressed(this.number);
}

class DecimalPressed extends CalculatorEvent {}

class OperatorPressed extends CalculatorEvent {
  final String operator;
  OperatorPressed(this.operator);
}

class ClearPressed extends CalculatorEvent {}

class DeletePressed extends CalculatorEvent {}

class EqualsPressed extends CalculatorEvent {}

class ToggleSignPressed extends CalculatorEvent {}

class PercentPressed extends CalculatorEvent {}

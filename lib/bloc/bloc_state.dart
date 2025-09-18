// lib/bloc/bloc_state.dart
class CalculatorState {
  final String display;
  final String? previous;
  final String? operator;

  CalculatorState({
    this.display = '0',
    this.previous,
    this.operator,
  });

  CalculatorState copyWith({
    String? display,
    String? previous,
    String? operator,
  }) {
    return CalculatorState(
      display: display ?? this.display,
      previous: previous ?? this.previous,
      operator: operator ?? this.operator,
    );
  }
}

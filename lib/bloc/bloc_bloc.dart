// lib/bloc/bloc_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  bool _shouldResetDisplay = false; // flag to start fresh after "="

  CalculatorBloc() : super(CalculatorState()) {
    on<NumberPressed>(_onNumberPressed);
    on<DecimalPressed>(_onDecimalPressed);
    on<OperatorPressed>(_onOperatorPressed);
    on<EqualsPressed>(_onEqualsPressed);
    on<ClearPressed>(_onClearPressed);
    on<DeletePressed>(_onDeletePressed);
    on<ToggleSignPressed>(_onToggleSignPressed);
    on<PercentPressed>(_onPercentPressed);
  }

  void _onNumberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    // Start new number if just showed result
    final display = (_shouldResetDisplay || state.display == '0')
        ? event.number
        : state.display + event.number;

    _shouldResetDisplay = false; // reset after starting new input
    emit(state.copyWith(display: display));
  }

  void _onDecimalPressed(DecimalPressed event, Emitter<CalculatorState> emit) {
    if (_shouldResetDisplay) {
      emit(state.copyWith(display: '0.'));
      _shouldResetDisplay = false;
    } else if (!state.display.contains('.')) {
      emit(state.copyWith(display: state.display + '.'));
    }
  }

  void _onOperatorPressed(OperatorPressed event, Emitter<CalculatorState> emit) {
    // If user presses operator after result, use current display as previous
    final previousValue = (_shouldResetDisplay || state.previous == null) ? state.display : state.previous!;
    emit(state.copyWith(previous: previousValue, operator: event.operator, display: '0'));
    _shouldResetDisplay = false;
  }

  void _onEqualsPressed(EqualsPressed event, Emitter<CalculatorState> emit) {
    if (state.previous != null && state.operator != null) {
      final result = _calculate(state.previous!, state.operator!, state.display);
      emit(state.copyWith(display: result, previous: null, operator: null));
      _shouldResetDisplay = true; // next number press will start fresh
    }
  }

  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    emit(CalculatorState());
    _shouldResetDisplay = false;
  }

  void _onDeletePressed(DeletePressed event, Emitter<CalculatorState> emit) {
    if (_shouldResetDisplay || state.display == '0') {
      // If just showed result, delete resets display
      emit(state.copyWith(display: '0'));
      _shouldResetDisplay = false;
      return;
    }

    if (state.display.isNotEmpty && state.display != '0') {
      final newDisplay = state.display.length > 1
          ? state.display.substring(0, state.display.length - 1)
          : '0';
      emit(state.copyWith(display: newDisplay));
    }
  }

  void _onToggleSignPressed(ToggleSignPressed event, Emitter<CalculatorState> emit) {
    if (state.display.startsWith('-')) {
      emit(state.copyWith(display: state.display.substring(1)));
    } else if (state.display != '0') {
      emit(state.copyWith(display: '-' + state.display));
    }
  }

  void _onPercentPressed(PercentPressed event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(previous: state.display, operator: '%', display: '0'));
    _shouldResetDisplay = false;
  }

  String _calculate(String aStr, String operator, String bStr) {
    final a = double.tryParse(aStr) ?? 0.0;
    final b = double.tryParse(bStr) ?? 0.0;
    double res;

    switch (operator) {
      case '+':
        res = a + b;
        break;
      case '-':
        res = a - b;
        break;
      case '×':
        res = a * b;
        break;
      case '÷':
        res = b == 0 ? double.nan : a / b;
        break;
      case '%':
        res = a % b; // modulo operator
        break;
      default:
        res = b;
    }
    return _formatDouble(res);
  }

  String _formatDouble(double val) {
    if (val % 1 == 0) return val.toInt().toString();
    return val.toStringAsFixed(4).replaceFirst(RegExp(r'0*$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
}

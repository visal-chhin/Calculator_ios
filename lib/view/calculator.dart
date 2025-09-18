import 'package:calculator/bloc/bloc_bloc.dart';
import 'package:calculator/bloc/bloc_event.dart';
import 'package:calculator/bloc/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  Widget _buildButton(BuildContext context, String text, {double flex = 1}) {
    final isOperator = ['+', '-', '×', '÷', '=', '%'].contains(text);
    final isGrey = ['AC', 'DEL'].contains(text);

    final bgColor = isOperator
        ? Colors.orange
        : (isGrey ? Colors.grey[700] : Colors.grey[300]);
    final textColor = (isOperator || isGrey) ? Colors.white : Colors.black;

    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () {
            final bloc = context.read<CalculatorBloc>();
            switch (text) {
              case 'AC':
                bloc.add(ClearPressed());
                break;
              case 'DEL':
                bloc.add(DeletePressed());
                break;
              case '+':
              case '-':
              case '×':
              case '÷':
              case '%':
                bloc.add(OperatorPressed(text));
                break;
              case '=':
                bloc.add(EqualsPressed());
                break;
              case '+/-':
                bloc.add(ToggleSignPressed());
                break;
              case '.':
                bloc.add(DecimalPressed());
                break;
              default:
                bloc.add(NumberPressed(text));
                break;
            }
          },
          child: Text(text, style: TextStyle(fontSize: 24, color: textColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    return Text(
                      state.display,
                      style: const TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Buttons
            Column(
              children: [
                Row(
                  children: [
                    _buildButton(context, 'AC'),
                    _buildButton(context, '%'),
                    _buildButton(context, 'DEL'),
                    _buildButton(context, '÷'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton(context, '7'),
                    _buildButton(context, '8'),
                    _buildButton(context, '9'),
                    _buildButton(context, '×'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton(context, '4'),
                    _buildButton(context, '5'),
                    _buildButton(context, '6'),
                    _buildButton(context, '-'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton(context, '1'),
                    _buildButton(context, '2'),
                    _buildButton(context, '3'),
                    _buildButton(context, '+'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton(context, '+/-'),
                    _buildButton(context, '0'),
                    _buildButton(context, '.'),
                    _buildButton(context, '='),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

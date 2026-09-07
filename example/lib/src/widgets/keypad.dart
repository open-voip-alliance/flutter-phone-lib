import 'package:flutter/material.dart';

const _keys = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
  ['*', '0', '#'],
];

class Keypad extends StatelessWidget {
  const Keypad({super.key, required this.onKeyPressed});

  final void Function(String key) onKeyPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in _keys)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final key in row)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        textStyle: Theme.of(context).textTheme.headlineSmall,
                      ),
                      onPressed: () => onKeyPressed(key),
                      child: Text(key),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

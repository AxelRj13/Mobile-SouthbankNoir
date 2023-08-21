import 'package:flutter/material.dart';

class SBRadioButton<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const SBRadioButton({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: (newValue) {
              onChanged(newValue!);
            },
          ),
          Expanded(
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

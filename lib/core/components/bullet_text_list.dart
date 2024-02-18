import 'package:flutter/material.dart';

class SBBulletTextList extends StatelessWidget {
  final List<String> textList;

  const SBBulletTextList({
    super.key,
    required this.textList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: textList
          .map(
            (text) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("\u2022"),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(text),
                )
              ],
            ),
          )
          .toList(),
    );
  }
}

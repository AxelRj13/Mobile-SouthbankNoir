import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String? message;

  const NotFoundWidget({
    super.key,
    this.message = 'The content you are looking for was not found',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info, size: 40.0),
        const SizedBox(height: 10.0),
        Text(message!),
      ],
    );
  }
}

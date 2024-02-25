import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatelessWidget {
  final bool isDetail;
  final String? message;

  const GeneralErrorWidget({
    super.key,
    this.isDetail = false,
    this.message = 'An error occurred while processing the data.',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info, size: 40.0),
        const SizedBox(height: 10.0),
        Text(message!),
        if (!isDetail) const Text('Please pull to refresh the content.'),
      ],
    );
  }
}

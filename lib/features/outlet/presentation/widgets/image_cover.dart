import 'package:flutter/material.dart';

class ImageCover extends StatelessWidget {
  final String? image;

  const ImageCover({
    super.key,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image != null ? NetworkImage(image!) : const AssetImage('assets/img/logo.png') as ImageProvider,
        ),
      ),
    );
  }
}

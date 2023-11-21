import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';

class AnimatedCheck extends StatefulWidget {
  const AnimatedCheck({super.key});

  @override
  State<AnimatedCheck> createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck> with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  late Animation<double> scaleAnimation = CurvedAnimation(
    parent: scaleController,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            scaleController.forward(from: 0.0);
          }
        });
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            color: backgroundColor,
            size: 90.0,
          ),
        ),
      ),
    );
  }
}

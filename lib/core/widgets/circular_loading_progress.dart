import 'package:flutter/material.dart';

class CircularLoadingProgress extends StatelessWidget {
  const CircularLoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.black,
      strokeWidth: 2,
    );
  }
}

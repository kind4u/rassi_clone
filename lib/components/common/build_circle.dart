import 'package:flutter/material.dart';

class BuildCircle extends StatelessWidget {
  final String label;
  final int count;
  final double size;
  final Color color;

  const BuildCircle({
    super.key,
    required this.label,
    required this.count,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.2,
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
            Text(
              '$count',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.35,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

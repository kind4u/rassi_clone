import 'package:flutter/material.dart';

/// 주식 가격 표시를 위한 공통 컴포넌트
/// 한국 주식 시장 스타일: 상승=빨강, 하락=파랑
class PriceChangeText extends StatelessWidget {
  final String price;
  final String change;
  final bool isUp;
  final double fontSize;
  final FontWeight fontWeight;

  const PriceChangeText({
    super.key,
    required this.price,
    required this.change,
    required this.isUp,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    final color = isUp ? Colors.red : Colors.blue;
    
    return Row(
      children: [
        Text(
          price,
          style: TextStyle(
            fontSize: fontSize + 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          change,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}

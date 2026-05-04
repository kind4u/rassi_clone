import 'package:flutter/material.dart';

class CompareCard extends StatelessWidget {
  const CompareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 6,
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            TypeOfStock(
              typeLabel: '메모리기판',
              stockCount: 5,
              percentageChange: 4.72,
            ),

            SizedBox(height: 16),
            Container(height: 1, color: Colors.grey.shade300),
            SizedBox(height: 16),

            TypeOfStock(
              typeLabel: 'FC-BGA',
              stockCount: 3,
              percentageChange: 2.99,
            ),

            SizedBox(height: 16),
            Container(height: 1, color: Colors.grey.shade300),
            SizedBox(height: 16),

            TypeOfStock(
              typeLabel: '원격의료',
              stockCount: 4,
              percentageChange: 2.63,
            ),
          ],
        ),
      ),
    );
  }
}

class TypeOfStock extends StatelessWidget {
  final String typeLabel;
  final int stockCount;
  final double percentageChange;

  const TypeOfStock({
    super.key,
    required this.typeLabel,
    required this.stockCount,
    required this.percentageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          typeLabel,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$stockCount종목', style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFB535B),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(4.0),
              child: Text(
                '${percentageChange > 0 ? '+' : ''}${percentageChange.toStringAsFixed(2)}%',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

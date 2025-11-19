import 'package:flutter/material.dart';

class StockInfoItem extends StatelessWidget {
  final String stockName;
  final String stockNumber;
  final String? stockValue;

  const StockInfoItem({
    super.key,
    required this.stockName,
    required this.stockNumber,
    this.stockValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(stockName, style: TextStyle(fontSize: 18)),
            Text(
              stockNumber,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade300),
            ),
          ],
        ),
        Text(stockName),
      ],
    );
  }
}

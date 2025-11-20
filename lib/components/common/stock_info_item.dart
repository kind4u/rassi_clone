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

  static const TextStyle _stockNameStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle _stockNumberStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle _stockValueBaseStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  Color _getValueColor() {
    if (stockValue == null) return Colors.black;

    final value = stockValue!;
    // 하락: '-'로 시작
    if (value.startsWith('-')) return Colors.blue;
    // 상승: '+'로 시작하거나 양수
    if (value.startsWith('+')) return Colors.red;

    // 숫자만 있는 경우 파싱해서 판단
    final numValue = double.tryParse(value);
    if (numValue != null && numValue > 0) return Colors.red;

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(stockName, style: _stockNameStyle),
            const SizedBox(width: 4),
            Text(stockNumber, style: _stockNumberStyle),
          ],
        ),
        const SizedBox(width: 8),
        if (stockValue != null)
          Text(
            '${stockValue!}%',
            style: _stockValueBaseStyle.copyWith(color: _getValueColor()),
          ),
      ],
    );
  }
}

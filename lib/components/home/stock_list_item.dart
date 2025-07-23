import 'package:flutter/material.dart';
import '../../models/stock_models.dart';
import '../common/price_change_text.dart';

/// 주식 아이템을 표시하는 리스트 타일 컴포넌트
class StockListItem extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;

  const StockListItem({
    super.key,
    required this.stock,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stock.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            PriceChangeText(
              price: stock.price,
              change: stock.change,
              isUp: stock.isUp,
            ),
          ],
        ),
      ),
    );
  }
}

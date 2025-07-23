import 'package:flutter/material.dart';
import '../../models/stock_models.dart';

/// 시장 지수를 표시하는 카드 컴포넌트
class MarketIndexCard extends StatelessWidget {
  final MarketIndex index;

  const MarketIndexCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = index.isUp ? Colors.red : Colors.blue;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            index.value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            index.change,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

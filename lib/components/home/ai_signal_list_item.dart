import 'package:flutter/material.dart';
import '../../models/stock_models.dart';

/// AI 신호를 표시하는 리스트 아이템 컴포넌트
class AISignalListItem extends StatelessWidget {
  final AISignal signal;
  final VoidCallback? onTap;

  const AISignalListItem({
    super.key,
    required this.signal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColorBySignalType(signal.type);
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              signal.stockName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    signal.signal,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  signal.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorBySignalType(SignalType type) {
    switch (type) {
      case SignalType.buy:
        return Colors.red;
      case SignalType.sell:
        return Colors.blue;
      case SignalType.hold:
        return Colors.orange;
    }
  }
}

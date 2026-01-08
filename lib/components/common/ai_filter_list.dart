import 'package:flutter/material.dart';

/// 필터 주식 데이터 (이 파일 내부에서만 사용)
class _FilterStockData {
  final String stockName;
  final String stockCode;
  final String returnRate;

  const _FilterStockData({
    required this.stockName,
    required this.stockCode,
    required this.returnRate,
  });
}

class AIFilterList extends StatelessWidget {
  final List<Map<String, String>> items;

  const AIFilterList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _AIFilterItem.cardHeight + 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final data = _FilterStockData(
            stockName: items[index]['stockName']!,
            stockCode: items[index]['stockCode']!,
            returnRate: items[index]['returnRate']!,
          );
          return _AIFilterItem(data: data);
        },
      ),
    );
  }
}

/// 개별 필터 카드 아이템 (이 파일 내부에서만 사용)
class _AIFilterItem extends StatelessWidget {
  final _FilterStockData data;
  static const double cardHeight = 120.0;

  const _AIFilterItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth / 3.3;
    final isPositive = data.returnRate.startsWith('+');

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 상단: 주식 이름 + 종목 코드
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data.stockName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data.stockCode,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              // 하단: 수익률
              Column(
                children: [
                  Text(
                    '수익률',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isPositive ? Colors.red : Colors.blue,
                    ),
                  ),
                  Text(
                    data.returnRate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isPositive ? Colors.red : Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

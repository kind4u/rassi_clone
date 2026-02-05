import 'package:flutter/material.dart';

class FilterStockCard extends StatelessWidget {
  final String stockName;
  final String stockCode;
  final String descriptionName;
  final String descriptionDetail;
  static const double cardSize = 150.0;

  const FilterStockCard({
    super.key,
    required this.stockName,
    required this.stockCode,
    required this.descriptionName,
    required this.descriptionDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SizedBox(
          width: cardSize,
          height: cardSize,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 주식 이름 + 주식 번호
                Column(
                  children: [
                    Text(
                      stockName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stockCode,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                // 상세 제목 + 상세 수치
                Column(
                  children: [
                    Text(
                      descriptionName,
                      style: TextStyle(fontSize: 14, color: Colors.redAccent),
                    ),
                    Text(
                      descriptionDetail,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

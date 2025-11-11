import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/build_circle.dart';

class AiDescriptionCard extends StatelessWidget {
  const AiDescriptionCard({super.key});

  // 매수/매도 수치 비교해서 크기 비율 계산
  Map<String, double> _calculateSizes(int buyCount, int sellCount) {
    const double baseSize = 60.0;

    if (buyCount == sellCount) {
      // 1:1 비율
      return {'buy': baseSize, 'sell': baseSize};
    } else if (buyCount > sellCount) {
      // 3:2 비율
      return {'buy': baseSize * 1.3, 'sell': baseSize * 0.7};
    } else {
      // 2:3 비율
      return {'buy': baseSize * 0.7, 'sell': baseSize * 1.3};
    }
  }

  // Circle 위젯 생성 (내부에 라벨과 숫자)

  @override
  Widget build(BuildContext context) {
    // 예시 매수/매도 수치
    const int buyCount = 24;
    const int sellCount = 17;

    final sizes = _calculateSizes(buyCount, sellCount);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'AI는 현재 데이터를 수집,학습에\n반영 중입니다.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(width: 12),

                  Row(
                    crossAxisAlignment: buyCount > sellCount
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 매수 circle
                      BuildCircle(
                        label: '매수',
                        count: buyCount,
                        size: sizes['buy']!,
                        color: Colors.red,
                      ),

                      // 매도 circle
                      BuildCircle(
                        label: '매도',
                        count: sellCount,
                        size: sizes['sell']!,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF424242).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'asd종목',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '보유중',
                    style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
                  ),
                  Text(
                    '+50.6%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '(2일전 매수)',
                    style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AiDescriptionCard extends StatelessWidget {
  const AiDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AI는 현재 데이터를 수집,학습에\n반영 중입니다.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 8),
              ],
              // icon 매수
              // icon 매도
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

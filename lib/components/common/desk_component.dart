import 'package:flutter/material.dart';

/// 데스크 컴포넌트 - 특정 레이아웃을 가진 카드형 위젯
class DeskComponent extends StatelessWidget {
  final VoidCallback? onTap;

  const DeskComponent({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100], // 더 밝은 회색
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 첫 번째 줄: 보라색 capsule + 시계 아이콘 + "시간 외 정보"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(16), // capsule 모양
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '시간 외 정보',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            
            // 두 번째 줄: 큰 폰트 텍스트
            const Text(
              '주요 종목 분석 리포트',
              style: TextStyle(
                fontSize: 16, // 기본보다 2포인트 크게
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            
            // 세 번째 줄: 보라색 해시태그 2개
            Row(
              children: [
                _buildHashTag('#AI분석'),
                const SizedBox(width: 8),
                _buildHashTag('#투자전략'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHashTag(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.deepPurple,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
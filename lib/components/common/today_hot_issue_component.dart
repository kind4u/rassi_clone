import 'package:flutter/material.dart';

/// 버블 데이터 모델
class BubbleData {
  final String label;
  final double size;
  final double x; // 중심 x 비율 (0.0 ~ 1.0)
  final double y; // 중심 y 비율 (0.0 ~ 1.0)
  final Color color;

  const BubbleData({
    required this.label,
    required this.size,
    required this.x,
    required this.y,
    required this.color,
  });
}

class TodayHotIssueComponent extends StatefulWidget {
  const TodayHotIssueComponent({super.key});

  @override
  State<TodayHotIssueComponent> createState() => _TodayHotIssueComponentState();
}

class _TodayHotIssueComponentState extends State<TodayHotIssueComponent> {
  // 색상 정의
  static const Color _darkRed = Color(0xFFE53935);
  static const Color _mediumPink = Color(0xFFF48FB1);
  static const Color _lightPink = Color(0xFFF8BBD9);

  // 하드코딩된 버블 데이터 (이미지 기준)
  final List<BubbleData> _bubbles = const [
    // 큰 버블들 (중앙)
    BubbleData(label: '석유화학', size: 100, x: 0.32, y: 0.52, color: _darkRed),
    BubbleData(label: '은행', size: 85, x: 0.62, y: 0.52, color: _mediumPink),

    // 중간 버블들
    BubbleData(label: '증권', size: 70, x: 0.45, y: 0.30, color: _mediumPink),
    BubbleData(label: '보험', size: 65, x: 0.22, y: 0.32, color: _mediumPink),
    BubbleData(label: '지주회사', size: 68, x: 0.72, y: 0.30, color: _mediumPink),
    BubbleData(label: '2차전지', size: 65, x: 0.72, y: 0.72, color: _mediumPink),
    BubbleData(
      label: '냉각\n솔루션',
      size: 68,
      x: 0.48,
      y: 0.75,
      color: _mediumPink,
    ),
    BubbleData(label: '초전도체', size: 62, x: 0.25, y: 0.75, color: _mediumPink),
    BubbleData(label: 'HBM', size: 58, x: 0.85, y: 0.55, color: _mediumPink),

    // 작은 버블들
    BubbleData(label: '자동차', size: 48, x: 0.35, y: 0.12, color: _lightPink),
    BubbleData(
      label: '우크라\n재건',
      size: 52,
      x: 0.08,
      y: 0.48,
      color: _mediumPink,
    ),
    BubbleData(label: '제약\n바이오', size: 48, x: 0.90, y: 0.38, color: _lightPink),
    BubbleData(label: '음식료', size: 50, x: 0.08, y: 0.68, color: _mediumPink),
    BubbleData(label: '반도체', size: 45, x: 0.35, y: 0.92, color: _lightPink),
    BubbleData(label: '방산', size: 48, x: 0.58, y: 0.90, color: _mediumPink),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 날짜 표시
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Text(
            '02/12 KST 기준',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),

        // 버블 클라우드 영역
        SizedBox(
          height: 400,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                clipBehavior: Clip.none,
                children: _bubbles.map((bubble) {
                  final centerX = constraints.maxWidth * bubble.x;
                  final centerY = 400 * bubble.y;

                  return Positioned(
                    left: centerX - bubble.size / 2,
                    top: centerY - bubble.size / 2,
                    child: _buildBubble(bubble),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBubble(BubbleData bubble) {
    // 텍스트 크기는 버블 크기에 비례
    final fontSize = bubble.size * 0.18;

    return GestureDetector(
      onTap: () {
        // TODO: 버블 탭 시 해당 테마 상세로 이동
        debugPrint('Tapped: ${bubble.label}');
      },
      child: Container(
        width: bubble.size,
        height: bubble.size,
        decoration: BoxDecoration(
          color: bubble.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: bubble.color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            bubble.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

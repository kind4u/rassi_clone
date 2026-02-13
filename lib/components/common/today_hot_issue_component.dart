import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 입력 데이터 모델 - 라벨과 값(중요도)만 필요
class HotIssueItem {
  final String label;
  final int value; // 중요도 (높을수록 버블이 큼)

  const HotIssueItem({required this.label, required this.value});
}

/// 내부용 - 위치가 계산된 버블
class _PositionedBubble {
  final String label;
  final double radius;
  final Color color;
  double x;
  double y;

  _PositionedBubble({
    required this.label,
    required this.radius,
    required this.color,
    this.x = 0,
    this.y = 0,
  });
}

/// Circle Packing 알고리즘
class _CirclePacker {
  final double width;
  final double height;
  final double minRadius;
  final double maxRadius;
  final List<Color> colorPalette;
  final double spacing; // 버블 간 간격

  _CirclePacker({
    required this.width,
    required this.height,
    this.minRadius = 25,
    this.maxRadius = 55,
    required this.colorPalette,
    this.spacing = 2, // 기본 간격 2px (기존 4px에서 절반으로)
  });

  List<_PositionedBubble> pack(List<HotIssueItem> items) {
    if (items.isEmpty) return [];

    // value 기준 내림차순 정렬
    final sortedItems = List<HotIssueItem>.from(items)
      ..sort((a, b) => b.value.compareTo(a.value));

    // value → radius 변환 (정규화)
    final maxValue = sortedItems.first.value;
    final minValue = sortedItems.last.value;
    final valueRange = maxValue - minValue;

    final bubbles = <_PositionedBubble>[];
    final centerX = width / 2;
    final centerY = height / 2;

    for (var i = 0; i < sortedItems.length; i++) {
      final item = sortedItems[i];

      // value를 radius로 변환
      double normalizedValue = valueRange > 0
          ? (item.value - minValue) / valueRange
          : 0.5;
      final radius = minRadius + (maxRadius - minRadius) * normalizedValue;

      // 색상 선택 (중요도에 따라)
      final colorIndex = (normalizedValue * (colorPalette.length - 1)).round();
      final color = colorPalette[colorPalette.length - 1 - colorIndex];

      final bubble = _PositionedBubble(
        label: item.label,
        radius: radius,
        color: color,
      );

      // 위치 찾기
      if (i == 0) {
        // 첫 번째(가장 큰) 버블은 중앙에
        bubble.x = centerX;
        bubble.y = centerY;
      } else {
        // 나선형 탐색으로 충돌하지 않는 위치 찾기
        _findPosition(bubble, bubbles, centerX, centerY);
      }

      bubbles.add(bubble);
    }

    return bubbles;
  }

  void _findPosition(
    _PositionedBubble bubble,
    List<_PositionedBubble> existingBubbles,
    double centerX,
    double centerY,
  ) {
    // 나선형 탐색 파라미터
    double angle = 0;
    double distance = 0;
    const double angleStep = 0.3;
    const double distanceStep = 3;
    const int maxAttempts = 2000;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final x = centerX + distance * math.cos(angle);
      final y = centerY + distance * math.sin(angle);

      // 경계 체크
      final margin = bubble.radius;
      if (x - margin < 0 ||
          x + margin > width ||
          y - margin < 0 ||
          y + margin > height) {
        angle += angleStep;
        distance += distanceStep * 0.1;
        continue;
      }

      // 충돌 체크
      bool hasCollision = false;
      for (final existing in existingBubbles) {
        final dx = x - existing.x;
        final dy = y - existing.y;
        final dist = math.sqrt(dx * dx + dy * dy);
        final minDist = bubble.radius + existing.radius + spacing;

        if (dist < minDist) {
          hasCollision = true;
          break;
        }
      }

      if (!hasCollision) {
        bubble.x = x;
        bubble.y = y;
        return;
      }

      angle += angleStep;
      distance += distanceStep * 0.1;
    }

    bubble.x = centerX;
    bubble.y = centerY;
  }
}

class TodayHotIssueComponent extends StatefulWidget {
  const TodayHotIssueComponent({super.key});

  @override
  State<TodayHotIssueComponent> createState() => _TodayHotIssueComponentState();
}

class _TodayHotIssueComponentState extends State<TodayHotIssueComponent>
    with TickerProviderStateMixin {
  // 색상 팔레트 (중요도: 낮음 → 높음)
  static const List<Color> _colorPalette = [
    Color(0xFFE53935),
    Color(0xFFEC407A),
    Color(0xFFF48FB1),
    Color(0xFFF8BBD9),
  ];

  // 데이터
  final List<HotIssueItem> _items = const [
    HotIssueItem(label: '석유화학', value: 95),
    HotIssueItem(label: '은행', value: 85),
    HotIssueItem(label: '증권', value: 70),
    HotIssueItem(label: '보험', value: 65),
    HotIssueItem(label: '지주회사', value: 68),
    HotIssueItem(label: '2차전지', value: 65),
    HotIssueItem(label: '냉각\n솔루션', value: 68),
    HotIssueItem(label: '초전도체', value: 62),
    HotIssueItem(label: 'HBM', value: 58),
    HotIssueItem(label: '자동차', value: 48),
    HotIssueItem(label: '우크라\n재건', value: 52),
    HotIssueItem(label: '제약\n바이오', value: 48),
    HotIssueItem(label: '음식료', value: 50),
    HotIssueItem(label: '반도체', value: 45),
    HotIssueItem(label: '방산', value: 48),
  ];

  List<_PositionedBubble>? _positionedBubbles;
  List<AnimationController>? _animationControllers;
  List<Animation<double>>? _scaleAnimations;
  bool _isInitialized = false;

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  void _disposeAnimations() {
    if (_animationControllers != null) {
      for (final controller in _animationControllers!) {
        controller.dispose();
      }
    }
  }

  void _initAnimations(int count) {
    _disposeAnimations();

    _animationControllers = List.generate(count, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1900),
      );
    });

    _scaleAnimations = _animationControllers!.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();

    final random = math.Random();
    for (var i = 0; i < _animationControllers!.length; i++) {
      final delay = random.nextInt(200);
      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted && _animationControllers != null) {
          _animationControllers![i].forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 12),
          child: Text(
            '02/12 KST 기준',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),

        SizedBox(
          height: 400,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (_positionedBubbles == null) {
                final packer = _CirclePacker(
                  width: constraints.maxWidth,
                  height: 400,
                  colorPalette: _colorPalette,
                  spacing: 1, // 간격 2px
                );
                _positionedBubbles = packer.pack(_items);
              }

              // 애니메이션 초기화 (한 번만)
              if (!_isInitialized) {
                _isInitialized = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _initAnimations(_positionedBubbles!.length);
                  setState(() {});
                });
              }

              return Stack(
                clipBehavior: Clip.none,
                children: List.generate(_positionedBubbles!.length, (index) {
                  final bubble = _positionedBubbles![index];
                  return Positioned(
                    left: bubble.x - bubble.radius,
                    top: bubble.y - bubble.radius,
                    child: _buildAnimatedBubble(bubble, index),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedBubble(_PositionedBubble bubble, int index) {
    final diameter = bubble.radius * 2;
    final fontSize = diameter * 0.2;

    Widget bubbleWidget = GestureDetector(
      onTap: () {
        debugPrint('Tapped: ${bubble.label}');
      },
      child: Container(
        width: diameter,
        height: diameter,
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

    if (_scaleAnimations == null || index >= _scaleAnimations!.length) {
      return Transform.scale(scale: 0, child: bubbleWidget);
    }

    return AnimatedBuilder(
      animation: _scaleAnimations![index],
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimations![index].value,
          child: child,
        );
      },
      child: bubbleWidget,
    );
  }
}

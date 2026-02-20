import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

/// 색상 pair (배경색 + 텍스트색)
class BubbleColorPair {
  final Color background;
  final Color text;

  const BubbleColorPair({required this.background, required this.text});
}

/// 내부용 - 위치가 계산된 버블
class _PositionedBubble {
  final String label;
  final double radius;
  final Color color;
  final Color textColor;
  double x;
  double y;

  _PositionedBubble({
    required this.label,
    required this.radius,
    required this.color,
    required this.textColor,
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
  final List<BubbleColorPair> colorPalette;
  final BubbleColorPair zeroColor; // value == 0
  final BubbleColorPair negativeColor; // value < 0
  final double spacing;

  _CirclePacker({
    required this.width,
    required this.height,
    this.minRadius = 25,
    this.maxRadius = 55,
    required this.colorPalette,
    required this.zeroColor,
    required this.negativeColor,
    this.spacing = 2,
  });

  List<_PositionedBubble> pack(List<HotIssueItem> items) {
    if (items.isEmpty) return [];

    // value 기준 내림차순 정렬
    final sortedItems = List<HotIssueItem>.from(items)
      ..sort((a, b) => b.value.compareTo(a.value));

    // 양수 값들만 필터링해서 정규화에 사용
    final positiveItems = sortedItems.where((item) => item.value > 0).toList();
    final maxValue = positiveItems.isNotEmpty ? positiveItems.first.value : 1;
    final minValue = positiveItems.isNotEmpty ? positiveItems.last.value : 1;
    final valueRange = maxValue - minValue;

    final bubbles = <_PositionedBubble>[];
    final centerX = width / 2;
    final centerY = height / 2;

    for (var i = 0; i < sortedItems.length; i++) {
      final item = sortedItems[i];

      double radius;
      Color bgColor;
      Color txtColor;

      if (item.value < 0) {
        // 음수: 최소 크기, 파란색
        radius = minRadius;
        bgColor = negativeColor.background;
        txtColor = negativeColor.text;
      } else if (item.value == 0) {
        // 0: 최소 크기, 회색
        radius = minRadius;
        bgColor = zeroColor.background;
        txtColor = zeroColor.text;
      } else {
        // 양수: 크기 변동, 팔레트에서 색상 선택
        double normalizedValue = valueRange > 0
            ? (item.value - minValue) / valueRange
            : 0.5;
        radius = minRadius + (maxRadius - minRadius) * normalizedValue;

        final colorIndex = (normalizedValue * (colorPalette.length - 1))
            .round();
        final colorPair = colorPalette[colorPalette.length - 1 - colorIndex];
        bgColor = colorPair.background;
        txtColor = colorPair.text;
      }

      final bubble = _PositionedBubble(
        label: item.label,
        radius: radius,
        color: bgColor,
        textColor: txtColor,
      );

      // 위치 찾기
      if (i == 0) {
        bubble.x = centerX;
        bubble.y = centerY;
      } else {
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
    double angle = 0;
    double distance = 0;
    const double angleStep = 0.3;
    const double distanceStep = 3;
    const int maxAttempts = 2000;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final x = centerX + distance * math.cos(angle);
      final y = centerY + distance * math.sin(angle);

      final margin = bubble.radius;
      if (x - margin < 0 ||
          x + margin > width ||
          y - margin < 0 ||
          y + margin > height) {
        angle += angleStep;
        distance += distanceStep * 0.1;
        continue;
      }

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
  final String country;
  final int timeGroup;

  const TodayHotIssueComponent({
    super.key,
    this.country = 'KR',
    this.timeGroup = 0,
  });

  @override
  State<TodayHotIssueComponent> createState() => _TodayHotIssueComponentState();
}

class _TodayHotIssueComponentState extends State<TodayHotIssueComponent>
    with TickerProviderStateMixin {
  // 색상 팔레트 (중요도: 낮음 → 높음) - 배경색 + 텍스트색 pair
  static const List<BubbleColorPair> _colorPalette = [
    BubbleColorPair(
      background: Color(0xFFE53935),
      text: Color(0xFFFFFFFF),
    ), // 높음
    BubbleColorPair(background: Color(0xFFEC407A), text: Color(0xFFFFFFFF)),
    BubbleColorPair(background: Color(0xFFF48FB1), text: Color(0xFFFFFFFF)),
    BubbleColorPair(
      background: Color(0xFFF8BBD9),
      text: Color(0xFFE53935),
    ), // 낮음
  ];

  // value == 0: 회색
  static const BubbleColorPair _zeroColor = BubbleColorPair(
    background: Color(0xFFBDBDBD),
    text: Color(0xFFFFFFFF),
  );

  // value < 0: 파란색
  static const BubbleColorPair _negativeColor = BubbleColorPair(
    background: Color(0xFF42A5F5),
    text: Color(0xFFFFFFFF),
  );

  // 모델에서 데이터 로드
  List<HotIssueItem> get _items => HotIssueData.getItems(
    country: widget.country,
    timeGroup: widget.timeGroup,
  );

  List<_PositionedBubble>? _positionedBubbles;
  List<AnimationController>? _animationControllers;
  List<Animation<double>>? _scaleAnimations;
  bool _isInitialized = false;

  @override
  void didUpdateWidget(TodayHotIssueComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // country 또는 timeGroup이 변경되면 버블 재생성
    if (oldWidget.country != widget.country ||
        oldWidget.timeGroup != widget.timeGroup) {
      _resetBubbles();
    }
  }

  void _resetBubbles() {
    _disposeAnimations();
    _positionedBubbles = null;
    _isInitialized = false;
    if (mounted) {
      setState(() {});
    }
  }

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
      _animationControllers = null;
      _scaleAnimations = null;
    }
  }

  void _initAnimations(int count) {
    if (!mounted) return; // dispose된 상태면 중단

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
        if (mounted && _animationControllers != null && i < _animationControllers!.length) {
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
                  zeroColor: _zeroColor,
                  negativeColor: _negativeColor,
                  spacing: 1,
                );
                _positionedBubbles = packer.pack(_items);
              }

              if (!_isInitialized) {
                _isInitialized = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return; // 위젯이 dispose되었으면 중단
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
    final fontSize = diameter * 0.23;

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
              color: bubble.textColor, // pair에서 가져온 텍스트 색상
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

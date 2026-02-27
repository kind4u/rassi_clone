import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

import 'package:rassi_clone/components/home/bubble_cloud_algorithm.dart';

/// 미국 증시 핫이슈 컴포넌트
///
/// 날짜 기준 텍스트와 버블 클라우드를 포함합니다.
/// 미국 증시 관례(녹색 = 상승, 적색 = 하락)를 반영한 색상 팔레트를 사용합니다.
class EnHotIssueComponent extends StatefulWidget {
  final List<HotIssueItem> items;

  const EnHotIssueComponent({super.key, required this.items});

  @override
  State<EnHotIssueComponent> createState() => _EnHotIssueComponentState();
}

class _EnHotIssueComponentState extends State<EnHotIssueComponent>
    with TickerProviderStateMixin {
  // EN 색상 팔레트: 낮음 → 높음 순서, 녹색 계열 (상승 = 녹색)
  static const List<BubbleColorPair> _colorPalette = [
    BubbleColorPair(
      background: Color(0xFFC8E6C9),
      text: Color(0xFF2E7D32),
    ), // 낮음
    BubbleColorPair(background: Color(0xFF81C784), text: Color(0xFFFFFFFF)),
    BubbleColorPair(background: Color(0xFF43A047), text: Color(0xFFFFFFFF)),
    BubbleColorPair(
      background: Color(0xFF2E7D32),
      text: Color(0xFFFFFFFF),
    ), // 높음
  ];

  static const BubbleColorPair _zeroColor = BubbleColorPair(
    background: Color(0xFFBDBDBD),
    text: Color(0xFFFFFFFF),
  );

  // 하락: 적색
  static const BubbleColorPair _negativeColor = BubbleColorPair(
    background: Color(0xFFEF5350),
    text: Color(0xFFFFFFFF),
  );

  List<PositionedBubble>? _positionedBubbles;
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
      _animationControllers = null;
      _scaleAnimations = null;
    }
  }

  void _initAnimations(int count) {
    if (!mounted) return;
    _disposeAnimations();

    _animationControllers = List.generate(
      count,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1900),
      ),
    );

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
        if (mounted &&
            _animationControllers != null &&
            i < _animationControllers!.length) {
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
            '02/12 EST 기준',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        SizedBox(
          height: 400,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (_positionedBubbles == null) {
                final packer = BubbleCloudPacker(
                  width: constraints.maxWidth,
                  height: 400,
                  colorPalette: _colorPalette,
                  zeroColor: _zeroColor,
                  negativeColor: _negativeColor,
                  spacing: 1,
                );
                _positionedBubbles = packer.pack(widget.items);
              }

              if (!_isInitialized) {
                _isInitialized = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
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

  Widget _buildAnimatedBubble(PositionedBubble bubble, int index) {
    final diameter = bubble.radius * 2;
    final fontSize = diameter * 0.23;

    final bubbleWidget = GestureDetector(
      onTap: () => debugPrint('EN Tapped: ${bubble.label}'),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: bubble.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: bubble.color.withValues(alpha: 0.3),
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
              color: bubble.textColor,
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

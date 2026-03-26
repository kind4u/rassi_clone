import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

import 'package:rassi_clone/components/home/bubble_cloud_algorithm.dart';

/// 한국 증시 핫이슈 컴포넌트
///
/// 날짜 기준 텍스트와 버블 클라우드를 포함합니다.
/// 한국 증시 관례(적색 = 상승, 청색 = 하락)를 반영한 색상 팔레트를 사용합니다.
/// 하단 타임라인 슬라이더로 시간대를 변경하면 [onTimeGroupChanged]를 통해 부모에 전달합니다.
class KrHotIssueComponent extends StatefulWidget {
  final List<HotIssueItem> items;
  final int timeGroup;
  final ValueChanged<int> onTimeGroupChanged;

  const KrHotIssueComponent({
    super.key,
    required this.items,
    required this.timeGroup,
    required this.onTimeGroupChanged,
  });

  @override
  State<KrHotIssueComponent> createState() => _KrHotIssueComponentState();
}

class _KrHotIssueComponentState extends State<KrHotIssueComponent>
    with TickerProviderStateMixin {
  static const Color _primaryColor = Color(0xFF6566FE);
  static const Color _secondaryColor = Color(0xFFDFD4FE);

  static const List<String> _timeLabels = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '15:30',
  ];

  // KR 색상 팔레트: 낮음 → 높음 순서, 적색 계열 (상승 = 적색)
  static const List<BubbleColorPair> _colorPalette = [
    BubbleColorPair(background: Color(0xFFF8BBD9), text: Color(0xFFE53935)),
    BubbleColorPair(background: Color(0xFFF48FB1), text: Color(0xFFFFFFFF)),
    BubbleColorPair(background: Color(0xFFEC407A), text: Color(0xFFFFFFFF)),
    BubbleColorPair(background: Color(0xFFE53935), text: Color(0xFFFFFFFF)),
  ];

  static const BubbleColorPair _zeroColor = BubbleColorPair(
    background: Color(0xFFBDBDBD),
    text: Color(0xFFFFFFFF),
  );

  static const BubbleColorPair _negativeColor = BubbleColorPair(
    background: Color(0xFF42A5F5),
    text: Color(0xFFFFFFFF),
  );

  // 슬라이더 value는 timeGroup / 7 에 대응
  late double _sliderValue;

  List<PositionedBubble>? _positionedBubbles;
  List<AnimationController>? _animationControllers;
  List<Animation<double>>? _scaleAnimations;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.timeGroup / 7;
  }

  @override
  void didUpdateWidget(KrHotIssueComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.timeGroup != widget.timeGroup) {
      _positionedBubbles = null;
      _isInitialized = false;
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

  String _getTimeLabel(double value) {
    final index = (value * 7).round().clamp(0, 7);
    return _timeLabels[index];
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

        // 타임라인 슬라이더
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            children: [
              const Icon(Icons.access_time, size: 20, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 10,
                    trackShape: _TimelineTrackShape(
                      activeColor: _secondaryColor,
                    ),
                    thumbShape: _TimelineThumbShape(
                      label: _getTimeLabel(_sliderValue),
                      color: Colors.white,
                      borderColor: _primaryColor,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 0,
                    ),
                    tickMarkShape: SliderTickMarkShape.noTickMark,
                    showValueIndicator: ShowValueIndicator.never,
                  ),
                  child: Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: 1.0,
                    divisions: 7,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                      widget.onTimeGroupChanged(
                        (value * 7).round().clamp(0, 7),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.0),

        Container(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "오늘의 이슈 모아보기",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Colors.black,
                  ),
                ],
              ),

              SizedBox(height: 8.0),

              Container(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  spacing: 8.0,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_double_arrow_up,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text("상승 이슈"),
                    Text("30개", style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(width: 12.0),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFF42A5F5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_double_arrow_down,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text("하락 이슈"),
                    Text("0개", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.0),
        Container(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "오늘의 이슈 타임라인",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text("날짜별 모든 이슈와\n특징주를 한눈에 확인하세요."),
                      ],
                    ),
                    const Icon(
                      Icons.calendar_today,
                      size: 48,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedBubble(PositionedBubble bubble, int index) {
    final diameter = bubble.radius * 2;
    final fontSize = diameter * 0.23;

    final bubbleWidget = GestureDetector(
      onTap: () => debugPrint('KR Tapped: ${bubble.label}'),
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

// thumb: 원형 + 위에 시간 텍스트 rounded rectangle
class _TimelineThumbShape extends SliderComponentShape {
  static const double _circleRadius = 10;
  static const double _labelWidth = 55;
  static const double _labelHeight = 24;
  static const double _labelCornerRadius = 12;
  static const double _gap = 4;
  static const double _fontSize = 12;

  final String label;
  final Color color;
  final Color borderColor;

  const _TimelineThumbShape({
    required this.label,
    required this.color,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(_circleRadius * 2, _circleRadius * 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // 원형 thumb (white fill + borderColor stroke)
    final Paint circleFillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final Paint circleBorderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, _circleRadius, circleFillPaint);
    canvas.drawCircle(center, _circleRadius, circleBorderPaint);

    // thumb 위 시간 라벨 (rounded rectangle: white fill + borderColor stroke)
    final Offset labelCenter = Offset(
      center.dx,
      center.dy - _circleRadius - _gap - _labelHeight / 2,
    );

    final RRect labelRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: labelCenter,
        width: _labelWidth,
        height: _labelHeight,
      ),
      Radius.circular(_labelCornerRadius),
    );

    final Paint labelBgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final Paint labelBorderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(labelRect, labelBgPaint);
    canvas.drawRRect(labelRect, labelBorderPaint);

    // 라벨 텍스트 (borderColor)
    final TextSpan span = TextSpan(
      text: label,
      style: TextStyle(
        fontSize: _fontSize,
        color: borderColor,
        fontWeight: FontWeight.w600,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: textDirection,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(labelCenter.dx - tp.width / 2, labelCenter.dy - tp.height / 2),
    );
  }
}

// track: active/inactive 분리 + 8개 섹션 tick dots
class _TimelineTrackShape extends RoundedRectSliderTrackShape {
  static const double _dotRadius = 2.5;
  static const List<double> _tickPositions = [
    0.001,
    1 / 7,
    2 / 7,
    3 / 7,
    4 / 7,
    5 / 7,
    6 / 7,
    0.999,
  ];

  final Color activeColor;

  _TimelineTrackShape({required this.activeColor});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = true,
    double additionalActiveTrackHeight = 2,
  }) {
    final Canvas canvas = context.canvas;
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final double trackHeight = sliderTheme.trackHeight ?? 4;
    final double radius = trackHeight / 2;

    final Paint activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.fill;
    final Paint inactivePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.center.dy - trackHeight / 2,
      thumbCenter.dx,
      trackRect.center.dy + trackHeight / 2,
    );
    final Rect inactiveRect = Rect.fromLTRB(
      thumbCenter.dx,
      trackRect.center.dy - trackHeight / 2,
      trackRect.right,
      trackRect.center.dy + trackHeight / 2,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, Radius.circular(radius)),
      activePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(inactiveRect, Radius.circular(radius)),
      inactivePaint,
    );

    // active 영역의 tick dots (흰색)
    final Paint whiteDotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (final double position in _tickPositions) {
      final double dotX = trackRect.left + trackRect.width * position;
      if (dotX <= thumbCenter.dx) {
        canvas.drawCircle(
          Offset(dotX, trackRect.center.dy),
          _dotRadius,
          whiteDotPaint,
        );
      }
    }
  }
}

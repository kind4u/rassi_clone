import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

import 'en_hot_issue_component.dart';
import 'kr_hot_issue_component.dart';

/// 오늘의 핫이슈 컴포넌트
///
/// [country]와 [timeGroup]을 받아 데이터를 조회한 뒤,
/// KR이면 [KrHotIssueComponent], 그 외에는 [EnHotIssueComponent]에 위임합니다.
/// KR인 경우 하단에 타임라인 슬라이더가 표시됩니다.
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

class _TodayHotIssueComponentState extends State<TodayHotIssueComponent> {
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

  double _sliderValue = 1.0;

  String _getTimeLabel(double value) {
    final index = (value * 7).round().clamp(0, 7);
    return _timeLabels[index];
  }

  @override
  Widget build(BuildContext context) {
    final items = HotIssueData.getItems(
      country: widget.country,
      timeGroup: widget.timeGroup,
    );

    final hotIssueWidget = widget.country == 'KR'
        ? KrHotIssueComponent(
            key: ValueKey('kr_${widget.timeGroup}'),
            items: items,
          )
        : EnHotIssueComponent(
            key: ValueKey('en_${widget.timeGroup}'),
            items: items,
          );

    if (widget.country != 'KR') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: hotIssueWidget,
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: hotIssueWidget,
        ),
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
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
  // 8개 timestamp에 대응하는 tick 위치 (0/7 ~ 7/7)
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

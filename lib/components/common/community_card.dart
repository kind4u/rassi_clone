import 'package:flutter/material.dart';

class CommunityCard extends StatefulWidget {
  const CommunityCard({super.key});

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  static const double _maxValue = 2 / 3;
  static const Color _primaryColor = Color(0xFF6566FE);
  static const Color _secondaryColor = Color(0xFFDFD4FE);

  double _sliderValue = _maxValue;

  String _getTimeLabel(double value) {
    if (value == 0.0) return '2시간전';
    if (value < 0.5) return '1시간전';
    return '0시간전';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),

        // 활동 급상승 타임라인 progress bar
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 10,
            trackShape: _CustomTrackShape(activeColor: _secondaryColor),
            thumbShape: _CustomThumbShape(
              label: _getTimeLabel(_sliderValue),
              color: _primaryColor,
            ),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            showValueIndicator: ShowValueIndicator.never,
          ),
          child: Slider(
            value: _sliderValue,
            min: 0.0,
            max: 1.0,
            divisions: 3,
            onChanged: (value) {
              if (value <= _maxValue) {
                setState(() {
                  _sliderValue = value;
                });
              }
            },
          ),
        ),
        SizedBox(height: 20),

        // 활동 급상승 컨텐츠들
        Text(
          _sliderValue == 0.0
              ? '2시간 전 활동 데이터'
              : _sliderValue <= 1 / 3
              ? '1시간 전 활동 데이터'
              : '현재 활동 데이터',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _primaryColor,
          ),
        ),
      ],
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbWidth = 65;
  static const double _thumbHeight = 32;
  static const double _thumbRadius = 16;
  static const double _fontSize = 14;

  final String label;
  final Color color;

  const _CustomThumbShape({required this.label, required this.color});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(_thumbWidth, _thumbHeight + 8);
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

    final Paint bgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final RRect bgRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: _thumbWidth, height: _thumbHeight),
      Radius.circular(_thumbRadius),
    );

    canvas.drawRRect(bgRect, bgPaint);

    final TextSpan span = TextSpan(
      text: label,
      style: TextStyle(fontSize: _fontSize, color: Colors.white),
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: textDirection,
    );

    tp.layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  static const double _dotRadius = 2.5;
  static const List<double> _tickPositions = [0.02, 1 / 3, 2 / 3];

  final Color activeColor;

  _CustomTrackShape({required this.activeColor});

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

    _drawTrack(canvas, trackRect, thumbCenter, trackHeight, radius);
    _drawTickMarks(canvas, trackRect, thumbCenter);
  }

  void _drawTrack(
    Canvas canvas,
    Rect trackRect,
    Offset thumbCenter,
    double trackHeight,
    double radius,
  ) {
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
  }

  void _drawTickMarks(Canvas canvas, Rect trackRect, Offset thumbCenter) {
    final Paint whiteDotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (double position in _tickPositions) {
      final double dotX = trackRect.left + trackRect.width * position;
      final bool isActive = dotX <= thumbCenter.dx;

      if (isActive) {
        canvas.drawCircle(
          Offset(dotX, trackRect.center.dy),
          _dotRadius,
          whiteDotPaint,
        );
      }
    }
  }
}

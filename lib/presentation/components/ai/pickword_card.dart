import 'package:flutter/material.dart';

class PickwordCard extends StatelessWidget {
  final VoidCallback? onTap;

  const PickwordCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          decoration: BoxDecoration(
            color: Color(0xFF454A63),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PickwordItem(
                  icon: Icons.file_copy,
                  startValue: 20000,
                  currentValue: 93177,
                  label: '문서 추출',
                  countUpDuration: Duration(milliseconds: 1500),
                ),
                PickwordItem(
                  icon: Icons.bar_chart,
                  startValue: 1350,
                  currentValue: 2184,
                  label: '분석 종목',
                  countUpDuration: Duration(milliseconds: 2000),
                ),
                PickwordItem(
                  icon: Icons.star,
                  startValue: 46000,
                  currentValue: 54104,
                  label: '키워드 픽',
                  textColor: Color(0xFF7773F5),
                  countUpDuration: Duration(milliseconds: 2500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PickwordItem extends StatefulWidget {
  final IconData icon;
  final int startValue;
  final int currentValue;
  final String label;
  final Color textColor;
  final Duration countUpDuration;

  const PickwordItem({
    super.key,
    required this.icon,
    required this.startValue,
    required this.currentValue,
    required this.label,
    required this.countUpDuration,
    this.textColor = Colors.white,
  });

  @override
  State<PickwordItem> createState() => _PickwordItemState();
}

class _PickwordItemState extends State<PickwordItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _displayValue = 0;

  @override
  void initState() {
    super.initState();
    _displayValue = widget.currentValue;

    // 6초마다 반복하는 컨트롤러
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();

    _controller.addListener(_updateValue);
  }

  void _updateValue() {
    final progress = _controller.value; // 0.0 ~ 1.0

    if (progress <= 0.5 / 5.0) {
      // 0 ~ 0.5초: count down (currentValue → startValue)
      final t = progress / (0.5 / 5.0); // 0.0 ~ 1.0
      _displayValue =
          (widget.currentValue - (widget.currentValue - widget.startValue) * t)
              .round();
    } else {
      // 0.5초 이후: count up (startValue → currentValue)
      final countUpProgress =
          (progress - 0.5 / 5.0) /
          (widget.countUpDuration.inMilliseconds / 6000.0);

      if (countUpProgress <= 1.0) {
        _displayValue =
            (widget.startValue +
                    (widget.currentValue - widget.startValue) * countUpProgress)
                .round();
      } else {
        _displayValue = widget.currentValue;
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(widget.icon, color: Colors.white, size: 32),

        SizedBox(height: 8),

        SizedBox(
          child: Text(
            _formatNumber(_displayValue),
            style: TextStyle(
              color: widget.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFeatures: [FontFeature.tabularFigures()],
              letterSpacing: -0.5, // 숫자 간격 줄이기 (음수면 좁아짐)
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 4),

        Text(
          widget.label,
          style: TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

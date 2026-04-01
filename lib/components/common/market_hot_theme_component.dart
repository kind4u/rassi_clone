import 'package:flutter/material.dart';

class MarketHotThemeComponent extends StatelessWidget {
  const MarketHotThemeComponent({super.key});

  static const Color _bgColor = Color(0xFFFFF0F0);
  static const Color _textColor = Color(0xFFE53935);

  static const List<String> _themes = ['#건설', '#우주항공', '#온디바이스AI'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            children: List.generate(_themes.length, (index) {
              final isLast = index == _themes.length - 1;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: isLast ? 0 : 8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _themes[index],
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 16,
                        fontWeight: index == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

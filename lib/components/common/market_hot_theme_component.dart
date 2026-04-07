import 'package:flutter/material.dart';

class MarketHotThemeComponent extends StatefulWidget {
  const MarketHotThemeComponent({super.key});

  @override
  State<MarketHotThemeComponent> createState() =>
      _MarketHotThemeComponentState();
}

class _MarketHotThemeComponentState extends State<MarketHotThemeComponent> {
  static const Color _bgColor = Color(0xFFFFF0F0);
  static const Color _textColor = Color(0xFFE53935);

  static const List<String> _themes = ['#건설', '#우주항공', '#온디바이스AI'];
  static const List<String> _tabs = ['테마 종목', '관련 뉴스'];

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 테마 태그 Row
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

          const SizedBox(height: 16),

          // 텍스트 탭
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTab == index;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index > 0)
                    Container(
                      width: 1,
                      height: 14,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.grey,
                    ),
                  GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        fontSize: isSelected ? 16 : 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),

          const SizedBox(height: 12),

          // 리스트 영역 (추후 구현)
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}

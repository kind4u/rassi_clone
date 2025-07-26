import 'package:flutter/material.dart';
import '../../models/tab_item.dart';

/// 커스텀 탭바 컴포넌트
/// iOS의 UISegmentedControl과 유사한 역할
class RassiTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final TabBottomShape bottomShape;

  const RassiTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.bottomShape = TabBottomShape.rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == selectedIndex;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                height: 46,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    // 탭 콘텐츠
                    Expanded(
                      child: Center(
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.deepPurple : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    // 하단 바 (선택된 탭에만 표시)
                    if (isSelected)
                      Container(
                        height: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: _getBottomBarBorderRadius(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  BorderRadius _getBottomBarBorderRadius() {
    switch (bottomShape) {
      case TabBottomShape.rounded:
        return BorderRadius.circular(1); // 둥근 사다리꼴 형태
      case TabBottomShape.rectangle:
        return BorderRadius.zero; // 직사각형 형태
    }
  }
}

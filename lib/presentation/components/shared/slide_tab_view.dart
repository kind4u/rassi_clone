import 'package:flutter/material.dart';
import 'package:rassi_clone/data/models/tab_item.dart';

class SlideTabStyle {
  final Color primaryColor;
  final double horizontalPadding;

  const SlideTabStyle({
    required this.primaryColor,
    this.horizontalPadding = 0,
  });
}

/// 탭 바만 단독으로 사용할 때 (홈 페이지 sticky header 등)
class SlideTabBar extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final SlideTabStyle style;
  final ValueChanged<int> onTabSelected;

  const SlideTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.style,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth =
            constraints.maxWidth - style.horizontalPadding * 2;
        final tabWidth = availableWidth / labels.length;

        return SizedBox(
          height: 48,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: style.horizontalPadding + selectedIndex * tabWidth,
                bottom: 0,
                width: tabWidth,
                height: 2,
                child: Container(color: style.primaryColor),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: style.horizontalPadding,
                ),
                child: Row(
                  children: labels.asMap().entries.map((entry) {
                    final isSelected = entry.key == selectedIndex;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTabSelected(entry.key),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              color: isSelected
                                  ? style.primaryColor
                                  : Colors.grey[500]!,
                            ),
                            child: Text(entry.value),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 탭 바 + 슬라이드 콘텐츠가 함께 묶인 버전 (드로어 등)
class SlideTabView extends StatefulWidget {
  final List<TabItem> tabs;
  final SlideTabStyle style;

  const SlideTabView({
    super.key,
    required this.tabs,
    required this.style,
  });

  @override
  State<SlideTabView> createState() => _SlideTabViewState();
}

class _SlideTabViewState extends State<SlideTabView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _previousIndex = 0;
  bool _goingForward = true;

  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: 1.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _goingForward = index > _currentIndex;
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTabBar(
          labels: widget.tabs.map((t) => t.label).toList(),
          selectedIndex: _currentIndex,
          style: widget.style,
          onTabSelected: _onTabSelected,
        ),
        const Divider(height: 1),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final t = _animation.value;
        final inOffset = _goingForward ? (1.0 - t) : -(1.0 - t);
        final outOffset = _goingForward ? -t : t;

        return Stack(
          children: [
            if (t < 1.0)
              Positioned.fill(
                child: FractionalTranslation(
                  translation: Offset(outOffset, 0),
                  child: widget.tabs[_previousIndex].content,
                ),
              ),
            Positioned.fill(
              child: FractionalTranslation(
                translation: Offset(inOffset, 0),
                child: widget.tabs[_currentIndex].content,
              ),
            ),
          ],
        );
      },
    );
  }
}

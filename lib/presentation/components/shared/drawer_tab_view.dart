import 'package:flutter/material.dart';
import 'package:rassi_clone/data/models/tab_item.dart';

class DrawerTabView extends StatefulWidget {
  final List<TabItem> tabs;

  const DrawerTabView({super.key, required this.tabs});

  @override
  State<DrawerTabView> createState() => _DrawerTabViewState();
}

class _DrawerTabViewState extends State<DrawerTabView>
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
        _TabBar(
          tabs: widget.tabs,
          selectedIndex: _currentIndex,
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

class _TabBar extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _TabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tabWidth = constraints.maxWidth / tabs.length;
        return SizedBox(
          height: 48,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: selectedIndex * tabWidth,
                bottom: 0,
                width: tabWidth,
                height: 2,
                child: Container(color: const Color(0xFF6665FD)),
              ),
              Row(
                children: tabs.asMap().entries.map((entry) {
                  final isSelected = entry.key == selectedIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTabSelected(entry.key),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? const Color(0xFF6665FD)
                                : Colors.grey[500]!,
                          ),
                          child: Text(entry.value.label),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

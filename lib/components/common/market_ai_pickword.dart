import 'package:flutter/material.dart';

class MarketAiPickword extends StatefulWidget {
  const MarketAiPickword({super.key});

  @override
  State<MarketAiPickword> createState() => _MarketAiPickwordState();
}

class _MarketAiPickwordState extends State<MarketAiPickword> {
  static const _majorKeyword = '배터리';

  int _selectedTab = 0;

  static const List<String> _tabs = ['NEW픽워드', 'HOT픽워드', 'TODAY종목'];

  Widget _buildTabButton({required String text, required int index}) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey[500],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(int selectedTab) {
    switch (selectedTab) {
      case 0: // NEW픽워드
        return SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PickwordRow(
                pickwordCategory: 'IT 서비스',
                pickwordContent: '삼성에스디에스',
              ),
              _PickwordRow(
                pickwordCategory: 'Agentic AI',
                pickwordContent: 'SK하이닉스',
              ),
              _PickwordRow(
                pickwordCategory: '고성능 메모리',
                pickwordContent: 'SK하이닉스',
              ),
            ],
          ),
        );
      case 1: // HOT픽워드
        return SizedBox(
          height: 100,
          child: _HotPickwordRow(
            items: const [
              _HotPickwordItem(category: '주주환원', content: '40종목'),
              _HotPickwordItem(category: '데이터센터', content: '37종목'),
              _HotPickwordItem(category: '미국', content: '34종목'),
            ],
          ),
        );
      case 2: // TODAY종목
        return SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TodayPickwordRow(
                pickwordName: 'LS ELECTRIC',
                pickwordNumber: '010120',
              ),
              _TodayPickwordRow(
                pickwordName: '삼성바이오로직스',
                pickwordNumber: '207940',
              ),
              _TodayPickwordRow(
                pickwordName: 'SK하이닉스',
                pickwordNumber: '000660',
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        spacing: 16.0,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Text.rich(
              textAlign: TextAlign.left,
              TextSpan(
                children: [
                  TextSpan(
                    text: _majorKeyword,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: '외 1개의 새로운 마켓 픽워드가 있어요.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // 3개의 탭 (NEW픽워드, HOT픽워드, TODAY종목)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: List.generate(
                _tabs.length,
                (index) => _buildTabButton(text: _tabs[index], index: index),
              ),
            ),
          ),

          // 탭별 동적 컴포넌트
          _buildContent(_selectedTab),

          // view more contents
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("${_tabs[_selectedTab]} 더보기")],
            ),
          ),
        ],
      ),
    );
  }
}

class _PickwordRow extends StatelessWidget {
  final String pickwordCategory;
  final String pickwordContent;

  const _PickwordRow({
    required this.pickwordCategory,
    required this.pickwordContent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.0,
      children: [
        const Icon(Icons.calendar_today, color: Color(0xFF6665FD), size: 14),
        const SizedBox(width: 2.0),
        Text(
          pickwordCategory,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text(':'),
        Text(pickwordContent),
      ],
    );
  }
}

class _HotPickwordItem {
  final String category;
  final String content;

  const _HotPickwordItem({required this.category, required this.content});
}

class _HotPickwordRow extends StatelessWidget {
  final List<_HotPickwordItem> items;

  const _HotPickwordRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        const horizontalPadding = 16.0;
        final availableWidth = constraints.maxWidth - horizontalPadding * 2;
        final itemWidth =
            (availableWidth - spacing * (items.length - 1)) / items.length;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index > 0) const SizedBox(width: spacing),
                  Container(
                    width: itemWidth,
                    height: itemWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.category,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.content,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _TodayPickwordRow extends StatelessWidget {
  final String pickwordName;
  final String pickwordNumber;

  const _TodayPickwordRow({
    required this.pickwordName,
    required this.pickwordNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.0,
      children: [
        const Icon(Icons.circle, color: Color(0xFF6665FD)),
        Text(pickwordName),
        Text(
          pickwordNumber,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

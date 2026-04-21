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
        return const SizedBox.shrink();
      case 1: // HOT픽워드
        return const SizedBox.shrink();
      case 2: // TODAY종목
        return const SizedBox.shrink();
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
              children: [Text("NEW픽워드 더보기")],
            ),
          ),
        ],
      ),
    );
  }
}

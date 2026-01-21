import 'package:flutter/material.dart';

class WhaleStockCatchComponent extends StatefulWidget {
  const WhaleStockCatchComponent({super.key});

  @override
  State<WhaleStockCatchComponent> createState() =>
      _WhaleStockCatchComponentState();
}

class _WhaleStockCatchComponentState extends State<WhaleStockCatchComponent> {
  int _selectedTab = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 탭 버튼 위젯
  Widget _buildTabButton({
    required String text,
    required int index,
    required bool isLeft,
  }) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(
              color: isSelected ? Colors.black : Colors.grey.shade400,
              width: isSelected ? 1 : 0.5,
            ),
            // 왼쪽 탭: 좌상단/좌하단(8), 우상단/우하단(0)
            // 오른쪽 탭: 좌상단/좌하단(0), 우상단/우하단(8)
            borderRadius: isLeft
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _foreignerStockCatch() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 6,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Text('캐치할종목')],
          ),
        ),

        SizedBox(height: 16.0),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 6,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Icon(Icons.help_outline_outlined, color: Colors.grey, size: 32),
              SizedBox(height: 12),
              Text(
                '프리미엄으로 업그레이드 하시고',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Text(
                '지금 모든 종목을 확인해 보세요.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),
            ],
          ),
        ),

        SizedBox(height: 24.0),

        // view more contents
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("함께 산 종목 더보기")],
          ),
        ),
      ],
    );
  }

  Widget _institutionStockCatch() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 6,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Text('캐치할종목')],
          ),
        ),

        SizedBox(height: 16.0),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 6,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Icon(Icons.help_outline_outlined, color: Colors.grey, size: 32),
              SizedBox(height: 12),
              Text(
                '프리미엄으로 업그레이드 하시고',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Text(
                '지금 모든 종목을 확인해 보세요.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),
            ],
          ),
        ),

        SizedBox(height: 24.0),

        // view more contents
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("함께 산 종목 더보기")],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          // 탭 버튼 Row
          Row(
            children: [
              _buildTabButton(text: '외국인 종목캐치', index: 0, isLeft: true),
              _buildTabButton(text: '기관 종목캐치', index: 1, isLeft: false),
            ],
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  _selectedTab == 0
                      ? TextSpan(
                          text: '외국인',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      : TextSpan(
                          text: '기관',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                  TextSpan(
                    text: '과 라씨 매매비서가 함께 ',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  TextSpan(
                    text: '매수',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.redAccent,
                    ),
                  ),

                  TextSpan(
                    text: '한 종목을 확인해 보세요',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 탭 contents
          _selectedTab == 0 ? _foreignerStockCatch() : _institutionStockCatch(),
        ],
      ),
    );
  }
}

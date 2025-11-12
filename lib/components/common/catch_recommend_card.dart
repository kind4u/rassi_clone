import 'package:flutter/material.dart';

class CatchRecommendCard extends StatefulWidget {
  const CatchRecommendCard({super.key});

  @override
  State<CatchRecommendCard> createState() => _CatchRecommendCardState();
}

class _CatchRecommendCardState extends State<CatchRecommendCard> {
  int _selectedTab = 0; // 0: button 1, 1: button 2
  int _currentPage = 0; // 현재 페이지 인덱스
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 버튼 위젯
  Widget _buildButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // Tab 1: 고정 데이터
  Widget _buildFixedTab() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '고정 데이터 탭',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('종목명: 삼성전자'),
          Text('현재가: 75,000원'),
          Text('등락률: +2.5%'),
        ],
      ),
    );
  }

  // 페이지 인디케이터
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? Color(0xFF6665FD)
                : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  // Tab 2: 페이지뷰 데이터 (3 페이지)
  Widget _buildPageViewTab() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '페이지 ${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('종목명: ${['카카오', 'NAVER', 'SK하이닉스'][index]}'),
                    Text('현재가: ${['50,000', '180,000', '130,000'][index]}원'),
                    Text('등락률: ${['+1.2%', '-0.8%', '+3.5%'][index]}'),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12),
        _buildPageIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          // 버튼 Row
          Row(
            children: [
              _buildButton('외국인/기관 종목캐치', 0),
              SizedBox(width: 8),
              _buildButton('성과 TOP 종목캐치', 1),
            ],
          ),
          // 선택된 탭에 따라 컨텐츠 표시
          if (_selectedTab == 0) _buildFixedTab(),
          if (_selectedTab == 1) _buildPageViewTab(),
        ],
      ),
    );
  }
}

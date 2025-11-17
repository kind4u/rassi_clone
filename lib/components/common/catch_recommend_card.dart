import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rassi_clone/components/common/catch_recommend_item.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CatchRecommendItem(
            icon: Icons.face,
            description: '외국인과 라씨 매매비서가 함께 매수한 종목',
            stock: '제주반도체',
            stockNumber: '080220',
          ),
          CatchRecommendItem(
            icon: Icons.account_balance,
            description: '기관과 라씨 매매비서가 함께 매수한 종목',
            stock: '삼성전자우',
            stockNumber: '005935',
          ),
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
            color: _currentPage == index ? Colors.black : Colors.grey.shade300,
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
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CatchRecommendItem(
                    icon: [
                      FontAwesomeIcons.crown,
                      FontAwesomeIcons.rankingStar,
                      FontAwesomeIcons.award,
                    ][index],
                    description: [
                      '적중률과 평균 수익률이 모두 높은 종목 중 매수한 종목',
                      '적중률과 누적 수익이 모두 높은 종목 중 매수한 종목',
                      '적중률과 수익난 매매횟수가 모두 높은 종목 중 매수한 종목',
                    ][index],
                    stock: ['삼성중공업', '삼성중공업', '이구산업'][index],
                    stockNumber: ['010140', '010140', '025820'][index],
                  ),
                  CatchRecommendItem(
                    icon: [
                      FontAwesomeIcons.trophy,
                      FontAwesomeIcons.trophy,
                      FontAwesomeIcons.trophy,
                    ][index],
                    description: [
                      '적중률과 평균 수익률이 모두 높은 종목 중 매도한 종목',
                      '적중률과 누적 수익이 모두 높은 종목 중 매도한 종목',
                      '적중률과 수익난 매매횟수가 모두 높은 종목 중 매도한 종목',
                    ][index],
                    stock: ['SOL 조선', 'SOL 조선', '에이블씨엔씨'][index],
                    stockNumber: ['466920', '466920', '078520'][index],
                  ),
                ],
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

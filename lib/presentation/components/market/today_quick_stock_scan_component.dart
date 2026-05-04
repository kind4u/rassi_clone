import 'package:flutter/material.dart';

class TodayQuickStockScanComponent extends StatefulWidget {
  const TodayQuickStockScanComponent({super.key});

  @override
  State<TodayQuickStockScanComponent> createState() =>
      _TodayQuickStockScanComponentState();
}

class _TodayQuickStockScanComponentState
    extends State<TodayQuickStockScanComponent> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _pages = [
    [
      '실시간 특징주 \'폴라리스오\' 외 21종목',
      '상한가 \'제이엘케이\'외 14종목',
      '52주 신고가 \'RF머트리\'외 68종목',
    ],
    [
      '거래비중 상위 \'조비\'외 28종목',
      '거래량 급등 상위 \'남선알미늄\'외 57종목',
      '시세급변종목 \'SKAI\'외 29종목',
    ],
  ];

  static const _pageViewHeight = 180.0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _backgroundComponent({required String contentText}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(contentText, style: const TextStyle(fontSize: 16)),
          const Icon(Icons.arrow_right_alt, size: 20),
        ],
      ),
    );
  }

  Widget _buildPage(List<String> items) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.0,
      children: items
          .map((text) => _backgroundComponent(contentText: text))
          .toList(),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isSelected = _currentPage == index;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black87 : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        spacing: 16.0,
        children: [
          SizedBox(
            height: _pageViewHeight,
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: _pages.map(_buildPage).toList(),
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }
}

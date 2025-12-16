import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/build_circle.dart';

class AiDescriptionDetailCard extends StatefulWidget {
  const AiDescriptionDetailCard({super.key});

  @override
  State<AiDescriptionDetailCard> createState() =>
      _AiDescriptionDetailCardState();
}

class _AiDescriptionDetailCardState extends State<AiDescriptionDetailCard> {
  static const Duration _autoScrollInterval = Duration(seconds: 4);
  static const Duration _pageTransitionDuration = Duration(milliseconds: 400);
  static const Curve _pageTransitionCurve = Curves.easeInOut;
  static const Color _secondaryTextColor = Color(0xFF424242);
  static const int _initialPageIndex = 1;

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = _initialPageIndex;

  final List<Map<String, String>> _stockData = [
    {'name': 'asd종목', 'status': '보유중', 'rate': '+50.6%', 'info': '(2일전 매수)'},
    {'name': '삼성전자', 'status': '보유중', 'rate': '+12.3%', 'info': '(5일전 매수)'},
    {'name': 'SK하이닉스', 'status': '보유중', 'rate': '-3.5%', 'info': '(1일전 매수)'},
    {'name': '카카오', 'status': '보유중', 'rate': '+25.8%', 'info': '(3일전 매수)'},
  ];

  int get _totalCarouselPages => _stockData.length + 2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPageIndex);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(_autoScrollInterval, (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: _pageTransitionDuration,
          curve: _pageTransitionCurve,
        );
      }
    });
  }

  void _handleInfiniteScroll(int index) {
    final isRightEdge = index == _stockData.length + 1;
    final isLeftEdge = index == 0;

    if (isRightEdge) {
      Future.delayed(_pageTransitionDuration, () {
        if (mounted && _pageController.hasClients) {
          _pageController.jumpToPage(1);
          _currentPage = 1;
        }
      });
    } else if (isLeftEdge) {
      Future.delayed(_pageTransitionDuration, () {
        if (mounted && _pageController.hasClients) {
          _pageController.jumpToPage(_stockData.length);
          _currentPage = _stockData.length;
        }
      });
    }
  }

  Map<String, String> _getStockDataByIndex(int index) {
    if (index == 0) {
      return _stockData.last;
    } else if (index == _stockData.length + 1) {
      return _stockData.first;
    } else {
      return _stockData[index - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    // 예시 매수/매도 수치
    const int buyCount = 24;
    const int sellCount = 17;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 매수 circle
                  BuildCircle(
                    label: '매수',
                    count: buyCount,
                    size: 80,
                    color: Colors.red,
                  ),

                  SizedBox(width: 48),
                  // 매도 circle
                  BuildCircle(
                    label: '매도',
                    count: sellCount,
                    size: 80,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            _buildStockCarousel(),
          ],
        ),
      ),
    );
  }

  Widget _buildStockCarousel() {
    return Container(
      height: 40,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _secondaryTextColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _totalCarouselPages,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          _handleInfiniteScroll(index);
        },
        itemBuilder: (context, index) {
          final stock = _getStockDataByIndex(index);
          return _buildStockItem(stock);
        },
      ),
    );
  }

  Widget _buildStockItem(Map<String, String> stock) {
    final isPositive = stock['rate']!.startsWith('+');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          stock['name']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8),
        Text(
          stock['status']!,
          style: TextStyle(fontSize: 14, color: _secondaryTextColor),
        ),
        SizedBox(width: 4),
        Text(
          stock['rate']!,
          style: TextStyle(
            fontSize: 14,
            color: isPositive ? Colors.red : Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 4),
        Text(
          stock['info']!,
          style: TextStyle(fontSize: 14, color: _secondaryTextColor),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SignalCombineCard extends StatefulWidget {
  const SignalCombineCard({super.key});

  @override
  State<SignalCombineCard> createState() => _SignalCombineCardState();
}

class _SignalCombineCardState extends State<SignalCombineCard> {
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

  Widget _buildSignalRateContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _signalCapsuleIcon(leftValue: "55", rightValue: "45"),
              SizedBox(height: 8.0),
              Text(
                "코스피",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),

          SizedBox(width: 40),

          Column(
            children: [
              _signalCapsuleIcon(leftValue: "46", rightValue: "54"),
              SizedBox(height: 8.0),
              Text(
                "코스닥",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signalCapsuleIcon({
    required String leftValue,
    required String rightValue,
  }) {
    return Row(
      children: [
        // 왼쪽 캡슐 (옅은 보라색)
        Container(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 12.0,
            left: 12.0,
            right: 16.0,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF6665FD), // 옅은 보라색
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(999),
              bottomLeft: Radius.circular(999),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Center(
            child: Text(
              leftValue,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white, // 짙은 보라색 텍스트
              ),
            ),
          ),
        ),
        // 오른쪽 캡슐 (짙은 보라색)
        Container(
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 12.0,
            left: 16.0,
            right: 12.0,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFE8E3FF), // 짙은 보라색
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(999),
              bottomRight: Radius.circular(999),
            ),
          ),
          child: Center(
            child: Text(
              rightValue,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6665FD),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignalStockContents() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
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
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "52",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "매수",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "39",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "매도",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "2129",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "보유",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "2009",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "관망",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
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
              _buildTabButton(text: '시장별 신호 비율', index: 0, isLeft: true),
              _buildTabButton(text: '신호별 종목 모아보기', index: 1, isLeft: false),
            ],
          ),
          const SizedBox(height: 16),
          // 탭 contents
          _selectedTab == 0
              ? _buildSignalRateContent()
              : _buildSignalStockContents(),
        ],
      ),
    );
  }
}

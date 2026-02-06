import 'package:flutter/material.dart';

class AchiveStockCatchComponent extends StatefulWidget {
  const AchiveStockCatchComponent({super.key});

  @override
  State<AchiveStockCatchComponent> createState() =>
      _AchiveStockCatchComponentState();
}

class _AchiveStockCatchComponentState extends State<AchiveStockCatchComponent> {
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
    required bool isRight,
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
          padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                : isRight
                ? const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )
                : const BorderRadius.all(Radius.zero),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "원익큐브 ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "014190",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),

                SizedBox(height: 12.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Color(0xFF6665FD),
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              "라씨 매수",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                // 주식 가격 data
                                text: '2,045',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '원',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        Text('01/22 15:00'),
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              "외국인매수",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                // 발행 주 개수 data
                                text: '301,949',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '주',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        Text('4일 연속 순매수'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
            children: [Text("성과 TOP 종목 더보기")],
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "대우건설 ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "047040",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),

                SizedBox(height: 12.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Color(0xFF6665FD),
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              "라씨 매수",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                // 주식 가격 data
                                text: '4,930',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '원',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        Text('01/22 15:00'),
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              "기관매수",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                // 발행 주 개수 data
                                text: '7,452,039',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '주',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        Text('6일 연속 순매수'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
              _buildTabButton(
                text: '적중률+\n평균수익률',
                index: 0,
                isLeft: true,
                isRight: false,
              ),
              _buildTabButton(
                text: '적중률+\n누적수익률',
                index: 1,
                isLeft: false,
                isRight: false,
              ),
              _buildTabButton(
                text: '적중률+\n수익난 매매',
                index: 2,
                isLeft: false,
                isRight: true,
              ),
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

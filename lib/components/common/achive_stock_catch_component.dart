import 'package:flutter/material.dart';

class AchiveStockCatchComponent extends StatefulWidget {
  const AchiveStockCatchComponent({super.key});

  @override
  State<AchiveStockCatchComponent> createState() =>
      _AchiveStockCatchComponentState();
}

class _AchiveStockCatchComponentState extends State<AchiveStockCatchComponent> {
  int _selectedTab = 0;
  int _averageTabIndex = 0; // 평균수익률 섹션 내부 탭
  int _cumulativeTabIndex = 0; // 누적수익률 섹션 내부 탭
  int _profitableTabIndex = 0; // 수익난 매매 섹션 내부 탭
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

  // 내부 탭 버튼 위젯 (공용)
  Widget _buildInnerTabButton({
    required String text,
    required int index,
    required int selectedIndex,
    required ValueChanged<int> onTap,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          onTap(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  // 데이터 카드 컴포넌트
  Widget _dataCardComponent({
    required String stockName,
    required String stockCode,
    required String rate,
    required String resultData,
    required String category,
    String resultUnit = '%',
  }) {
    return Container(
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
                  "$stockName ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  stockCode,
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
                          "적중률",
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
                            text: rate,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: '%', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),

                    Text('최근 3년'),
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
                          category,
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
                            text: resultData,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: resultUnit,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    Text('최근 3년'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _averageStockSession() {
    return Column(
      children: [
        // 내부 탭 Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInnerTabButton(
              text: '현재 관망 상태 종목',
              index: 0,
              selectedIndex: _averageTabIndex,
              onTap: (i) => _averageTabIndex = i,
            ),

            Container(height: 18, width: 0.5, color: Colors.black),

            _buildInnerTabButton(
              text: '최근 3일 내 매수 종목',
              index: 1,
              selectedIndex: _averageTabIndex,
              onTap: (i) => _averageTabIndex = i,
            ),
          ],
        ),

        SizedBox(height: 12.0),

        // 탭 선택에 따른 데이터 카드
        switch (_averageTabIndex) {
          0 => _dataCardComponent(
            stockName: '세토피아',
            stockCode: '222810',
            rate: '100',
            resultData: '+14.76',
            category: '평균수익률',
          ),
          _ => _dataCardComponent(
            stockName: 'HANARO 글로벌금채굴기업',
            stockCode: '473640',
            rate: '100',
            resultData: '+10.2',
            category: '평균수익률',
          ),
        },

        SizedBox(height: 16.0),

        _premeumPurchaseSection(),

        SizedBox(height: 24.0),

        _viewMoreSection(),
      ],
    );
  }

  Widget _cumulativeStockSession() {
    return Column(
      children: [
        // 내부 탭 Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInnerTabButton(
              text: '현재 관망 상태 종목',
              index: 0,
              selectedIndex: _cumulativeTabIndex,
              onTap: (i) => _cumulativeTabIndex = i,
            ),

            Container(height: 18, width: 0.5, color: Colors.black),

            _buildInnerTabButton(
              text: '최근 3일 내 매수 종목',
              index: 1,
              selectedIndex: _cumulativeTabIndex,
              onTap: (i) => _cumulativeTabIndex = i,
            ),
          ],
        ),

        SizedBox(height: 12.0),

        // 탭 선택에 따른 데이터 카드
        switch (_cumulativeTabIndex) {
          0 => _dataCardComponent(
            stockName: '세토피아',
            stockCode: '222810',
            rate: '100',
            resultData: '+132.81',
            category: '누적수익률',
          ),
          _ => _dataCardComponent(
            stockName: 'HANARO 글로벌금채굴기업',
            stockCode: '473640',
            rate: '100',
            resultData: '+132.59',
            category: '누적수익률',
          ),
        },

        SizedBox(height: 16.0),

        _premeumPurchaseSection(),

        SizedBox(height: 24.0),

        _viewMoreSection(),
      ],
    );
  }

  Widget _profitableStockSession() {
    return Column(
      children: [
        // 내부 탭 Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInnerTabButton(
              text: '현재 관망 상태 종목',
              index: 0,
              selectedIndex: _profitableTabIndex,
              onTap: (i) => _profitableTabIndex = i,
            ),

            Container(height: 18, width: 0.5, color: Colors.black),

            _buildInnerTabButton(
              text: '최근 3일 내 매수 종목',
              index: 1,
              selectedIndex: _profitableTabIndex,
              onTap: (i) => _profitableTabIndex = i,
            ),
          ],
        ),

        SizedBox(height: 12.0),

        // 탭 선택에 따른 데이터 카드
        switch (_profitableTabIndex) {
          0 => _dataCardComponent(
            stockName: '에이블씨엔씨',
            stockCode: '078520',
            rate: '88.9',
            resultData: '11',
            resultUnit: '번',
            category: '수익난 매매',
          ),
          _ => _dataCardComponent(
            stockName: '코오롱',
            stockCode: '002020',
            rate: '92.3',
            resultData: '10',
            resultUnit: '번',
            category: '수익난 매매',
          ),
        },

        SizedBox(height: 16.0),

        _premeumPurchaseSection(),

        SizedBox(height: 24.0),

        _viewMoreSection(),
      ],
    );
  }

  Widget _premeumPurchaseSection() {
    return Container(
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
    );
  }

  Widget _viewMoreSection() {
    return Container(
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
          // 탭 contents
          switch (_selectedTab) {
            1 => _cumulativeStockSession(),

            2 => _profitableStockSession(),

            _ => _averageStockSession(),
          },
        ],
      ),
    );
  }
}

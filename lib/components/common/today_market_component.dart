import 'package:flutter/material.dart';

class TodayMarketComponent extends StatefulWidget {
  const TodayMarketComponent({super.key});

  @override
  State<TodayMarketComponent> createState() => _TodayMarketComponentState();
}

class _TodayMarketComponentState extends State<TodayMarketComponent> {
  int _selectedMainTab = 0;

  // 메인탭별 독립적인 서브탭 상태
  final List<int> _selectedSubTabs = [0, 0];

  static const List<String> _subTabLabels = ['코스피', '코스닥'];

  // 상승종목 - 코스피
  static const List<_StockData> _upAll = [
    _StockData(stockName: '주성코퍼레이션', stockCode: '109070', rate: '+29.97'),
    _StockData(stockName: '티엠씨', stockCode: '217590', rate: '+29.96'),
    _StockData(stockName: '한솔테크닉스', stockCode: '004710', rate: '+29.94'),
    _StockData(stockName: '남선알미늄', stockCode: '008350', rate: '+29.93'),
    _StockData(stockName: '광전자', stockCode: '017900', rate: '+29.91'),
  ];

  // 상승종목 - 코스닥
  static const List<_StockData> _upSurge = [
    _StockData(stockName: '우리넷', stockCode: '115440', rate: '+30.00'),
    _StockData(stockName: '아이씨에이치', stockCode: '368600', rate: '+30.00'),
    _StockData(stockName: '서울전자통신', stockCode: '027040', rate: '+29.98'),
    _StockData(stockName: '알엔투테크놀로지', stockCode: '148250', rate: '+29.97'),
    _StockData(stockName: '웨이브일렉트로', stockCode: '095270', rate: '+29.96'),
  ];

  // 하위종목 - 코스피
  static const List<_StockData> _downAll = [
    _StockData(stockName: '태영건설우', stockCode: '009415', rate: '-13.78'),
    _StockData(stockName: '삼익THK', stockCode: '004380', rate: '-9.21'),
    _StockData(stockName: '에이프로젠', stockCode: '007460', rate: '-7.57'),
    _StockData(stockName: '대한해운', stockCode: '005880', rate: '-7.44'),
    _StockData(stockName: '미원화학', stockCode: '134380', rate: '-7.25'),
  ];

  // 하위종목 - 코스닥
  static const List<_StockData> _downSurge = [
    _StockData(stockName: '썸에이지', stockCode: '208640', rate: '-18.30'),
    _StockData(stockName: 'ISC', stockCode: '095340', rate: '-15.92'),
    _StockData(stockName: '코이즈', stockCode: '121850', rate: '-15.03'),
    _StockData(stockName: '모아라이프플러스', stockCode: '142760', rate: '-9.72'),
    _StockData(stockName: '한울반도체', stockCode: '320000', rate: '-9.18'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 메인탭: 상승종목 / 하위종목
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildMainTabButton(text: '상승종목', index: 0),
              _buildMainTabButton(text: '하위종목', index: 1),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 서브탭
        _buildSubTabRow(_selectedMainTab),

        const SizedBox(height: 12),

        // 콘텐츠 영역
        _buildContent(_selectedMainTab, _selectedSubTabs[_selectedMainTab]),

        const SizedBox(height: 12),

        if (_selectedMainTab == 0)
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
              children: [Text("코스닥 상승종목 더보기")],
            ),
          )
        else
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
              children: [Text("코스닥 하락종목 더보기")],
            ),
          ),
      ],
    );
  }

  Widget _buildMainTabButton({required String text, required int index}) {
    final isSelected = _selectedMainTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMainTab = index),
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

  Widget _buildSubTabRow(int mainTabIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_subTabLabels.length, (index) {
        final isSelected = _selectedSubTabs[mainTabIndex] == index;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index > 0)
              Container(
                width: 1,
                height: 14,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: Colors.grey,
              ),
            GestureDetector(
              onTap: () =>
                  setState(() => _selectedSubTabs[mainTabIndex] = index),
              child: Text(
                _subTabLabels[index],
                style: TextStyle(
                  fontSize: isSelected ? 16 : 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildContent(int mainTab, int subTab) {
    final List<_StockData> stocks = switch ((mainTab, subTab)) {
      (0, 0) => _upAll,
      (0, 1) => _upSurge,
      (1, 0) => _downAll,
      (1, _) => _downSurge,
      _ => [],
    };

    return Column(
      children: stocks
          .map(
            (data) => _StockListItem(
              stockName: data.stockName,
              stockCode: data.stockCode,
              rate: data.rate,
            ),
          )
          .toList(),
    );
  }
}

class _StockData {
  final String stockName;
  final String stockCode;
  final String rate;

  const _StockData({
    required this.stockName,
    required this.stockCode,
    required this.rate,
  });
}

class _StockListItem extends StatelessWidget {
  final String stockName;
  final String stockCode;
  final String rate;

  const _StockListItem({
    required this.stockName,
    required this.stockCode,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4.0,
            children: [
              Text(
                stockName,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                stockCode,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          Text(
            '$rate%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: rate.startsWith('-')
                  ? const Color(0xFF42A5F5)
                  : Colors.redAccent,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

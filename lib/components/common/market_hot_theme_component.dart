import 'package:flutter/material.dart';

class MarketHotThemeComponent extends StatefulWidget {
  const MarketHotThemeComponent({super.key});

  @override
  State<MarketHotThemeComponent> createState() =>
      _MarketHotThemeComponentState();
}

class _MarketHotThemeComponentState extends State<MarketHotThemeComponent> {
  static const Color _bgColor = Color(0xFFFFF0F0);
  static const Color _textColor = Color(0xFFE53935);

  static const List<String> _themes = ['#건설', '#우주항공', '#온디바이스AI'];
  static const List<String> _tabs = ['테마 종목', '관련 뉴스'];

  int _selectedTab = 0;

  // 탭 0: 테마 종목
  static const List<_StockData> _hotStocks = [
    _StockData(stockName: '대한해운', stockCode: '005880', rate: '29.83'),
    _StockData(stockName: 'STX그린로지스', stockCode: '465770', rate: '6.71'),
    _StockData(stockName: '흥아해운', stockCode: '003280', rate: '4.95'),
  ];

  // 탭 1: 관련 뉴스 (뉴스도 동일 widget 구조 재사용, 추후 변경 예정)
  static const List<_StockData> _leadStocks = [
    _StockData(stockName: '대한해운', stockCode: '005880', rate: '29.83'),
    _StockData(stockName: 'KSS해운', stockCode: '044450', rate: '10.39'),
    _StockData(stockName: 'HMM', stockCode: '011200', rate: '3.84'),
  ];

  @override
  Widget build(BuildContext context) {
    final stocks = _selectedTab == 0 ? _hotStocks : _leadStocks;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 테마 태그 Row
          Row(
            children: List.generate(_themes.length, (index) {
              final isLast = index == _themes.length - 1;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: isLast ? 0 : 8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _themes[index],
                      style: TextStyle(
                        color: _textColor,
                        fontSize: 16,
                        fontWeight: index == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          // 텍스트 탭
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTab == index;
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
                    onTap: () => setState(() => _selectedTab = index),
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        fontSize: isSelected ? 16 : 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),

          const SizedBox(height: 12),

          // 리스트 영역
          Column(
            children: stocks
                .map(
                  (data) => _StockListItem(
                    stockName: data.stockName,
                    stockCode: data.stockCode,
                    rate: data.rate,
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 24.0),
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
              children: [Text("핫테마 더보기")],
            ),
          ),
        ],
      ),
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
            '+$rate%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

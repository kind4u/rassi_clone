import 'package:flutter/material.dart';
import 'package:rassi_clone/domain/entities/market_stock_item.dart';
import 'package:rassi_clone/domain/repositories/market_repository_protocol.dart';

class TodayMarketComponent extends StatefulWidget {
  final MarketRepositoryProtocol repository;

  const TodayMarketComponent({super.key, required this.repository});

  @override
  State<TodayMarketComponent> createState() => _TodayMarketComponentState();
}

class _TodayMarketComponentState extends State<TodayMarketComponent> {
  int _selectedMainTab = 0;

  // 메인탭별 독립적인 서브탭 상태
  final List<int> _selectedSubTabs = [0, 0];

  static const List<String> _subTabLabels = ['코스피', '코스닥'];

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
    final List<MarketStockItem> stocks = widget.repository.getStocks(
      mainTab: mainTab,
      subTab: subTab,
    );

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

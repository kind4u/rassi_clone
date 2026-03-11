import 'package:flutter/material.dart';

class NetSalesStockComponent extends StatefulWidget {
  const NetSalesStockComponent({super.key});

  @override
  State<NetSalesStockComponent> createState() => _NetSalesStockComponentState();
}

class _NetSalesStockComponentState extends State<NetSalesStockComponent> {
  int _selectedTab = 0;

  static const _tabHighlights = ['순매수', '순매도'];

  String get _highlightText => _tabHighlights[_selectedTab];

  Widget _buildTabButton({required String text, required int index}) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
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
          _buildText(contentText, _highlightText),
          const Icon(Icons.arrow_right_alt, size: 20),
        ],
      ),
    );
  }

  Widget _buildText(String contentText, String highlightText) {
    const baseStyle = TextStyle(fontSize: 16);

    if (highlightText.isEmpty || !contentText.contains(highlightText)) {
      return Text(contentText, style: baseStyle);
    }

    final highlightColor = highlightText == '순매수'
        ? Colors.redAccent
        : Colors.blueAccent;
    final parts = contentText.split(highlightText);
    final spans = <TextSpan>[];

    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i]));
      }
      if (i < parts.length - 1) {
        spans.add(
          TextSpan(
            text: highlightText,
            style: TextStyle(color: highlightColor),
          ),
        );
      }
    }

    return Text.rich(TextSpan(style: baseStyle, children: spans));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        spacing: 16.0,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildTabButton(text: '순매수', index: 0),
                _buildTabButton(text: '순매도', index: 1),
              ],
            ),
          ),
          _backgroundComponent(
            contentText: _selectedTab == 0 ? '연속 순매수 종목' : '연속 순매도 종목',
          ),
          _backgroundComponent(
            contentText: _selectedTab == 0 ? '순매수 상위 종목' : '순매도 상위 종목',
          ),
          _backgroundComponent(
            contentText: _selectedTab == 0 ? '순매수 비중 상위 종목' : '순매도 비중 상위 종목',
          ),
        ],
      ),
    );
  }
}

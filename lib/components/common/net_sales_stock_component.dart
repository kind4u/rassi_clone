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

  Widget _buildTabButton({
    required String text,
    required int index,
    required bool isLeft,
  }) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(
              color: isSelected ? Colors.black : Colors.grey.shade400,
              width: isSelected ? 1 : 0.5,
            ),
            borderRadius: isLeft
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )
                : const BorderRadius.only(
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
          Row(
            children: [
              _buildTabButton(text: '순매수', index: 0, isLeft: true),
              _buildTabButton(text: '순매도', index: 1, isLeft: false),
            ],
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

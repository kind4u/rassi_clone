import 'package:flutter/material.dart';

class MarketAiNewsComponent extends StatelessWidget {
  const MarketAiNewsComponent({super.key});

  Widget _backgroundComponent({required String contentText}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(contentText, style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_right_alt, size: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        spacing: 16.0,
        children: [
          _backgroundComponent(contentText: '헤드라인 속보만 빠르게 보기'),
          _backgroundComponent(contentText: '실시간 AI속보 모두 보기'),
          _backgroundComponent(contentText: 'AI속보 태그 전체 보기'),
        ],
      ),
    );
  }
}

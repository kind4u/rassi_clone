import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/ai_filter_list.dart';
import 'package:rassi_clone/components/common/title_bar.dart';

class AiFilterItems extends StatelessWidget {
  const AiFilterItems({super.key});

  // 샘플 데이터
  static const List<Map<String, String>> _sampleData = [
    {'stockName': '강남제비스코', 'stockCode': '000860', 'returnRate': '+13.78%'},
    {'stockName': 'LG이노텍', 'stockCode': '011070', 'returnRate': '+4.43%'},
    {'stockName': '주성엔지니어링', 'stockCode': '036930', 'returnRate': '+12.74%'},
    {'stockName': 'TIGER 20', 'stockCode': '243880', 'returnRate': '+6.3%'},
    {'stockName': '네오셈', 'stockCode': '253590', 'returnRate': '+5.12%'},
    {'stockName': '예스티', 'stockCode': '122640', 'returnRate': '+3.93%'},
    {'stockName': '노바텍', 'stockCode': '285490', 'returnRate': '+3.76%'},
    {'stockName': '파라택시스코리아', 'stockCode': '288330', 'returnRate': '+4.46%'},
    {'stockName': '자람테크놀로지', 'stockCode': '389020', 'returnRate': '+3.85%'},
    {'stockName': '삼현', 'stockCode': '437730', 'returnRate': '+11.91%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        SizedBox(height: 12),

        TitleBar(title: '최근 3일 매수 후 급등 종목', detailText: '더보기', titleSize: 16),
        // 매수 후 급등 종목 Contents
        AIFilterList(items: _sampleData),

        TitleBar(title: '적중률 TOP 중 관망 종목', detailText: '더보기', titleSize: 16),
        _PremiumPurchaseContents(),

        TitleBar(
          title: '적중률 TOP 중 최근 3일 매수 종목',
          detailText: '더보기',
          titleSize: 16,
        ),
        _PremiumPurchaseContents(),

        TitleBar(
          title: '평균수익률 TOP 중 최근 3일 매수 종목',
          detailText: '더보기',
          titleSize: 16,
        ),
        _PremiumPurchaseContents(),

        TitleBar(title: '평균수익률 TOP 중 관망 종목', detailText: '더보기', titleSize: 16),
        _PremiumPurchaseContents(),
      ],
    );
  }
}

class _PremiumPurchaseContents extends StatelessWidget {
  const _PremiumPurchaseContents();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
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
    );
  }
}

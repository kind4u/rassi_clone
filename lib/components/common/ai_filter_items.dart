import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/title_bar.dart';

class AiFilterItems extends StatelessWidget {
  const AiFilterItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 12,
      children: [
        SizedBox(height: 12),

        TitleBar(title: '최근 3일 매수 후 급등 종목', detailText: '더보기', titleSize: 16),

        // TODO: 매수 후 급등 종목 Contents
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

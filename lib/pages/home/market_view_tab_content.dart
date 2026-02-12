import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/title_bar.dart';
import 'package:rassi_clone/components/common/today_hot_issue_component.dart';

class MarketViewTabContent extends StatelessWidget {
  const MarketViewTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 16.0),
        child: Column(
          children: [
            _todayHotIssue(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _todayMarket(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _todayStockQuickScan(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _netSalesStock(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _marketAIPickword(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _marketHotTheme(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _marketAINews(),

            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _analysisReport(),
          ],
        ),
      ),
    );
  }

  // 오늘의 핫이슈 section
  Widget _todayHotIssue() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "오늘의 핫이슈",
            detailIcon: Icons.notifications_none_outlined,
            detailIconColor: Colors.black.withAlpha(80),
            detailIconSize: 22,
            onDetailTap: () {},
          ),

          TodayHotIssueComponent(),
        ],
      ),
    );
  }

  // 오늘 시장은 section
  Widget _todayMarket() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [TitleBar(title: "오늘 시장은", onDetailTap: () {})],
      ),
    );
  }

  // 오늘의 특징주 빠르게 보기 section
  Widget _todayStockQuickScan() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [TitleBar(title: "오늘의 특징주 빠르게 보기", onDetailTap: () {})],
      ),
    );
  }

  // 외국인/기관 순매매 section
  Widget _netSalesStock() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [TitleBar(title: "외국인/기관 순매매", onDetailTap: () {})],
      ),
    );
  }

  // AI 픽워드 section
  Widget _marketAIPickword() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "AI픽워드",
            detailText: "AI가 주가상승에 영향을 주는 키워드를 픽!",
            onDetailTap: () {},
          ),
        ],
      ),
    );
  }

  // 이 시간 핫테마 section
  Widget _marketHotTheme() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "이 시간 핫테마",
            detailText: "테마 트렌드와 주도주를 확인!",
            onDetailTap: () {},
          ),
        ],
      ),
    );
  }

  // AI속보 section
  Widget _marketAINews() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "AI속보",
            detailText: "AI가 빠르게 수집하여 분석하는 AI속보!",
            onDetailTap: () {},
          ),
        ],
      ),
    );
  }

  // 분석 리포트 section
  Widget _analysisReport() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [TitleBar(title: "분석 리포트", onDetailTap: () {})],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../common/title_bar.dart';
import '../common/desk_component.dart';
import '../common/page_tab_view.dart';
import '../common/ai_signal_status_card.dart';
import '../common/ai_keyword_stats_card.dart';

/// 홈 탭의 콘텐츠를 담당하는 위젯
class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  int _currentPage = 0;
  
  // 페이지별 detailText
  final List<String> _pageDetailTexts = [
    "대형주 보기",
    "중형주 보기", 
    "소형주 보기",
    "신규상장 보기"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // 오늘의 추천 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TitleBar(
                title: "오늘의 추천",
                detailText: "더보기",
                onDetailTap: () => print('더보기 클릭됨'),
              ),
            ),
            // padding - 16
            const SizedBox(height: 16),
            // 오늘의 추천 Component
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DeskComponent(
                onTap: () => print('DeskComponent 클릭됨'),
              ),
            ),
            // padding - 24
            const SizedBox(height: 24),

            // 인기 종목 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TitleBar(
                title: "인기 종목",
                detailText: _pageDetailTexts[_currentPage], // 선택된 페이지에 따라 변경
                detailColor: Colors.deepPurple,
              ),
            ),
            // padding - 16
            const SizedBox(height: 16),
            // 인기 종목 Components
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PageTabView(
                onPageChanged: (index) {
                  // current page state에 따라 인기종목 title text 변경
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            // padding - 24
            const SizedBox(height: 24),

            // 매매신호 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TitleBar(
                title: "오늘의 AI매매신호는?"
              ),
            ),
            // 매매신호 Contents
            const AISignalStatusCard(),
            const SizedBox(height: 24),

            // 회색 Divider
            Container(
              height: 16,
              color: Colors.grey.shade100
            ),

            // AI픽워드 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TitleBar(
                title: "AI픽워드",
                detailText: "AI가 주가 상승에 영향을 주는 키워드만을 픽!"
              ),
            ),
            // AI픽워드 Stats Card
            const SizedBox(height: 16),
            const AIKeywordStatsCard(),
            const SizedBox(height: 24),

            // 회색 Divider
            Container(
              height: 16,
              color: Colors.grey.shade100
            ),
            const SizedBox(height: 100),
          ],
        ),
        ),
      ),
    );
  }
}
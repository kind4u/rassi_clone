import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/ai_description_card.dart';
import 'package:rassi_clone/components/common/compare_card.dart';
import 'package:rassi_clone/components/common/pickword_card.dart';
import '../../components/common/title_bar.dart';
import '../../components/common/desk_component.dart';
import '../../components/common/page_tab_view.dart';

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
    "신규상장 보기",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            // 라씨데스크 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "라씨데스크",
                detailText: "더보기",
                onDetailTap: () {},
              ),
            ),

            const SizedBox(height: 16),

            // 라씨데스크 Component
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: DeskComponent(onTap: () {}),
            ),

            const SizedBox(height: 24),

            // 라씨의 종목 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "라씨의 종목",
                detailText: _pageDetailTexts[_currentPage], // 선택된 페이지에 따라 변경
                detailColor: Color(0xFF6665FD),
              ),
            ),

            const SizedBox(height: 16),

            // 라씨의 종목 Components
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PageTabView(
                onPageChanged: (index) {
                  // current page state에 따라 라씨의 종목 title text 변경
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            // 매매신호 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "오늘의 AI매매신호는?"),
            ),

            // 매매신호 Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AiDescriptionCard(),
            ),

            const SizedBox(height: 24),

            // 회색 Divider
            Container(height: 16, color: Colors.grey.shade100),

            const SizedBox(height: 24),

            // AI픽워드 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "AI픽워드",
                detailText: "AI가 주가 상승에 영향을 주는 키워드만을 픽!",
              ),
            ),

            // AI픽워드 Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: PickwordCard(),
            ),

            const SizedBox(height: 24),

            // 회색 Divider
            Container(height: 16, color: Colors.grey.shade100),

            const SizedBox(height: 24),

            // 비교종목 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "비교해서 더 좋은 종목 찾기"),
            ),

            // 비교종목 Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CompareCard(),
            ),

            const SizedBox(height: 24),

            // 회색 Divider
            Container(height: 16, color: Colors.grey.shade100),

            const SizedBox(height: 24),

            // 종목 캐치 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "라씨 매매비서가 캐치한 종목",
                detailText: "더보기",
                onDetailTap: () {},
              ),
            ),

            // 종목 캐치 Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AiDescriptionCard(),
            ),

            const SizedBox(height: 24),

            // 회색 Divider
            Container(height: 16, color: Colors.grey.shade100),

            const SizedBox(height: 24),

            // 급상승 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "커뮤니티 활동 급상승",
                detailText: "더보기",
                onDetailTap: () {},
              ),
            ),

            // 여유 공간
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

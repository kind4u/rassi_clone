import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/ai_description_card.dart';
import 'package:rassi_clone/components/common/catch_recommend_card.dart';
import 'package:rassi_clone/components/common/community_card.dart';
import 'package:rassi_clone/components/common/compare_card.dart';
import 'package:rassi_clone/components/common/pickword_card.dart';
import 'package:rassi_clone/components/common/today_issue_component.dart';
import '../../components/common/title_bar.dart';
import '../../components/common/desk_component.dart';
import '../../components/common/page_tab_view.dart';
import '../../models/stock_models.dart';

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

  // 오늘의 이슈 샘플 데이터
  final List<TodayIssue> _todayIssues = const [
    TodayIssue(
      title: "반도체 업계 수출 호조",
      content: "삼성전자와 SK하이닉스를 중심으로 한 반도체 업계의 수출이 크게 증가하면서 관련 주가가 상승세를 보이고 있습니다.",
      signalType: IssueSignalType.up,
    ),
    TodayIssue(
      title: "금리 동결 전망",
      content: "중앙은행의 금리 동결 가능성이 높아지면서 시장이 안정세를 유지하고 있습니다.",
      signalType: IssueSignalType.neutral,
    ),
    TodayIssue(
      title: "자동차 판매 부진",
      content: "글로벌 경기 둔화로 자동차 판매가 감소하면서 완성차 업체들의 실적 우려가 커지고 있습니다.",
      signalType: IssueSignalType.down,
    ),
    TodayIssue(
      title: "바이오 신약 승인",
      content: "국내 바이오 기업의 신약이 FDA 승인을 받으면서 관련 종목이 급등하고 있습니다.",
      signalType: IssueSignalType.up,
    ),
    TodayIssue(
      title: "배터리 소재 공급 증가",
      content: "전기차 시장 성장에 따라 배터리 소재 공급이 증가하면서 관련 업체들의 수익성이 개선되고 있습니다.",
      signalType: IssueSignalType.up,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
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
            Container(height: 12, color: Colors.grey.shade100),

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
            Container(height: 12, color: Colors.grey.shade100),

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
            Container(height: 12, color: Colors.grey.shade100),

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
              child: CatchRecommendCard(),
            ),

            const SizedBox(height: 24),

            // 회색 Divider
            Container(height: 12, color: Colors.grey.shade100),

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
            // 급상승 Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CommunityCard(),
            ),

            const SizedBox(height: 24),

            // 회색 Divider
            Container(height: 12, color: Colors.grey.shade100),

            const SizedBox(height: 24),

            // 오늘의 이슈 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "오늘의 이슈",
                detailText: "더보기",
                onDetailTap: () {},
              ),
            ),

            // 오늘의 이슈 Components
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TodayIssueComponent(issues: _todayIssues),
            ),

            const SizedBox(height: 24),
            // 하단 Banner
            Image.asset('assets/images/bottom_banner.jpg'),
          ],
        ),
      ),
    );
  }
}

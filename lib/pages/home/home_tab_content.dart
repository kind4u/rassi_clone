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
      category: "전선",
      title: "AI • 전기차發 구리 슈퍼사이클 •••ETF•선물시장도 '과열 경고등'",
      content:
          "인공지능 (AI) 데이터센터와 전기차, 재생에너지 확산이 '구리 슈퍼사이클'을 이끌고 있다. 일각에서는 이번 상승을 단순한 호황으로 볼 것이 아니라, 금융상품으로 쏠린 자금과 산업 전반의 비용 부담 그리고 장기 투자 위축이 맞물려 경기 불안을 키울 수 있다는 지적이다.",
      signalType: IssueSignalType.up,
      tags: ["LS마린솔루", "대원전선", "가온전선"],
    ),
    TodayIssue(
      category: "로봇",
      title: "'로봇도 현대차'정의선의 승부수, 연 3만대 찍는 공장 띄웠다",
      content:
          "현대자동차그룹이 차세대 승부수로 '로봇 카드'를 빼들었다. 11일 자동차업계에 따르면 현대차 그룹은 2028년 가동을 목표로 미국 조지아나 엘라배마주 인근에 휴머녿이드 로봇 전용 공장 설립을 추진 중이다. 연간 생산 규모는 3만대 안팎이다.",
      signalType: IssueSignalType.up,
      tags: ["클로봇", "TPC", "서진오토모티"],
    ),
    TodayIssue(
      category: "보험",
      title: "삼성화재, 장 막판 28% 급등... 주문 실수인가 리밸런싱인가",
      content:
          "삼성화재(000810) 주가가 장 마감 직전 돌연 28% 급등했다. 삼성화재 주가는 최근 1년여 간 줄곧 55만원 이하를 유지했지만 이날 오후3시 20분에 갑작스레 상한가 가까이 치솟으며 63만원에 장을 마쳤다. 정규장 이후 이어지는 넥스트레이드(NXT) 애프터마켓에서는 전 거래일 종가 대비 7% 가량 높은 52만 원 대에 손바뀜 되는 중이다.",
      signalType: IssueSignalType.neutral,
      tags: ["코리안리", "한화생명", "한화손해보험"],
    ),
    TodayIssue(
      category: "반도체",
      title: "브로드컴, 또 어닝 서프라이즈... \"AI 칩 매출, 두 배 늘 것\"",
      content:
          "브로드컴이 11일(현지시간) 시장 전망을 웃도는 4분기 실적을 발표하고, 인공지능(AI) 수요 확대를 반영한 강한 분기 전망을 제시했다. 회사 측은 현재 분기 AI칩 매출이 전년 대비 두 배 수준으로 늘어날 것이라고 밝혔다.",
      signalType: IssueSignalType.down,
      tags: ["와이제이링크", "넥스트칩", "엠디바이스"],
    ),
    TodayIssue(
      category: "제약 바이오",
      title: "할로자임, MSD 이어 알테오젠 '정조준' 美서 핵심 특허 무효화 공세",
      content:
          "글로벌 피하주사(SC) 제형 변경 기술 시장을 둘러싼 특허 전쟁이 난타전 양상으로 치닫고 있다. 미국 머크(이하 MSD)가 SC 제형 변경 분야의 선두 주자인 할로자임 테라퓨틱스(Halozyme THerapeutics, 이하 할로자임)의 특허 장벽을 허물기 위해 전방위 공세를 펼침",
      signalType: IssueSignalType.down,
      tags: ["소룩스", "에임드바이오", "삼성에피스홀"],
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

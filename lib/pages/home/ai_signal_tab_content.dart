import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/ai_description_card.dart';
import 'package:rassi_clone/components/common/ai_description_detail_card.dart';
import 'package:rassi_clone/components/common/ai_filter_items.dart';
import 'package:rassi_clone/components/common/page_tab_view.dart';
import 'package:rassi_clone/components/common/population_signal_card.dart';
import 'package:rassi_clone/components/common/signal_combine_card.dart';
import 'package:rassi_clone/components/common/story_card.dart';
import '../../components/common/title_bar.dart';

/// AI 매매신호 탭
class AISignalTabContent extends StatefulWidget {
  const AISignalTabContent({super.key});

  @override
  State<AISignalTabContent> createState() => _AISignalTabContentState();
}

class _AISignalTabContentState extends State<AISignalTabContent> {
  int _currentPage = 0;

  // 페이지별 detailText
  final List<String> _pageDetailTexts = [
    "최근 매도 종목",
    "최근 매수 종목",
    "보유 종목 상승률 TOP",
    "문의가 많은 종목",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            // 매매신호 Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(
                title: "오늘의 AI매매신호",
                detailText: "더보기",
                detailColor: Color(0xFF6665FD),
                onDetailTap: () {},
              ),
            ),

            // 매매신호 Contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AiDescriptionDetailCard(),
            ),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
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

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            // population signal title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "인기 종목의 AI매매신호", onDetailTap: () {}),
            ),

            SizedBox(height: 12),

            // population signal contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PopulationSignalCard(),
            ),

            SizedBox(height: 12),

            // population signal view more component
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 1.0, // 테두리 두께
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("인기종목 더보기")],
                ),
              ),
            ),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            // story title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "라씨 매매비서의 스토리", onDetailTap: () {}),
            ),

            // story contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: StoryCard(),
            ),

            // story view more contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 1.0, // 테두리 두께
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("스토리 더보기")],
                ),
              ),
            ),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            // filter title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "특정 조건 종목들", onDetailTap: () {}),
            ),

            // filter contents
            Padding(
              // horizontal + top
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 24.0,
                right: 24.0,
              ),
              child: AiFilterItems(),
            ),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            // combine board title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "매매신호 종합보드", onDetailTap: () {}),
            ),

            // combine board contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SignalCombineCard(),
            ),

            // combine board view more contents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey.shade400, // 테두리 색상
                    width: 1.0, // 테두리 두께
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("종합보드 더보기")],
                ),
              ),
            ),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            // results TOP title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TitleBar(title: "성과 TOP 종목", onDetailTap: () {}),
            ),

            // results TOP contents

            // padding
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

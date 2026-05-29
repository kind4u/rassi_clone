import 'package:flutter/material.dart';
import 'package:rassi_clone/presentation/components/ai/ai_description_detail_card.dart';
import 'package:rassi_clone/presentation/components/ai/ai_filter_items.dart';
import 'package:rassi_clone/presentation/components/ai/ai_story_card.dart';
import 'package:rassi_clone/presentation/components/shared/page_tab_view.dart';
import 'package:rassi_clone/presentation/components/ai/population_signal_card.dart';
import 'package:rassi_clone/presentation/components/stock_catch/result_top_card.dart';
import 'package:rassi_clone/presentation/components/ai/signal_combine_card.dart';
import 'package:rassi_clone/presentation/components/shared/title_bar.dart';

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
            _aiDescriptionDetail(),
            _divider(),

            _rassiContent(),
            _divider(),

            _populationSignal(),
            _divider(),

            _storyCard(),
            _divider(),

            _aiFilterItems(),
            _divider(),

            _summaryBoard(),
            _divider(),

            _resultTopItems(),
            // padding
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(height: 12, color: Colors.grey.shade100),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _aiDescriptionDetail() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "오늘의 AI매매신호",
            detailText: "더보기",
            detailColor: Color(0xFF6665FD),
            onDetailTap: () {},
          ),
          AiDescriptionDetailCard(),
        ],
      ),
    );
  }

  Widget _rassiContent() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "라씨의 종목",
            detailText: _pageDetailTexts[_currentPage], // 선택된 페이지에 따라 변경
            detailColor: Color(0xFF6665FD),
          ),
          SizedBox(height: 16.0),
          PageTabView(
            onPageChanged: (index) {
              // current page state에 따라 라씨의 종목 title text 변경
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _populationSignal() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 12.0,
        children: [
          TitleBar(title: "인기 종목의 AI매매신호"),
          PopulationSignalCard(),

          // view more content - 임시
          Container(
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
        ],
      ),
    );
  }

  Widget _storyCard() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(title: "라씨 매매비서의 스토리"),
          AiStoryCard(),
        ],
      ),
    );
  }

  Widget _aiFilterItems() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(title: "특정 조건 종목들"),
          AiFilterItems(),
        ],
      ),
    );
  }

  Widget _summaryBoard() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(title: "매매신호 종합보드"),
          SignalCombineCard(),
        ],
      ),
    );
  }

  Widget _resultTopItems() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "성과 TOP 종목",
            detailIcon: Icons.help_outline,
            detailIconColor: Colors.grey,
            detailIconSize: 24,
            onDetailTap: () {},
          ),
          ResultTopCard(),
        ],
      ),
    );
  }
}

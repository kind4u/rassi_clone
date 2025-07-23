import 'package:flutter/material.dart';
import '../common/title_bar.dart';
import '../common/desk_component.dart';
import '../common/page_tab_view.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TitleBar(
              title: "오늘의 추천",
              detailText: "더보기",
              onDetailTap: () => print('더보기 클릭됨'),
            ),
            const SizedBox(height: 16),
            DeskComponent(
              onTap: () => print('DeskComponent 클릭됨'),
            ),
            const SizedBox(height: 24),
            TitleBar(
              title: "인기 종목",
              detailText: _pageDetailTexts[_currentPage], // 선택된 페이지에 따라 변경
              onDetailTap: () => print('${_pageDetailTexts[_currentPage]} 클릭됨'),
            ),
            const SizedBox(height: 16),
            PageTabView(
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

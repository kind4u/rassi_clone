import 'package:flutter/material.dart';
import 'square_component.dart';

/// Flutter 기본 PageView를 사용한 간단하고 안정적인 PageTabView
/// 4개 페이지, 각 페이지마다 3개의 SquareComponent
class PageTabView extends StatefulWidget {
  final Function(int)? onPageChanged;

  const PageTabView({
    super.key,
    this.onPageChanged,
  });

  @override
  State<PageTabView> createState() => _PageTabViewState();
}

class _PageTabViewState extends State<PageTabView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 각 페이지별 샘플 데이터
  final List<List<Map<String, String>>> _pageData = [
    [
      {'title': '삼성전자', 'subtitle': '+2.1%'},
      {'title': 'SK하이닉스', 'subtitle': '+1.8%'},
      {'title': 'LG에너지', 'subtitle': '+3.2%'},
    ],
    [
      {'title': 'NAVER', 'subtitle': '+0.9%'},
      {'title': '카카오', 'subtitle': '-1.2%'},
      {'title': '셀트리온', 'subtitle': '+2.7%'},
    ],
    [
      {'title': '현대차', 'subtitle': '+1.5%'},
      {'title': '포스코', 'subtitle': '+0.8%'},
      {'title': 'KB금융', 'subtitle': '+1.1%'},
    ],
    [
      {'title': '아모레퍼시픽', 'subtitle': '+2.3%'},
      {'title': 'CJ제일제당', 'subtitle': '+0.5%'},
      {'title': '한국전력', 'subtitle': '-0.3%'},
    ],
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSquareGrid(List<Map<String, String>> pageData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: pageData.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < pageData.length - 1 ? 8.0 : 0,
              ),
              child: SquareComponent(
                title: data['title']!,
                subtitle: data['subtitle']!,
                onTap: () => print('${data['title']} 클릭됨'),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180, // 정사각형을 위한 적절한 높이
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(index);
              }
            },
            children: _pageData.map((pageData) => _buildSquareGrid(pageData)).toList(),
          ),
        ),
        const SizedBox(height: 16),
        
        // 페이지 인디케이터
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _pageData.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.deepPurple
                    : Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'square_component.dart';

/// Flutter 기본 PageView를 사용한 간단하고 안정적인 PageTabView
/// 4개 페이지, 각 페이지마다 3개의 SquareComponent
class PageTabView extends StatefulWidget {
  final Function(int)? onPageChanged;

  const PageTabView({super.key, this.onPageChanged});

  @override
  State<PageTabView> createState() => _PageTabViewState();
}

class _PageTabViewState extends State<PageTabView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 각 페이지별 샘플 데이터 하드코딩
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
    // 배지 배경색 (연한 버전)
    final List<Color> badgeColors = [
      Color(0xFF6665FD).withValues(alpha: 0.05), // 1번 - 연한 보라
      Colors.blue.shade50, // 2번 - 연한 파랑
      Colors.amber.shade50, // 3번 - 연한 노랑
    ];

    // 배지 텍스트 색상 (진한 버전)
    final List<Color> badgeTextColors = [
      Color(0xFF6665FD), // 1번 - 진한 보라
      Colors.blue, // 2번 - 진한 파랑
      Colors.amber.shade700, // 3번 - 진한 노랑 (가독성을 위해 더 진하게)
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // 전체 가용 넓이를 3등분하고 간격을 뺀 실제 아이템 너비 계산
        final spacing = 8.0;
        final totalSpacing = spacing * (pageData.length - 1);
        final itemWidth =
            (constraints.maxWidth - 12 - totalSpacing) / pageData.length;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: pageData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: itemWidth, // 완전히 동일한 고정 너비
                height: itemWidth,
                child: SquareComponent(
                  title: data['title']!,
                  subtitle: data['subtitle']!,
                  badgeColor: index < badgeColors.length
                      ? badgeColors[index]
                      : null,
                  badgeTextColor: index < badgeTextColors.length
                      ? badgeTextColors[index]
                      : null,
                  onTap: () => {},
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130, // 정사각형을 위한 적절한 높이
          child: PageView(
            clipBehavior: Clip.hardEdge,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(index);
              }
            },
            children: _pageData
                .map((pageData) => _buildSquareGrid(pageData))
                .toList(),
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
                color: _currentPage == index ? Colors.black : Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

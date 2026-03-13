import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/market_ai_news_component.dart';
import 'package:rassi_clone/components/common/net_sales_stock_component.dart';
import 'package:rassi_clone/components/common/title_bar.dart';
import 'package:rassi_clone/components/common/today_hot_issue_component.dart';
import 'package:rassi_clone/components/common/today_quick_stock_scan_component.dart';

class MarketViewTabContent extends StatefulWidget {
  const MarketViewTabContent({super.key});

  @override
  State<MarketViewTabContent> createState() => _MarketViewTabContentState();
}

class _MarketViewTabContentState extends State<MarketViewTabContent> {
  String _selectedCountry = "KR";

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
          _HotIssueTitleBar(
            country: _selectedCountry,
            onCountryChanged: (country) {
              setState(() {
                _selectedCountry = country;
              });
            },
          ),

          TodayHotIssueComponent(country: _selectedCountry),
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
        children: [
          TitleBar(title: "오늘의 특징주 빠르게 보기", onDetailTap: () {}),
          TodayQuickStockScanComponent(),
        ],
      ),
    );
  }

  // 외국인/기관 순매매 section
  Widget _netSalesStock() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(title: "외국인/기관 순매매", onDetailTap: () {}),
          NetSalesStockComponent(),
        ],
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

          MarketAiNewsComponent(),
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

/// 오늘의 핫이슈 전용 타이틀 바 컴포넌트
/// country 파라미터를 통해 TodayHotIssueComponent에 전달 예정
class _HotIssueTitleBar extends StatefulWidget {
  final String country;
  final ValueChanged<String> onCountryChanged;

  const _HotIssueTitleBar({
    required this.country,
    required this.onCountryChanged,
  });

  @override
  State<_HotIssueTitleBar> createState() => _HotIssueTitleBarState();
}

class _HotIssueTitleBarState extends State<_HotIssueTitleBar> {
  final GlobalKey _titleBarKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  String get _currentTitle => widget.country == "KR" ? "오늘의 핫이슈" : "미국시장 이슈";

  @override
  void dispose() {
    // dispose 시에는 setState 호출하지 않고 OverlayEntry만 제거
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final RenderBox renderBox =
        _titleBarKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 배경 탭하면 드롭다운 닫기
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
          ),
          // 드롭다운 리스트
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: size.width,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDropdownItem("오늘의 핫이슈", "이슈 중 특히 강세를 보인 핫 이슈", "KR"),
                    Divider(height: 1, color: Colors.grey.shade200),
                    _buildDropdownItem(
                      "미국시장 이슈",
                      "TOP2000 종목의 급등락 사유를 분석",
                      "EN",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  Widget _buildDropdownItem(String title, String subTitle, String country) {
    final isSelected = widget.country == country;
    return InkWell(
      onTap: () {
        widget.onCountryChanged(country);
        _removeOverlay();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Color(0xFF6665FD) : Colors.black,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.check,
              color: Color(0xFF6665FD).withValues(alpha: isSelected ? 1 : 0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: _titleBarKey,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _currentTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedRotation(
                turns: _isDropdownOpen ? -0.25 : 0.25, // 위: -90도, 아래: 90도
                duration: const Duration(milliseconds: 300),
                child: Icon(Icons.play_arrow, color: Colors.black, size: 16),
              ),
            ],
          ),
        ),
        // 국가 토글 버튼
        _buildCountryToggle(),
      ],
    );
  }

  Widget _buildCountryToggle() {
    final isKR = widget.country == "KR";
    const double buttonWidth = 70;
    const double buttonHeight = 32;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: buttonWidth * 2,
        height: buttonHeight,
        child: Stack(
          children: [
            // 슬라이딩 배경 (애니메이션)
            AnimatedAlign(
              alignment: isKR ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                width: buttonWidth,
                height: buttonHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
            // 텍스트 버튼들 (고정 위치)
            Row(
              children: [
                _buildToggleButton(
                  "한국",
                  "🇰🇷",
                  "KR",
                  isKR,
                  buttonWidth,
                  buttonHeight,
                ),
                _buildToggleButton(
                  "미국",
                  "🇺🇸",
                  "EN",
                  !isKR,
                  buttonWidth,
                  buttonHeight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(
    String label,
    String flag,
    String country,
    bool isActive,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () => widget.onCountryChanged(country),
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive) ...[
              Text(flag, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                color: isActive ? Colors.black : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

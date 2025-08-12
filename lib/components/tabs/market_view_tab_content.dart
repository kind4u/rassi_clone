import 'package:flutter/material.dart';
import '../common/rassi_card.dart';

/// 마켓뷰 탭의 콘텐츠를 담당하는 위젯
class MarketViewTabContent extends StatelessWidget {
  const MarketViewTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
        _buildGlobalMarket(),
        const SizedBox(height: 16),
        _buildMarketAnalysis(),
        const SizedBox(height: 16),
        _buildGlobalIndices(),
        const SizedBox(height: 100),
      ],
        ),
      ),
    );
  }

  Widget _buildGlobalMarket() {
    return RassiCard(
      title: '🌍 글로벌 시장',
      child: Column(
        children: [
          _buildMarketViewItem('미국 시장', '상승 +1.2%', Colors.red),
          _buildMarketViewItem('중국 시장', '하락 -0.8%', Colors.blue),
          _buildMarketViewItem('유럽 시장', '보합 +0.1%', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildMarketAnalysis() {
    return RassiCard(
      title: '📊 시장 분석',
      child: Column(
        children: [
          _buildAnalysisItem('시장 심리', '중립', '투자자 심리 지수 50'),
          _buildAnalysisItem('기술적 분석', '강세', '상승 추세 지속'),
          _buildAnalysisItem('거시경제', '양호', '금리 안정화'),
        ],
      ),
    );
  }

  Widget _buildGlobalIndices() {
    return RassiCard(
      title: '🌐 해외 주요 지수',
      child: Column(
        children: [
          _buildIndexItem('S&P 500', '4,850.20', '+1.2%', Colors.red),
          _buildIndexItem('나스닥', '15,200.50', '+1.8%', Colors.red),
          _buildIndexItem('다우존스', '38,500.80', '+0.9%', Colors.red),
        ],
      ),
    );
  }

  // 헬퍼 메서드들
  Widget _buildMarketViewItem(String market, String trend, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            market,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            trend,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(String category, String status, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == '강세'
                  ? Colors.red.withOpacity(0.1)
                  : status == '약세'
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: status == '강세'
                    ? Colors.red
                    : status == '약세'
                        ? Colors.blue
                        : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexItem(String name, String value, String change, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

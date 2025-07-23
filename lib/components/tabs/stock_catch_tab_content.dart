import 'package:flutter/material.dart';
import '../common/rassi_card.dart';

/// 종목캐치 탭의 콘텐츠를 담당하는 위젯
class StockCatchTabContent extends StatelessWidget {
  const StockCatchTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStockCatch(),
        const SizedBox(height: 16),
        _buildTrendingStocks(),
        const SizedBox(height: 16),
        _buildBreakoutStocks(),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildStockCatch() {
    return RassiCard(
      title: '🎯 종목 캐치',
      child: Column(
        children: [
          _buildCatchItem('급등 예상주', '테슬라, 애플, 엔비디아', Colors.red),
          _buildCatchItem('배당주', '코카콜라, 존슨앤존슨', Colors.green),
          _buildCatchItem('성장주', '구글, 마이크로소프트', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildTrendingStocks() {
    return RassiCard(
      title: '🔥 트렌딩 종목',
      child: Column(
        children: [
          _buildTrendingItem('엔비디아', '급등', '+15.2%', Colors.red),
          _buildTrendingItem('테슬라', '상승', '+8.5%', Colors.red),
          _buildTrendingItem('애플', '보합', '+1.2%', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBreakoutStocks() {
    return RassiCard(
      title: '📈 돌파 종목',
      child: Column(
        children: [
          _buildBreakoutItem('삼성전자', '저항선 돌파', '70,500원'),
          _buildBreakoutItem('SK하이닉스', '상승 삼각형', '122,000원'),
          _buildBreakoutItem('LG화학', '박스권 상단', '385,000원'),
        ],
      ),
    );
  }

  // 헬퍼 메서드들
  Widget _buildCatchItem(String category, String stocks, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          Expanded(
            child: Text(
              stocks,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingItem(String stock, String trend, String change, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stock,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                change,
                style: TextStyle(
                  fontSize: 14,
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

  Widget _buildBreakoutItem(String stock, String pattern, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                pattern,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

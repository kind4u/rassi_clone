import 'package:flutter/material.dart';
import '../../models/stock_models.dart';
import '../common/rassi_card.dart';
import '../home/ai_signal_list_item.dart';

/// AI 매매신호 탭의 콘텐츠를 담당하는 위젯
class AISignalTabContent extends StatelessWidget {
  const AISignalTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAISignals(),
        const SizedBox(height: 16),
        _buildSignalHistory(),
        const SizedBox(height: 16),
        _buildRecentSignals(),
        const SizedBox(height: 16),
        _buildPerformance(),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildAISignals() {
    final signals = [
      const AISignal(
        stockName: '삼성전자',
        signal: '매수',
        description: '강력 추천',
        type: SignalType.buy,
      ),
      const AISignal(
        stockName: 'SK하이닉스',
        signal: '매도',
        description: '위험 신호',
        type: SignalType.sell,
      ),
      const AISignal(
        stockName: 'LG에너지솔루션',
        signal: '보유',
        description: '관망',
        type: SignalType.hold,
      ),
    ];

    return RassiCard(
      title: '🤖 AI 매매 신호',
      child: Column(
        children: signals
            .map((signal) => AISignalListItem(
                  signal: signal,
                  onTap: () {
                    // 신호 상세 페이지로 이동
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSignalHistory() {
    return RassiCard(
      title: '📈 신호 히스토리',
      child: Column(
        children: [
          _buildHistoryItem('2024-01-15', '삼성전자 매수', '+12.5%'),
          _buildHistoryItem('2024-01-14', 'SK하이닉스 매도', '+8.3%'),
          _buildHistoryItem('2024-01-13', 'LG에너지 보유', '+0.5%'),
        ],
      ),
    );
  }

  Widget _buildRecentSignals() {
    return RassiCard(
      title: '🔔 최근 신호',
      child: Column(
        children: [
          _buildRecentSignalItem('방금 전', '테슬라', '매수 신호', Colors.red),
          _buildRecentSignalItem('5분 전', '애플', '매도 신호', Colors.blue),
          _buildRecentSignalItem('10분 전', '마이크로소프트', '보유 신호', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildPerformance() {
    return RassiCard(
      title: '📊 신호 성과',
      child: Column(
        children: [
          _buildPerformanceItem('이번 주', '성공률 78%', '+12.5%'),
          _buildPerformanceItem('이번 달', '성공률 82%', '+24.8%'),
          _buildPerformanceItem('3개월', '성공률 75%', '+45.2%'),
        ],
      ),
    );
  }

  // 헬퍼 메서드들
  Widget _buildHistoryItem(String date, String action, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                action,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            result,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSignalItem(String time, String stock, String signal, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$stock - $signal',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String period, String success, String returnValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            period,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                success,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
              Text(
                returnValue,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
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

import 'package:flutter/material.dart';
import '../../models/stock_models.dart';

/// 대중 신호를 표시하는 개별 컴포넌트
class PopulationSignalComponent extends StatelessWidget {
  final PopulationSignal signal;
  final VoidCallback? onTap;

  const PopulationSignalComponent({
    super.key,
    required this.signal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWatching = signal.status == PopulationStatus.watching;
    final statusColor = isWatching ? Colors.orange : Colors.green;
    final statusText = isWatching ? '관망중' : '보유중';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 왼쪽: 상태 배지 + 주식 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상태 배지
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 주식 이름
                  Text(
                    signal.stockName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 종목 코드
                  Text(
                    signal.stockCode,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // 오른쪽: 관망 일수 또는 보유 정보
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isWatching && signal.watchingDays != null) ...[
                  Text(
                    '관망 ${signal.watchingDays}일차',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ] else if (!isWatching) ...[
                  // 수익률
                  if (signal.returnRate != null)
                    Text(
                      signal.returnRate!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: signal.returnRate!.startsWith('+')
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  const SizedBox(height: 4),
                  // 매수가
                  if (signal.purchasePrice != null)
                    Text(
                      signal.purchasePrice!,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 대중 신호 목록을 표시하는 카드
class PopulationSignalCard extends StatelessWidget {
  const PopulationSignalCard({super.key});

  // 하드코딩된 샘플 데이터
  static const List<PopulationSignal> _sampleSignals = [
    PopulationSignal(
      stockName: '삼성전자',
      stockCode: '005930',
      status: PopulationStatus.watching,
      watchingDays: 3,
    ),
    PopulationSignal(
      stockName: 'SK하이닉스',
      stockCode: '000660',
      status: PopulationStatus.holding,
      purchasePrice: '150,000원',
      returnRate: '+12.5%',
    ),
    PopulationSignal(
      stockName: 'NAVER',
      stockCode: '035420',
      status: PopulationStatus.watching,
      watchingDays: 7,
    ),
    PopulationSignal(
      stockName: '카카오',
      stockCode: '035720',
      status: PopulationStatus.holding,
      purchasePrice: '48,500원',
      returnRate: '-5.2%',
    ),
    PopulationSignal(
      stockName: '현대차',
      stockCode: '005380',
      status: PopulationStatus.holding,
      purchasePrice: '245,000원',
      returnRate: '+8.3%',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: _sampleSignals
            .map((signal) => PopulationSignalComponent(signal: signal))
            .toList(),
      ),
    );
  }
}

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
    final statusColor = isWatching ? Colors.grey : Colors.red;
    final statusText = isWatching ? '관망중' : '보유중';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 6,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 왼쪽: 상태 배지 + 주식 정보
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 상태 배지
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 주식 이름
                        Text(
                          signal.stockName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // 종목 코드
                        Text(
                          signal.stockCode,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 오른쪽: 관망 일수 또는 보유 정보
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 관망중일때
                  if (isWatching && signal.watchingDays != null) ...[
                    Text(
                      '관망 ${signal.watchingDays}일차',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    // 보유중일때
                  ] else if (!isWatching) ...[
                    // 매수가
                    if (signal.purchasePrice != null)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '매수가 ',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),

                            TextSpan(
                              text: signal.purchasePrice!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            TextSpan(
                              text: '원',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // 수익률
                    if (signal.returnRate != null)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '보유수익률 ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            TextSpan(
                              text: signal.returnRate!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: signal.returnRate!.startsWith('+')
                                    ? Colors.red
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 4),
                  ],
                ],
              ),
            ],
          ),
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
      purchasePrice: '150,000',
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
      purchasePrice: '48,500',
      returnRate: '-5.2%',
    ),
    PopulationSignal(
      stockName: '현대차',
      stockCode: '005380',
      status: PopulationStatus.holding,
      purchasePrice: '245,000',
      returnRate: '+8.3%',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _sampleSignals
          .map((signal) => PopulationSignalComponent(signal: signal))
          .toList(),
    );
  }
}

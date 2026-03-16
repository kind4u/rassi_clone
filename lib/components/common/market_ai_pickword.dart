import 'package:flutter/material.dart';

class MarketAiPickword extends StatelessWidget {
  const MarketAiPickword({super.key});
  static const _majorKeyword = '호르무즈';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Text.rich(
              textAlign: TextAlign.left,
              TextSpan(
                children: [
                  TextSpan(
                    text: _majorKeyword,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: '외 1개의 새로운 마켓 픽워드가 있어요.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

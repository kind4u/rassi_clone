import 'package:flutter/material.dart';
import 'package:rassi_clone/presentation/components/ai/story_card.dart';

class AiStoryCard extends StatelessWidget {
  const AiStoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            StoryCard(
              category: '주간브리핑',
              contentTitle: '변동성 장세를 이기는 리밸런싱 전략',
              contentDate: '5월 셋째주',
            ),
            StoryCard(
              category: '주간브리핑',
              contentTitle: '이제는 변동성의 시간이다.',
              contentDate: '5월 둘째주',
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey, // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("스토리 더보기")],
          ),
        ),
      ],
    );
  }
}

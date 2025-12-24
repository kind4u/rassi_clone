import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.pinkAccent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("주간브리핑"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Post Title"), Text("post period")]),
              // image
              Icon(Icons.document_scanner),
            ],
          ),
        ],
      ),
    );
  }
}

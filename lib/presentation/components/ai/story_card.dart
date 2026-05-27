import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String category;
  final String contentTitle;
  final String contentDate;

  const StoryCard({
    super.key,
    required this.category,
    required this.contentTitle,
    required this.contentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: TextStyle(color: Color(0xFF6665FD))),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contentTitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(contentDate, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                // image
                Icon(Icons.document_scanner, size: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

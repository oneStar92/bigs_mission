import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  final String title;
  final String category;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Text(title, style: smallTextStyle, textAlign: TextAlign.start),
          Row(spacing: 6, children: [Text(category, style: xSmallTextStyle), Text(timeAgo, style: xSmallTextStyle)]),
        ],
      ),
    );
  }

  const BoardWidget({super.key, required this.title, required this.category, required this.timeAgo});
}


import 'package:flutter/material.dart';
import 'package:github_clone/src/src.dart';

class LabelItem extends StatelessWidget {
  const LabelItem({super.key, required this.label});
  final Label label;

  @override
  Widget build(BuildContext context) {
    final Color color = Color(
        int.parse(("#${label.color}").substring(1, 7), radix: 16) + 0xFF000000);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: kRadius,
        color: color.withOpacity(0.3),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Text(
        label.name,
        style: context.textTheme.labelMedium,
      ),
    );
  }
}

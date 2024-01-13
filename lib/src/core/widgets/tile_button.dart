import 'package:flutter/material.dart';

import 'primary_container.dart';

class TileButton extends StatelessWidget {
  const TileButton({
    super.key,
    required this.icon,
    required this.title,
    this.trailing = "",
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.zero,
      onTap: onTap,
      marign: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: Text(trailing),
      ),
    );
  }
}

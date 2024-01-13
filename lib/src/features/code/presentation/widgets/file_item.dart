
import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/code/domain/domain.dart';

class FileItem extends StatelessWidget {
  const FileItem({
    super.key,
    required this.file,
    this.onTap,
  });

  final FileInfo file;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.zero,
      marign: const EdgeInsets.only(bottom: 12),
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          file.isFolder
              ? Icons.folder_open_rounded
              : Icons.insert_drive_file_outlined,
          color: file.isFolder
              ? context.colorScheme.primary
              : context.colorScheme.onSurfaceVariant,
        ),
        title: Text(file.name),
        trailing: file.isFolder ? null : Text(file.size.formatSize),
      ),
    );
  }
}

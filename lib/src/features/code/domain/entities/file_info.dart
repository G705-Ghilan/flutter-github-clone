import 'package:equatable/equatable.dart';

class FileInfo extends Equatable {
  final String? content;
  final String? encoding;
  final String name;
  final String path;
  final int size;
  final bool isFolder;

  const FileInfo({
    required this.content,
    required this.encoding,
    required this.name,
    required this.path,
    required this.size,
    required this.isFolder,
  });

  factory FileInfo.fake() {
    return const FileInfo(
      content: "Some Text here",
      encoding: "base",
      name: "Folder name",
      path: "Folder/path",
      size: 8383,
      isFolder: false,
    );
  }

  @override
  List<Object?> get props => [
        content,
        encoding,
        name,
        path,
        size,
        isFolder,
      ];
}

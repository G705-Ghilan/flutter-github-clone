import 'package:github_clone/src/features/code/domain/entities/file_info.dart';

class FileInfoModel extends FileInfo {
  const FileInfoModel({
    required super.content,
    required super.encoding,
    required super.name,
    required super.path,
    required super.size,
    required super.isFolder,
  });

  factory FileInfoModel.fromJson(Map<String, dynamic> json) {
    return FileInfoModel(
      content: json["content"],
      encoding: json["encoding"],
      name: json["name"],
      path: json["path"],
      size: json["size"],
      isFolder: json["type"] == "dir",
    );
  }
}

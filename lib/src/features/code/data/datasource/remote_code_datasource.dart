import 'dart:convert';

import 'package:github_clone/src/src.dart';

abstract class RemoteCodeDataSource {
  Future<List<FileInfoModel>> getFiles(CodeParams params);
  Future<FileInfoModel> getCode(CodeParams params);
}

class RemoteCodeDataSourceImpl implements RemoteCodeDataSource {
  final DioClient client;

  RemoteCodeDataSourceImpl(this.client);

  @override
  Future<FileInfoModel> getCode(CodeParams params) async {
    final response = await client.dio.get(
      "/repos/${params.username}/${params.repository}/contents/${params.path}",
      options: await client.refreshIfConnectedOption(),
    );

    if ([200, 304].contains(response.statusCode)) {
      final Map<String, dynamic> json = response.data;
      if (json["encoding"] == "base64") {
        json["content"] = _decodeBase64(json["content"] ?? "");
      }
      return FileInfoModel.fromJson(json);
    }
    throw "error";
  }

  @override
  Future<List<FileInfoModel>> getFiles(CodeParams params) async {
    final response = await client.dio.get(
      "/repos/${params.username}/${params.repository}/contents/${params.path}",
      options: await client.refreshIfConnectedOption(),
    );

    if ([200, 304].contains(response.statusCode)) {
      return [
        for (Map<String, dynamic> json in response.data)
          FileInfoModel.fromJson(json)
      ];
    }
    return [];
  }

  String _decodeBase64(String code) {
    code = code.split("\n").join("");
    List<int> decodedBytes = base64Decode(code);
    try {
      return utf8.decode(decodedBytes);
    } catch (e) {
      return "Unreadable";
    }
  }
}

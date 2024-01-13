import 'package:github_clone/src/features/issues/domain/entities/label.dart';

class LabelModel extends Label {
  const LabelModel({required super.name, required super.color});
  factory LabelModel.fromJson(Map<String, dynamic> json) {
    return LabelModel(name: json["name"], color: json["color"]);
  }
}

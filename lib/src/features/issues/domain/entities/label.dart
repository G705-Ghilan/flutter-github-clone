import 'package:equatable/equatable.dart';

class Label extends Equatable{
  final String name;
  final String color;

  const Label({required this.name, required this.color});
  
  @override
  List<Object?> get props => [name, color];
}

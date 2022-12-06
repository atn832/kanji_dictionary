import 'package:json_annotation/json_annotation.dart';

part 'misc.g.dart';

@JsonSerializable()
class Misc {
  // It should be an int but the JSON is a String, so we leave it at that.
  final String jlpt;
  final String grade;

  Misc({required this.jlpt, required this.grade});

  /// Connect the generated [_$MiscFromJson] function to the `fromJson`
  /// factory.
  factory Misc.fromJson(Map<String, dynamic> json) => _$MiscFromJson(json);

  /// Connect the generated [_$MiscToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MiscToJson(this);
}

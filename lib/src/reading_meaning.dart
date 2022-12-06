import 'package:json_annotation/json_annotation.dart';

part 'reading_meaning.g.dart';

@JsonSerializable()
class ReadingMeaning {
  final List<String> nanori;

  ReadingMeaning({required this.nanori});

  /// Connect the generated [_$ReadingMeaningFromJson] function to the `fromJson`
  /// factory.
  factory ReadingMeaning.fromJson(Map<String, dynamic> json) =>
      _$ReadingMeaningFromJson(json);

  /// Connect the generated [_$ReadingMeaningToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReadingMeaningToJson(this);
}

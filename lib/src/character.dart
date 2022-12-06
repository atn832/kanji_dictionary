import 'package:json_annotation/json_annotation.dart';
import 'package:kanjidic/src/reading_meaning.dart';

import 'misc.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final String literal;
  final Misc misc;

  @JsonKey(name: 'reading_meaning')
  final ReadingMeaning readingMeaning;

  Character(
      {required this.literal,
      required this.misc,
      required this.readingMeaning});

  /// Connect the generated [_$CharacterFromJson] function to the `fromJson`
  /// factory.
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// Connect the generated [_$CharacterToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

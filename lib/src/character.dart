import 'package:json_annotation/json_annotation.dart';

import 'misc.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final String literal;
  final Misc misc;

  Character({required this.literal, required this.misc});

  /// Connect the generated [_$CharacterFromJson] function to the `fromJson`
  /// factory.
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// Connect the generated [_$CharacterToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
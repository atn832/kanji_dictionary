import 'package:xml/xml.dart';

import 'difficulty.dart';
import 'language.dart';
import 'meaning.dart';

class Character {
  final String literal;
  final Difficulty difficulty;
  final List<Meaning> meanings;

  Character(
      {required this.literal,
      required this.difficulty,
      required this.meanings});

  List<String> getMeanings(Language language) {
    return meanings
        .where((m) => m.language == language)
        .map((m) => m.meaning)
        .toList();
  }

  factory Character.fromXml(XmlElement el) {
    return Character(
        literal: el.getElement('literal')!.text,
        difficulty: Difficulty.fromXml(el.getElement('misc')!),
        meanings: el
            .getElement('reading_meaning')!
            .getElement('rmgroup')!
            .findElements('meaning')
            .map((e) => Meaning.fromXml(e))
            .toList());
  }
}

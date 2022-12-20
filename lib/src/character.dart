import 'package:xml/xml.dart';

import 'book_index.dart';
import 'difficulty.dart';
import 'language.dart';
import 'meaning.dart';
import 'reading.dart';
import 'readings.dart';

class Character {
  final String literal;
  final Difficulty difficulty;
  final List<Meaning> meanings;
  final Readings _readings;
  final BookIndex index;

  Character(
      {required this.literal,
      required this.difficulty,
      required this.meanings,
      required readings,
      required this.index})
      : _readings = readings;

  List<String> getMeanings(Language language) {
    return meanings
        .where((m) => m.language == language)
        .map((m) => m.meaning)
        .toList();
  }

  Map<Reading, List<String>> get readings => _readings.readings;

  factory Character.fromXml(XmlElement el) {
    final readingMeaning = el.getElement('reading_meaning');
    return Character(
        literal: el.getElement('literal')!.text,
        difficulty: Difficulty.fromXml(el.getElement('misc')!),
        meanings: readingMeaning != null
            ? readingMeaning
                .getElement('rmgroup')!
                .findElements('meaning')
                .map((e) => Meaning.fromXml(e))
                .toList()
            : [],
        readings: Readings.fromXml(el),
        index: BookIndex.fromXml(el.getElement('dic_number')));
  }
}

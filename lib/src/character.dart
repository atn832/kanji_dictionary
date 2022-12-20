import 'package:xml/xml.dart';

import 'book.dart';
import 'book_index.dart';
import 'difficulty.dart';
import 'language.dart';
import 'meanings.dart';
import 'reading.dart';
import 'readings.dart';

class Character {
  final String literal;
  final Difficulty difficulty;
  final Meanings _meanings;
  final Readings _readings;
  final BookIndex _index;

  Character(
      {required this.literal,
      required this.difficulty,
      required Meanings meanings,
      required Readings readings,
      required BookIndex index})
      : _meanings = meanings,
        _readings = readings,
        _index = index;

  Map<Language, List<String>> get meanings => _meanings.meanings;

  Map<Reading, List<String>> get readings => _readings.readings;

  /// Contains the index at which the character appears in Books.
  Map<Book, int> get indexes => _index.indexes;

  factory Character.fromXml(XmlElement el) {
    return Character(
        literal: el.getElement('literal')!.text,
        difficulty: Difficulty.fromXml(el.getElement('misc')!),
        meanings: Meanings.fromXml(el),
        readings: Readings.fromXml(el),
        index: BookIndex.fromXml(el.getElement('dic_number')));
  }
}

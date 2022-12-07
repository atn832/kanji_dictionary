import 'package:kanji_dictionary/src/character.dart';
import 'package:xml/xml.dart';

import 'book_index.dart';
import 'kanjidic2xml.dart';

class KanjiDictionary {
  final int fileVersion;
  final String databaseVersion;
  final DateTime creationTime;
  final List<Character> characters;

  KanjiDictionary(
      {required this.fileVersion,
      required this.databaseVersion,
      required this.creationTime,
      required this.characters});

  /// Lists out characters in the order of a given book.
  List<Character> charactersByBookOrder(Book index) {
    return charactersBy((c) => c.index.indexes[index]);
  }

  List<Character> charactersByGrade() {
    return charactersBy((c) => c.difficulty.grade);
  }

  List<Character> charactersBy(Comparable? Function(Character) getter) {
    final sortedCharacters = KanjiDictionary.instance.characters
        .where((c) => getter(c) != null)
        .toList();
    sortedCharacters.sort((c1, c2) {
      final i1 = getter(c1);
      final i2 = getter(c2);
      assert(i1 != null);
      final compare = i1!.compareTo(i2);
      // Use literal as a tie breaker.
      return compare != 0 ? compare : c1.literal.compareTo(c2.literal);
    });
    return sortedCharacters;
  }

  static KanjiDictionary? _instance;

  /// An instance of KanjiDictionary with the embedded version of KANJIDIC2.
  static KanjiDictionary get instance {
    _instance ??= KanjiDictionary.fromXml(XmlDocument.parse(kanjiDic2Xml));
    return _instance!;
  }

  /// Returns a KanjiDictionary from a version of KANJIDIC2.
  factory KanjiDictionary.fromXml(XmlDocument doc) {
    final dic = doc.getElement('kanjidic2')!;
    final header = dic.getElement('header')!;
    return KanjiDictionary(
        fileVersion: int.parse(header.getElement('file_version')!.text),
        databaseVersion: header.getElement('database_version')!.text,
        creationTime:
            DateTime.parse(header.getElement('date_of_creation')!.text),
        characters: dic
            .findElements('character')
            .map((el) => Character.fromXml(el))
            .toList());
  }
}

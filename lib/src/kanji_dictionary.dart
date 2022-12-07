import 'package:kanji_dictionary/src/character.dart';
import 'package:xml/xml.dart';

import 'book_index.dart';
import 'kanjidic2xml.dart';

class KanjiDictionary {
  final int fileVersion;
  final String databaseVersion;
  final DateTime creationTime;
  final List<Character> _characters;

  KanjiDictionary(
      {required this.fileVersion,
      required this.databaseVersion,
      required this.creationTime,
      required List<Character> characters})
      : _characters = characters;

  /// Returns a copy of the Dictionary's characters. Note: a new list is
  /// returned so that you can safely manipulate it. However, each Character is
  /// mutable.
  List<Character> get characters => _characters.toList();

  /// Lists out characters in the order of a given book.
  List<Character> charactersByBookOrder(Book index) {
    return charactersBy([(c) => c.index.indexes[index]]);
  }

  List<Character> charactersByGrade() {
    return charactersBy([(c) => c.difficulty.grade]);
  }

  List<Character> charactersBy(List<Comparable? Function(Character)> getters) {
    final sortedCharacters =
        characters.where((c) => getters.first(c) != null).toList();
    sortedCharacters.sort((c1, c2) {
      var it = getters.iterator;
      while (it.moveNext()) {
        final getter = it.current;
        final i1 = getter(c1);
        final i2 = getter(c2);
        // If both are missing the value, use the literal as the tie-breaker.
        if (i1 == null && i2 == null) break;
        // If i1 is null but i2 is not, we expect i1 to be larger (ie more
        // complicated) than i2.
        if (i1 == null) return 1;
        if (i2 == null) return -1;

        final compare = i1.compareTo(i2);
        // Use literal as a tie breaker.
        if (compare != 0) return compare;
      }
      // Use the literal as a tie-breaker;
      return c1.literal.compareTo(c2.literal);
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

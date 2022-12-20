import 'dart:isolate';

import 'package:kanji_dictionary/src/character.dart';
import 'package:xml/xml.dart';

import 'book.dart';
import 'kanjidic2xml.dart';

/// A getter for use in [KanjiDictionary.sort] to sort by difficulty using the
/// index in [Book.henshall3]. This book gives the most beginner-friendly
/// ordering of characters.
int? defaultDifficultyGetter(Character c) => c.indexes[Book.henshall3];

/// A function that returns a [Comparable]? from a [Character], used in
/// [KanjiDictionary.sort].
typedef Getter = Comparable? Function(Character);

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

  /// Returns a copy of all the Dictionary's characters in the order of the XML.
  /// Note: a new list is returned so that you can safely manipulate it.
  /// However, each [Character] is mutable.
  List<Character> get characters => _characters.toList();

  /// Returns a sorted copy of the Dictionary's characters by difficulty. See
  /// [defaultDifficultyGetter].
  List<Character> get charactersByDifficulty =>
      charactersBy([defaultDifficultyGetter]);

  /// Returns a sorted copy of the Dictionary's characters by grade, then
  /// difficulty. See [defaultDifficultyGetter].
  List<Character> get charactersByGrade =>
      charactersBy([(c) => c.difficulty.grade, defaultDifficultyGetter]);

  /// Returns a filtered and sorted list of characters. The filtering is done
  /// using the first getter. It removes all characters for which the first
  /// getter returns null. Then the filtering is done using each getter in
  /// order.
  static List<Character> sort(List<Character> characters,
      List<Comparable? Function(Character)> getters) {
    assert(getters.isNotEmpty);
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

  /// Returns a copy of characters filtered and sorted with the given getters.
  /// See [sort] for implementation details.
  List<Character> charactersBy(List<Getter> getters) {
    return sort(characters, getters);
  }

  static Future<KanjiDictionary>? _instance;

  /// An instance of [KanjiDictionary] with the embedded version of KANJIDIC2.
  static Future<KanjiDictionary> get instance async {
    _instance ??= KanjiDictionary.fromXmlString(kanjiDic2Xml);
    return _instance!;
  }

  /// Returns a [KanjiDictionary] from a version of KANJIDIC2.
  static Future<KanjiDictionary> fromXmlString(String xmlDoc) async {
    final p = ReceivePort();
    await Isolate.spawn((p) => _parseKanjiDic(xmlDoc, p), p.sendPort);
    return await p.first as KanjiDictionary;
  }

  /// Parse the XML in an isolate.
  static Future<void> _parseKanjiDic(String xml, SendPort p) async {
    final doc = XmlDocument.parse(xml);
    final dic = doc.getElement('kanjidic2')!;
    final header = dic.getElement('header')!;
    final dictionary = KanjiDictionary(
        fileVersion: int.parse(header.getElement('file_version')!.text),
        databaseVersion: header.getElement('database_version')!.text,
        creationTime:
            DateTime.parse(header.getElement('date_of_creation')!.text),
        characters: dic
            .findElements('character')
            .map((el) => Character.fromXml(el))
            .toList());
    Isolate.exit(p, dictionary);
  }
}

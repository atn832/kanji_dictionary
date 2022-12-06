import 'package:kanji_dictionary/src/character.dart';
import 'package:xml/xml.dart';

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

  static KanjiDictionary? _instance;

  /// An instance of KanjiDictionary with the embedded version of kanji_dictionary2.
  static KanjiDictionary get instance {
    _instance ??= KanjiDictionary.fromXml(XmlDocument.parse(kanjiDic2Xml));
    return _instance!;
  }

  /// Returns a KanjiDictionary from a version of kanji_dictionary2.
  factory KanjiDictionary.fromXml(XmlDocument doc) {
    final dic = doc.getElement('kanji_dictionary2')!;
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

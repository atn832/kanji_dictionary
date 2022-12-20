import 'package:kanji_dictionary/src/language.dart';
import 'package:xml/xml.dart';

class Meanings {
  Meanings(this.meanings);

  final Map<Language, List<String>> meanings;

  factory Meanings.fromXml(XmlElement characterEl) {
    final readingMeanings = characterEl
            .getElement('reading_meaning')
            ?.getElement('rmgroup')!
            .findElements('meaning') ??
        [];
    Map<Language, List<String>> meanings = {};
    for (final e in readingMeanings) {
      final l = Language.fromString(e.getAttribute('m_lang') ?? 'en');
      meanings.putIfAbsent(l, () => []);
      meanings[l]!.add(e.text);
    }
    return Meanings(meanings);
  }
}

import 'package:kanjidic/src/language.dart';
import 'package:xml/xml.dart';

class Meaning {
  final String meaning;
  final Language language;

  Meaning({required this.meaning, required this.language});

  factory Meaning.fromXml(XmlElement el) {
    return Meaning(
        meaning: el.text,
        language: Language.fromString(el.getAttribute('m_lang') ?? 'en'));
  }
}

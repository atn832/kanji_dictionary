import 'package:xml/xml.dart';

class Difficulty {
  /// The pre-2010 level of the Japanese Language Proficiency Test (JLPT) in
  /// which the Kanji occurs. It goes from 4 (easiest) down to 1 (hardest).
  final int? jlpt;

  /// The "grade" of the kanji.
  /// * G1 to G6 indicates the grade level as specified by the Japanese Ministry
  /// of Education for kanji that are to be taught in elementary school (1026
  /// Kanji). These are sometimes called the kyōiku (education) kanji and are
  /// part of the set of jōyō (daily use) kanji;
  /// * G8 indicates the remaining jōyō kanji that are to be taught in secondary
  /// school (additional 1130 Kanji);
  /// * G9 and G10 indicate jinmeiyō ("for use in names") kanji which in
  /// addition to the jōyō kanji are approved for use in family name registers
  /// and other official documents. G9 (649 kanji, of which 640 are in KANJIDIC)
  /// indicates the kanji is a "regular" name kanji, and G10 (212 kanji of which
  /// 130 are in KANJIDIC) indicates the kanji is a variant of a jōyō kanji.
  final int? grade;

  Difficulty({required this.jlpt, required this.grade});

  factory Difficulty.fromXml(XmlElement el) {
    final jlpt = el.getElement('jlpt');
    final grade = el.getElement('grade');
    return Difficulty(
        jlpt: jlpt != null ? int.parse(jlpt.text) : null,
        grade: grade != null ? int.parse(grade.text) : null);
  }
}

import 'package:xml/xml.dart';

class Difficulty {
  final int? jlpt;
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

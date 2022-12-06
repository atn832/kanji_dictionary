import 'package:xml/xml.dart';

class Difficulty {
  final int jlpt;
  final int grade;

  Difficulty({required this.jlpt, required this.grade});

  factory Difficulty.fromXml(XmlElement el) {
    return Difficulty(
        jlpt: int.parse(el.getElement('jlpt')!.text),
        grade: int.parse(el.getElement('grade')!.text));
  }
}

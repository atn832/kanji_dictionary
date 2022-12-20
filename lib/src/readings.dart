import 'package:xml/xml.dart';

import 'reading.dart';

class Readings {
  Readings(this.readings);

  final Map<Reading, List<String>> readings;

  factory Readings.fromXml(XmlElement characterElement) {
    Map<Reading, List<String>> readings = {};
    final readingElements = characterElement
            .getElement('reading_meaning')
            ?.getElement('rmgroup')
            ?.findElements('reading') ??
        [];
    for (final e in readingElements) {
      final r = Reading.fromString(e.getAttribute('r_type')!);
      readings.putIfAbsent(r, () => []);
      readings[r]!.add(e.text);
    }
    return Readings(readings);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:xml2json/xml2json.dart';

main() {
  final xml = File('./assets/kanjidic2.xml').readAsStringSync();
  final myTransformer = Xml2Json();

  // Parse a simple XML string.
  myTransformer.parse(xml);
  File('output_badgerfish.json')
      .writeAsStringSync(myTransformer.toBadgerfish());
  File('output_parker_with_attr.json')
      .writeAsStringSync(myTransformer.toParkerWithAttrs());
  File('output_parker.json').writeAsStringSync(myTransformer.toParker());
  File('output_gdata.json').writeAsStringSync(myTransformer.toGData());
}

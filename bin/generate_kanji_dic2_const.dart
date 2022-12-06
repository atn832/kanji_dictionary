import 'dart:io';

/// Generates kanjidic2xml.dart, which kanji_dictionary uses for initialization.
main() {
  final xml = File('./assets/kanjidic2.xml').readAsStringSync();
  File('./lib/src/kanjidic2xml.dart')
      .writeAsStringSync("const kanjiDic2Xml = '''$xml''';");
}

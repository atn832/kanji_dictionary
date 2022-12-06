import 'dart:io';

main() {
  final xml = File('./assets/kanjidic2.xml').readAsStringSync();
  File('./lib/src/kanjidic2xml.dart')
      .writeAsStringSync("const kanjiDic2Xml = '''$xml''';");
}

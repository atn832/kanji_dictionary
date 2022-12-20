import 'dart:convert';
import 'dart:io';

// Since this script is used only when developing, I added http as a dev
// dependency and we can ignore the warning.
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

/// Generates kanjidic2xml.dart from the official KANJIDIC repository.
/// kanji_dictionary uses that file for initialization.
main() async {
  final xml = utf8.decode(gzip.decode(
      (await get(Uri.parse('http://www.edrdg.org/kanjidic/kanjidic2.xml.gz')))
          .bodyBytes));
  File('./assets/kanjidic2.xml').writeAsStringSync(xml);
  File('./lib/src/kanjidic2xml.dart')
      .writeAsStringSync("const kanjiDic2Xml = '''$xml''';\n");
}

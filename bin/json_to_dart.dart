import 'dart:convert';

import 'package:kanjidic/src/character.dart';

main() {
  final jsonCharacter =
      '{"literal": "亜", "codepoint": {"cp_value": ["4e9c", "1-16-01"]}, "radical": {"rad_value": ["7", "1"]}, "misc": {"grade": "8", "stroke_count": "7", "variant": "1-48-19", "freq": "1509", "jlpt": "1"}, "dic_number": {"dic_ref": ["43", "81", "3540", "4354", "2204", "2966", "1809", "1950", "1331", "525", "1788", "272", "997", "1616", "1724", "1032", "1092", "1818", "35", "1827"]}, "query_code": {"q_code": ["4-7-1", "0a7.14", "1010.6", "3273"]}, "reading_meaning": {"rmgroup": {"reading": ["ya4", "a", "아", "A", "Á", "ア", "つ.ぐ"], "meaning": ["Asia", "rank next", "come after", "-ous", "Asie", "suivant", "sub-", "sous-", "pref. para indicar", "venir después de", "Asia", "Ásia", "próxima", "o que vem depois", "-ous"]}, "nanori": ["や", "つぎ", "つぐ"]}}';
  print(Character.fromJson(jsonDecode(jsonCharacter)).literal);
}

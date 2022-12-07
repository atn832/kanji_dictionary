import 'dart:io';

import 'package:kanji_dictionary/kanji_dictionary.dart';

main() {
  List<List<String>> matrix = [
    [for (final index in Indexes.values) index.name]
  ];

  Map<Indexes, List<Character>> indexToCharacters = Map.fromEntries([
    for (final index in Indexes.values)
      MapEntry(index, KanjiDictionary.instance.charactersByIndex(index))
  ]);
  for (int i = 0; i < 500; i++) {
    matrix.add([
      for (final index in Indexes.values)
        indexToCharacters[index]!.length >= i
            ? (indexToCharacters[index]![i].literal +
                indexToCharacters[index]![i].difficulty.grade.toString())
            : ' '
    ]);
  }
  File('table.md').writeAsStringSync(toTable(matrix));
}

String toTable(List<List<String>> matrix) {
  final columns = matrix.first.length;
  assert(matrix.every((row) => row.length == columns));
  return [
    toLine(matrix.first),
    toLine(List.filled(columns, '---')),
    ...[for (final row in matrix.sublist(1)) toLine(row)]
  ].join('\n');
}

String toLine(List<String> row) {
  return '| ${row.join(' | ')} |';
}

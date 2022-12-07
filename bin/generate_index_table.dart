import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:kanji_dictionary/kanji_dictionary.dart';

const kanjiCount = 3000;

main() {
  Map<Indexes, int> gradeDifference = Map.fromEntries([
    for (final index in Indexes.values)
      MapEntry(
          index,
          computeGradeDifference(KanjiDictionary.instance
              .charactersByIndex(index)
              .take(kanjiCount)
              .toList()))
  ]);

  SplayTreeSet<Indexes> sortedIndexes =
      SplayTreeSet.from(Indexes.values, (i1, i2) {
    final diff = gradeDifference[i1]!.compareTo(gradeDifference[i2]!);
    return diff != 0 ? diff : i1.name.compareTo(i2.name);
  });

  List<List<String>> matrix = [
    [
      for (final index in sortedIndexes)
        '${index.name} ${gradeDifference[index]}'
    ]
  ];

  Map<Indexes, List<Character>> indexToCharacters = Map.fromEntries([
    for (final index in sortedIndexes)
      MapEntry(index, KanjiDictionary.instance.charactersByIndex(index))
  ]);
  for (int i = 0; i < kanjiCount; i++) {
    matrix.add([
      for (final index in sortedIndexes)
        indexToCharacters[index]!.length > i
            ? (indexToCharacters[index]![i].literal +
                indexToCharacters[index]![i].difficulty.grade.toString())
            : ''
    ]);
  }
  File('table.md').writeAsStringSync(toTable(matrix));
}

int computeGradeDifference(List<Character> characters) {
  final charactersByGrade = KanjiDictionary.instance
      .charactersByGrade()
      .take(characters.length)
      .toList();
  var difference = 0;
  for (var i = 0; i < min(charactersByGrade.length, characters.length); i++) {
    final grade = characters[i].difficulty.grade;
    final refGrade = charactersByGrade[i].difficulty.grade;

    if (grade == null && refGrade == null) continue;
    if (grade == null) {
      difference += 10;
      continue;
    }
    if (refGrade == null) {
      difference += 10;
      continue;
    }

    difference += (grade - refGrade).abs();
  }
  return difference;
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

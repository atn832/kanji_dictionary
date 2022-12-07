import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:kanji_dictionary/kanji_dictionary.dart';

const kanjiCount = 1000;
// Books to index.
const books = Book.values;
// const books = [
//   Book.henshall3,
//   Book.crowley,
//   Book.halpern_kkld_2ed,
//   Book.nelson_n
// ];

main() {
  Map<Book, int> gradeDifference = Map.fromEntries([
    for (final index in books)
      MapEntry(
          index,
          computeGradeDifference(KanjiDictionary.instance
              .charactersByBookOrder(index)
              .take(kanjiCount)
              .toList()))
  ]);

  SplayTreeSet<Book> sortedIndexes = SplayTreeSet.from(books, (i1, i2) {
    final diff = gradeDifference[i1]!.compareTo(gradeDifference[i2]!);
    return diff != 0 ? diff : i1.bookName.compareTo(i2.bookName);
  });

  List<List<String>> matrix = [
    [
      for (final index in sortedIndexes)
        '${index.bookName} ${gradeDifference[index]}'
    ]
  ];

  Map<Book, List<Character>> indexToCharacters = Map.fromEntries([
    for (final index in sortedIndexes)
      MapEntry(index, KanjiDictionary.instance.charactersByBookOrder(index))
  ]);
  for (int i = 0; i < kanjiCount; i++) {
    matrix.add([
      for (final index in sortedIndexes)
        indexToCharacters[index]!.length > i
            ? '${indexToCharacters[index]![i].literal} (grade ${indexToCharacters[index]![i].difficulty.grade})'
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

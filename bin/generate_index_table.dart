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

Getter bookGetter(Book book) => (Character c) => c.index.indexes[book];

main() async {
  final dictionary = await KanjiDictionary.instance;
  Map<Book, int> gradeDifference = Map.fromEntries([
    for (final book in books)
      MapEntry(book, await computeGradeDifference(dictionary, book))
  ]);

  SplayTreeSet<Book> sortedBooks = SplayTreeSet.from(books, (i1, i2) {
    final diff = gradeDifference[i1]!.compareTo(gradeDifference[i2]!);
    return diff != 0 ? diff : i1.bookName.compareTo(i2.bookName);
  });

  List<List<String>> matrix = [
    [
      for (final book in sortedBooks)
        '${book.bookName} ${gradeDifference[book]}'
    ]
  ];

  Map<Book, List<Character>> bookToCharacters = Map.fromEntries([
    for (final book in sortedBooks)
      MapEntry(book, dictionary.charactersBy([bookGetter(book)]))
  ]);
  for (int i = 0; i < kanjiCount; i++) {
    matrix.add([
      for (final book in sortedBooks)
        bookToCharacters[book]!.length > i
            ? '${bookToCharacters[book]![i].literal} (grade ${bookToCharacters[book]![i].difficulty.grade})'
            : ''
    ]);
  }
  File('table.md').writeAsStringSync(toTable(matrix));
}

Future<int> computeGradeDifference(
    KanjiDictionary dictionary, Book book) async {
  final characters =
      dictionary.charactersBy([bookGetter(book)]).take(kanjiCount).toList();
  final charactersByGrade =
      dictionary.charactersByGrade.take(characters.length).toList();
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

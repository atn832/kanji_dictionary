# Kanji Dictionary

[![pub package](https://img.shields.io/pub/v/kanji_dictionary.svg)](https://pub.dartlang.org/packages/kanji_dictionary)

Dart implementation of KANJIDIC, a popular Kanji dictionary used by <https://jisho.org/>. See <https://www.edrdg.org/wiki/index.php/KANJIDIC_Project>.

## Features

- lists out all the characters of KANJIDIC.
- lists out ordered beginner-friendly list of Kanji.
- meanings per language.
- difficulty by JLPT level and grade.
- index from 21 books.
- can also parse a custom version of KANJIDIC xml.

## Getting started

Add the package as a dependency.

## Usage

### Basic usage

```dart
import 'package:kanji_dictionary/kanji_dictionary.dart';

void main() async {
  final kanjiDictionary = await KanjiDictionary.instance;
  final character = kanjiDictionary.characters.first;
  print(character.literal);
  print(character.getMeanings(Language.english));
  print(character.difficulty.jlpt);
}
```

Prints out:

```
亜
[Asia, rank next, come after, -ous]
1
```

### Listing the 15 easiest Kanji

```dart
import 'package:kanji_dictionary/kanji_dictionary.dart';

void main() async {
  final kanjiDictionary = await KanjiDictionary.instance;
  print(kanjiDictionary.charactersByDifficulty
      .take(15)
      .map((c) => c.literal)
      .join(' '));
}
```

Prints out:

> 一 二 三 四 五 六 七 八 九 十 百 千 日 月 火

### Using your own custom KANJIDIC xml

```dart
import 'dart:io';

main() {
  final xmlKanjidic = File([your own kanjidic2.xml]).readAsStringSync();
  final kanjiDictionary = KanjiDictionary.fromXml(XmlDocument.parse(xmlKanjidic));
}
```

## Contributing

If you want to contribute, you should clone the project, then generate `kanjidic2xml.dart` by running:

```sh
dart bin/generate_kanji_dic2_const.dart
```

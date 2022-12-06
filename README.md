# Kanji Dictionary

[![pub package](https://img.shields.io/pub/v/kanji_dictionary.svg)](https://pub.dartlang.org/packages/kanji_dictionary)

Dart implementation of KANJIDIC, a popular Kanji dictionary used by jisho.org. See <http://www.edrdg.org/wiki/index.php/KANJIDIC_Project>.

## Features

- lists out all the characters of KANJIDIC.
- meanings per language.
- difficulty by jlpt level and grade.
- can also parse a custom version of KANJIDIC xml.

## Getting started

Add the package as a dependency.

## Usage

### Basic usage

```dart
import 'package:kanji_dictionary/kanji_dictionary.dart';

void main() {
  final kanjiDictionary = KanjiDictionary.instance;
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

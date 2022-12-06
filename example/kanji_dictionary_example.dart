import 'package:kanji_dictionary/kanji_dictionary.dart';

void main() {
  final kanjiDictionary = KanjiDictionary.instance;
  final character = kanjiDictionary.characters.first;
  print(character.literal);
  print(character.getMeanings(Language.english));
  print(character.difficulty.jlpt);
}

import 'package:kanji_dictionary/kanji_dictionary.dart';

void main() async {
  final kanjiDictionary = await KanjiDictionary.instance;
  final character = kanjiDictionary.get('亜')!;
  print(character.literal);
  print(character.meanings[Language.english]);
  print(character.readings[Reading.japaneseOnReading]);
  print(character.readings[Reading.japaneseKunReading]);
  print(character.difficulty.jlpt);

  print(kanjiDictionary.charactersByDifficulty
      .take(15)
      .map((c) => c.literal)
      .join(' '));
}

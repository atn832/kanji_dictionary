/// Enum used for retrieving [Readings].
enum Reading {
  pinyin(code: 'pinyin'),
  koreanRomanized(code: 'korean_r'),
  koreanHangul(code: 'korean_h'),
  vietnamese(code: 'vietnam'),
  japaneseOnReading(code: 'ja_on'),
  japaneseKunReading(code: 'ja_kun');

  const Reading({required this.code});

  final String code;

  factory Reading.fromString(String code) =>
      Reading.values.firstWhere((l) => l.code == code);
}

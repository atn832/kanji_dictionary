/// Enum used for retrieving meanings.
enum Language {
  english(code: 'en'),
  french(code: 'fr'),
  spanish(code: 'es'),
  portuguese(code: 'pt');

  const Language({required this.code});

  final String code;

  factory Language.fromString(String code) =>
      Language.values.firstWhere((l) => l.code == code);
}

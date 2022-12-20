/// All the books listed in KANJIDIC except for oneill_names, moro and
/// busy_people because they do not index it as simply the kanji index.
enum Book {
  nelson_c(code: 'nelson_c', bookName: 'Nelson (Classic)'),
  nelson_n(code: 'nelson_n', bookName: 'Nelson (New)'),
  halpern_njecd(code: 'halpern_njecd', bookName: 'NJECD'),
  halpern_kkd(code: 'halpern_kkd', bookName: 'Kodansha Kanji Dictionary'),
  halpern_kkld(code: 'halpern_kkld', bookName: 'Kanji Learners Dictionary'),
  halpern_kkld_2ed(
      code: 'halpern_kkld_2ed', bookName: 'Kanji Learners Dictionary (2nd ed)'),
  heisig(code: 'heisig', bookName: 'Remembering The Kanji'),
  heisig6(code: 'heisig6', bookName: 'Remembering The Kanji (6th ed)'),
  gakken(code: 'gakken', bookName: 'Gakken'),
  // oneill_names(
  //     code: 'oneill_names', bookName: 'O\'Neill\'s Japanese Names'),
  oneill_kk(code: 'oneill_kk', bookName: 'O\'Neill\'s Essential Kanji'),
  henshall(code: 'henshall', bookName: 'Henshall'),
  sh_kk(code: 'sh_kk', bookName: 'Kanji & Kana'),
  sh_kk2(code: 'sh_kk2', bookName: 'Kanji & Kana (2011 ed)'),
  sakade(code: 'sakade', bookName: 'Sakade'),
  jf_cards(code: 'jf_cards', bookName: 'Japanese Kanji Flashcards'),
  henshall3(code: 'henshall3', bookName: 'Henshall Guide'),
  tutt_cards(code: 'tutt_cards', bookName: 'Tuttle Kanji Cards'),
  crowley(code: 'crowley', bookName: 'Crowley'),
  kanji_in_context(code: 'kanji_in_context', bookName: 'Kanji in Context'),
  kodansha_compact(
      code: 'kodansha_compact', bookName: 'Kodansha Compact Kanji Guide'),
  maniette(code: 'maniette', bookName: 'Maniette');

  const Book({required this.code, required this.bookName});

  /// The code in attribute dr_type.
  final String code;
  final String bookName;

  factory Book.fromString(String code) =>
      Book.values.firstWhere((l) => l.code == code);
}

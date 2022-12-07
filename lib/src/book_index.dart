import 'package:xml/xml.dart';

/// All the books listed in KANJIDIC except for oneill_names, moro and
/// busy_people because they do not index it as simply the kanji index.
enum Book {
  nelson_c(code: 'nelson_c', bookName: 'Nelson (Classic) number'),
  nelson_n(code: 'nelson_n', bookName: 'Nelson (New) number'),
  halpern_njecd(code: 'halpern_njecd', bookName: 'NJECD number'),
  halpern_kkd(
      code: 'halpern_kkd', bookName: 'Kodansha Kanji Dictionary number'),
  halpern_kkld(
      code: 'halpern_kkld', bookName: 'Kanji Learners Dictionary number'),
  halpern_kkld_2ed(
      code: 'halpern_kkld_2ed',
      bookName: 'Kanji Learners Dictionary number (2nd ed)'),
  heisig(code: 'heisig', bookName: 'Remembering The Kanji number'),
  heisig6(code: 'heisig6', bookName: 'Remembering The Kanji number (6th ed)'),
  gakken(code: 'gakken', bookName: 'Gakken number'),
  // oneill_names(
  //     code: 'oneill_names', bookName: 'O\'Neill\'s Japanese Names number'),
  oneill_kk(code: 'oneill_kk', bookName: 'O\'Neill\'s Essential Kanji number'),
  henshall(code: 'henshall', bookName: 'Henshall number'),
  sh_kk(code: 'sh_kk', bookName: 'Kanji & Kana number'),
  sh_kk2(code: 'sh_kk2', bookName: 'Kanji & Kana number (2011 ed)'),
  sakade(code: 'sakade', bookName: 'Sakade number'),
  jf_cards(code: 'jf_cards', bookName: 'Japanese Kanji Flashcards number'),
  henshall3(code: 'henshall3', bookName: 'Henshall Guide number'),
  tutt_cards(code: 'tutt_cards', bookName: 'Tuttle Kanji Cards number'),
  crowley(code: 'crowley', bookName: 'Crowley number'),
  kanji_in_context(
      code: 'kanji_in_context', bookName: 'Kanji in Context number'),
  kodansha_compact(
      code: 'kodansha_compact',
      bookName: 'Kodansha Compact Kanji Guide number'),
  maniette(code: 'maniette', bookName: 'Maniette number');

  const Book({required this.code, required this.bookName});

  /// The code in attribute dr_type.
  final String code;
  final String bookName;
}

class BookIndex {
  final Map<Book, int> indexes;

  BookIndex({required this.indexes});

  factory BookIndex.fromXml(XmlElement? el) {
    if (el == null) return BookIndex(indexes: {});
    return BookIndex(indexes: {
      for (final index in Book.values)
        if (getIndex(el, index) != null) index: getIndex(el, index)!
    });
  }
}

int? getIndex(XmlElement el, Book index) {
  XmlNode? indexNode;
  try {
    indexNode =
        el.children.firstWhere((c) => c.getAttribute('dr_type') == index.code);
  } catch (e) {
    indexNode = null;
  }
  return indexNode != null ? int.parse(
      // Work around weird nelson_n number '1664 3689' for kanji 瓣.
      indexNode.text.split(' ').first) : null;
}

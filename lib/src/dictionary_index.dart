import 'package:xml/xml.dart';

/// These values must match the dr_type attribute in KANJIDIC.
enum Indexes {
  halpern_kkld_2ed,
  heisig6,
  henshall3,
  tutt_cards,
  maniette,
  kodansha_compact,
  kanji_in_context,
  crowley,
  jf_cards,
  sakade,
  sh_kk2,
  oneill_kk,
  gakken,
  nelson_n
}

class DictionaryIndex {
  final Map<Indexes, int> indexes;

  DictionaryIndex({required this.indexes});

  factory DictionaryIndex.fromXml(XmlElement? el) {
    if (el == null) return DictionaryIndex(indexes: {});
    return DictionaryIndex(indexes: {
      for (final index in Indexes.values)
        if (getIndex(el, index) != null) index: getIndex(el, index)!
    });
  }
}

int? getIndex(XmlElement el, Indexes index) {
  XmlNode? indexNode;
  try {
    indexNode =
        el.children.firstWhere((c) => c.getAttribute('dr_type') == index.name);
  } catch (e) {
    indexNode = null;
  }
  return indexNode != null ? int.parse(
      // Work around weird nelson_n number '1664 3689'.
      indexNode.text.split(' ').first) : null;
}

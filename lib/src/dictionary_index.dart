import 'package:xml/xml.dart';

/// These values must match the dr_type attribute in KANJIDIC.
enum Indexes { halpern_kkld_2ed, heisig6, henshall }

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
  return indexNode != null ? int.parse(indexNode.text) : null;
}

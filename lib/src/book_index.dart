import 'package:xml/xml.dart';

import 'book.dart';

/// Contains the index at which characters appear in Books.
class BookIndex {
  final Map<Book, int> indexes;

  BookIndex({required this.indexes});

  factory BookIndex.fromXml(XmlElement? el) {
    if (el == null) return BookIndex(indexes: {});
    return BookIndex(indexes: {
      for (final index in Book.values)
        if (_getIndex(el, index) != null) index: _getIndex(el, index)!
    });
  }
}

int? _getIndex(XmlElement el, Book index) {
  XmlNode? indexNode;
  try {
    indexNode =
        el.children.firstWhere((c) => c.getAttribute('dr_type') == index.code);
  } catch (e) {
    indexNode = null;
  }
  return indexNode != null ? int.parse(indexNode.text) : null;
}

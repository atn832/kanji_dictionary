import 'package:xml/xml.dart';

import 'book.dart';

/// Contains the index at which characters appear in Books.
class BookIndex {
  final Map<Book, int> indexes;

  BookIndex({required this.indexes});

  factory BookIndex.fromXml(XmlElement? el) {
    if (el == null) return BookIndex(indexes: {});
    Map<Book, int> indexes = {};
    for (final c in el.findElements('dic_ref')) {
      try {
        final b = Book.fromString(c.getAttribute('dr_type')!);
        indexes[b] = int.parse(c.text);
      } catch (_) {
        // We intentionally skip some books like oneill_names.
      }
    }
    return BookIndex(indexes: indexes);
  }
}

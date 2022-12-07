import 'package:kanji_dictionary/kanji_dictionary.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

String xmlCharacter = '''<!-- Entry for Kanji: 亜 -->
<character>
  <literal>亜</literal>
  <codepoint>
    <cp_value cp_type="ucs">4e9c</cp_value>
    <cp_value cp_type="jis208">1-16-01</cp_value>
  </codepoint>
  <radical>
    <rad_value rad_type="classical">7</rad_value>
    <rad_value rad_type="nelson_c">1</rad_value>
  </radical>
  <misc>
    <grade>8</grade>
    <stroke_count>7</stroke_count>
    <variant var_type="jis208">1-48-19</variant>
    <freq>1509</freq>
    <jlpt>1</jlpt>
  </misc>
  <dic_number>
    <dic_ref dr_type="nelson_c">43</dic_ref>
    <dic_ref dr_type="nelson_n">81</dic_ref>
    <dic_ref dr_type="halpern_njecd">3540</dic_ref>
    <dic_ref dr_type="halpern_kkd">4354</dic_ref>
    <dic_ref dr_type="halpern_kkld">2204</dic_ref>
    <dic_ref dr_type="halpern_kkld_2ed">2966</dic_ref>
    <dic_ref dr_type="heisig">1809</dic_ref>
    <dic_ref dr_type="heisig6">1950</dic_ref>
    <dic_ref dr_type="gakken">1331</dic_ref>
    <dic_ref dr_type="oneill_names">525</dic_ref>
    <dic_ref dr_type="oneill_kk">1788</dic_ref>
    <dic_ref dr_type="moro" m_vol="1" m_page="0525">272</dic_ref>
    <dic_ref dr_type="henshall">997</dic_ref>
    <dic_ref dr_type="sh_kk">1616</dic_ref>
    <dic_ref dr_type="sh_kk2">1724</dic_ref>
    <dic_ref dr_type="jf_cards">1032</dic_ref>
    <dic_ref dr_type="tutt_cards">1092</dic_ref>
    <dic_ref dr_type="kanji_in_context">1818</dic_ref>
    <dic_ref dr_type="kodansha_compact">35</dic_ref>
    <dic_ref dr_type="maniette">1827</dic_ref>
  </dic_number>
  <query_code>
    <q_code qc_type="skip">4-7-1</q_code>
    <q_code qc_type="sh_desc">0a7.14</q_code>
    <q_code qc_type="four_corner">1010.6</q_code>
    <q_code qc_type="deroo">3273</q_code>
  </query_code>
  <reading_meaning>
    <rmgroup>
      <reading r_type="pinyin">ya4</reading>
      <reading r_type="korean_r">a</reading>
      <reading r_type="korean_h">아</reading>
      <reading r_type="vietnam">A</reading>
      <reading r_type="vietnam">Á</reading>
      <reading r_type="ja_on">ア</reading>
      <reading r_type="ja_kun">つ.ぐ</reading>
      <meaning>Asia</meaning>
      <meaning>rank next</meaning>
      <meaning>come after</meaning>
      <meaning>-ous</meaning>
      <meaning m_lang="fr">Asie</meaning>
      <meaning m_lang="fr">suivant</meaning>
      <meaning m_lang="fr">sub-</meaning>
      <meaning m_lang="fr">sous-</meaning>
      <meaning m_lang="es">pref. para indicar</meaning>
      <meaning m_lang="es">venir después de</meaning>
      <meaning m_lang="es">Asia</meaning>
      <meaning m_lang="pt">Ásia</meaning>
      <meaning m_lang="pt">próxima</meaning>
      <meaning m_lang="pt">o que vem depois</meaning>
      <meaning m_lang="pt">-ous</meaning>
    </rmgroup>
    <nanori>や</nanori>
    <nanori>つぎ</nanori>
    <nanori>つぐ</nanori>
  </reading_meaning>
</character>''';

String xmlKanjidic = '''<kanjidic2>
<header>
<!-- kanji_dictionary 2 - XML format kanji database combining the kanji_dictionary
	and KANJD212 files plus the kanji from JIS X 0213.
-->
<file_version>4</file_version>
<database_version>2022-339</database_version>
<date_of_creation>2022-12-05</date_of_creation>
</header>
$xmlCharacter
</kanjidic2>
''';

void main() {
  group('KanjiDictionary', () {
    test('fromXml', () {
      final kanjiDictionary =
          KanjiDictionary.fromXml(XmlDocument.parse(xmlKanjidic));
      expect(kanjiDictionary.fileVersion, 4);
      expect(kanjiDictionary.creationTime, DateTime(2022, 12, 5));
      expect(kanjiDictionary.characters.length, 1);
    });

    test('the list of characters is protected', () {
      final c = KanjiDictionary.instance.characters;
      c.clear();
      expect(c, isEmpty);
      expect(KanjiDictionary.instance.characters, isNotEmpty);
    });

    test('instance', () {
      expect(KanjiDictionary.instance.fileVersion, 4);
    });
  });

  group('Deserialization', () {
    late Character character;

    setUp(() {
      final el = XmlDocument.parse(xmlCharacter).rootElement;
      character = Character.fromXml(el);
    });

    test('xml', () {
      expect(character.literal, '亜');
      expect(character.difficulty.jlpt, 1);
      expect(character.difficulty.grade, 8);
      final meanings = character.meanings;
      expect(meanings.length, 15);
      expect(meanings.first.meaning, 'Asia');
      expect(meanings.first.language, Language.english);
      expect(meanings[4].meaning, 'Asie');
      expect(meanings[4].language, Language.french);
    });

    test('getMeanings', () {
      expect(character.getMeanings(Language.english),
          ['Asia', 'rank next', 'come after', '-ous']);
      expect(character.getMeanings(Language.french),
          ['Asie', 'suivant', 'sub-', 'sous-']);
    });

    test('dictionary index', () {
      expect(character.index.indexes[Book.halpern_kkld_2ed], 2966);
      expect(character.index.indexes[Book.heisig6], 1950);
      expect(character.index.indexes[Book.nelson_c], 43);
    });

    test('sorting', () {
      final heisig6 = KanjiDictionary.instance
          .charactersByBookOrder(Book.heisig6)
          .take(5)
          .map(toLiteral)
          .toList();
      final halpernKanjiLearners = KanjiDictionary.instance
          .charactersByBookOrder(Book.halpern_kkld_2ed)
          .take(5)
          .map(toLiteral)
          .toList();
      final nelsonC = KanjiDictionary.instance
          .charactersByBookOrder(Book.nelson_c)
          .take(5)
          .map(toLiteral)
          .toList();
      expect(heisig6, ['一', '二', '三', '四', '五']);
      expect(halpernKanjiLearners, ['川', '小', '水', '心', '旧']);
      expect(nelsonC, ['一', '丁', '兀', '于', '与']);
    });

    test('advanced sorting', () {
      getNegativeJlpt(Character c) =>
          c.difficulty.jlpt != null ? -c.difficulty.jlpt! : null;
      getHenshallIndex(Character c) => c.index.indexes[Book.henshall3];

      // Sort by decreasing JLPT level and increasing Henshall3 index.
      final sorted = KanjiDictionary.instance
          .charactersBy([getNegativeJlpt, getHenshallIndex]);

      final sortedJlpt = sorted.map((c) => c.difficulty.jlpt).toList();
      // Make a copy.
      final forceSortedJlpt = sortedJlpt.toList();
      // Sort in decreasing values of JLPT.
      forceSortedJlpt.sort((a, b) => -a!.compareTo(b!));
      // JLPT levels should go from 4 to 1.
      expect(sortedJlpt, forceSortedJlpt);

      final jlptValues = Set<int>.from(sortedJlpt);
      // Check that the Henshall order is respected within the same JLPT value.
      for (final jlpt in jlptValues) {
        final sortedHenshall = sorted
            .where((c) => c.difficulty.jlpt == jlpt)
            .map(getHenshallIndex)
            // It is possible for Henshall indexes to be missing.
            .where((element) => element != null)
            .toList();
        // Make a copy.
        final forceSortedHenshall = sortedHenshall.toList();
        // Sort in increasing indexes of Henshall.
        forceSortedHenshall.sort();
        expect(sortedHenshall, forceSortedHenshall);
      }
    });
  });
}

String toLiteral(Character c) => c.literal;

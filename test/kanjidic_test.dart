import 'dart:convert';

import 'package:kanjidic/kanjidic.dart';
import 'package:test/test.dart';

String jsonCharacter = '''{
  "literal": "亜",
  "codepoint": {
    "cp_value": [
      {
        "_cp_type": "ucs",
        "value": "4e9c"
      },
      {
        "_cp_type": "jis208",
        "value": "1-16-01"
      }
    ]
  },
  "radical": {
    "rad_value": [
      {
        "_rad_type": "classical",
        "value": "7"
      },
      {
        "_rad_type": "nelson_c",
        "value": "1"
      }
    ]
  },
  "misc": {
    "grade": "8",
    "stroke_count": "7",
    "variant": {
      "_var_type": "jis208",
      "value": "1-48-19"
    },
    "freq": "1509",
    "jlpt": "1"
  },
  "dic_number": {
    "dic_ref": [
      {
        "_dr_type": "nelson_c",
        "value": "43"
      },
      {
        "_dr_type": "nelson_n",
        "value": "81"
      },
      {
        "_dr_type": "halpern_njecd",
        "value": "3540"
      },
      {
        "_dr_type": "halpern_kkd",
        "value": "4354"
      },
      {
        "_dr_type": "halpern_kkld",
        "value": "2204"
      },
      {
        "_dr_type": "halpern_kkld_2ed",
        "value": "2966"
      },
      {
        "_dr_type": "heisig",
        "value": "1809"
      },
      {
        "_dr_type": "heisig6",
        "value": "1950"
      },
      {
        "_dr_type": "gakken",
        "value": "1331"
      },
      {
        "_dr_type": "oneill_names",
        "value": "525"
      },
      {
        "_dr_type": "oneill_kk",
        "value": "1788"
      },
      {
        "_dr_type": "moro",
        "_m_vol": "1",
        "_m_page": "0525",
        "value": "272"
      },
      {
        "_dr_type": "henshall",
        "value": "997"
      },
      {
        "_dr_type": "sh_kk",
        "value": "1616"
      },
      {
        "_dr_type": "sh_kk2",
        "value": "1724"
      },
      {
        "_dr_type": "jf_cards",
        "value": "1032"
      },
      {
        "_dr_type": "tutt_cards",
        "value": "1092"
      },
      {
        "_dr_type": "kanji_in_context",
        "value": "1818"
      },
      {
        "_dr_type": "kodansha_compact",
        "value": "35"
      },
      {
        "_dr_type": "maniette",
        "value": "1827"
      }
    ]
  },
  "query_code": {
    "q_code": [
      {
        "_qc_type": "skip",
        "value": "4-7-1"
      },
      {
        "_qc_type": "sh_desc",
        "value": "0a7.14"
      },
      {
        "_qc_type": "four_corner",
        "value": "1010.6"
      },
      {
        "_qc_type": "deroo",
        "value": "3273"
      }
    ]
  },
  "reading_meaning": {
    "rmgroup": {
      "reading": [
        {
          "_r_type": "pinyin",
          "value": "ya4"
        },
        {
          "_r_type": "korean_r",
          "value": "a"
        },
        {
          "_r_type": "korean_h",
          "value": "아"
        },
        {
          "_r_type": "vietnam",
          "value": "A"
        },
        {
          "_r_type": "vietnam",
          "value": "Á"
        },
        {
          "_r_type": "ja_on",
          "value": "ア"
        },
        {
          "_r_type": "ja_kun",
          "value": "つ.ぐ"
        }
      ],
      "meaning": [
        "Asia",
        "rank next",
        "come after",
        "-ous",
        {
          "_m_lang": "fr",
          "value": "Asie"
        },
        {
          "_m_lang": "fr",
          "value": "suivant"
        },
        {
          "_m_lang": "fr",
          "value": "sub-"
        },
        {
          "_m_lang": "fr",
          "value": "sous-"
        },
        {
          "_m_lang": "es",
          "value": "pref. para indicar"
        },
        {
          "_m_lang": "es",
          "value": "venir después de"
        },
        {
          "_m_lang": "es",
          "value": "Asia"
        },
        {
          "_m_lang": "pt",
          "value": "Ásia"
        },
        {
          "_m_lang": "pt",
          "value": "próxima"
        },
        {
          "_m_lang": "pt",
          "value": "o que vem depois"
        },
        {
          "_m_lang": "pt",
          "value": "-ous"
        }
      ]
    },
    "nanori": [
      "や",
      "つぎ",
      "つぐ"
    ]
  }
}''';

void main() {
  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });

  group('Deserialization', () {
    test('Character', () {
      final character = Character.fromJson(jsonDecode(jsonCharacter));
      expect(character.literal, '亜');
      expect(character.misc.jlpt, '1');
      expect(character.misc.grade, '8');
      expect(character.readingMeaning.nanori, ["や", "つぎ", "つぐ"]);
    });
  });
}

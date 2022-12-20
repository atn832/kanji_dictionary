## 1.0.5

- Implemented `KanjiDictionary.get(literal)`.
- Updated the embedded dictionary to version 2022-354 (2022-12-20).

## 1.0.4

- Expose `readings`.
- Breaking changes to match the `readings` getter:
  - Instead of `character.getMeanings(Language.english)`, use `character.meanings[Language.english]`.
  - Instead of `character.index.indexes`, use `character.indexes`.
- Updated the embedded dictionary to version 2022-353 (2022-12-19).
- Optimized initialization. Divides load time by 3.

## 1.0.3

Prevent a race condition when initializing singleton instance.

## 1.0.2

Load data in an isolate to prevent blocking UIs.

## 1.0.1+2

Cleaned up some docs.

## 1.0.1

- Implemented `charactersByDifficulty`, `charactersByGrade`, and a custom `sort` function in `KanjiDictionary`.
- Included the index from 21 books.

## 1.0.0+1

Exposed some extra documentation.

## 1.0.0

Initial version.

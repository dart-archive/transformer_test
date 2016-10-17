# Changelog

## 0.2.2

- Bump maximum version allowed for code_transformers. The breaking change in
  version 0.5.0 has no impact here.

## 0.2.1

- Widened type of `phases` parameter of `testPhases` function, which allows
  to use it to test aggregate transformers and transformer groups.

## 0.2.0

- Changed all optional arguments to `testPhases` to named arguments.
- Added `skip` and `tags` named arguments to `testPhases`, which will be
  forwarded on to the call to `test`.
- `messages` optional argument to `testPhases` now accepts either `Matcher`s or
  `String`s.
- Added `expectBarbackErrors` optional argument to `testPhases`.

## 0.1.0

- Initial version

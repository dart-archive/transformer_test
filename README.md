# transformer_test

A library which provides some tools for testing `Transformers`.

## Features

This library provides a top level function `testPhases` which given a nested
list of transformers to run and a list of inputs, will verify a list of expected
outputs.

For example, given a transformer which copies all files to corresponding
`*.copy` files, you could write the following test:

```
testPhases(
  [[new CopyTransformer()]],
  {
    'a|lib/a.dart': 'hello!'
  }, {
    'a|lib/a.dart': 'hello!'
    'a|lib/a.dart.copy': 'hello!'
  });
```

## Issues

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dart-lang/transformer_test/issues

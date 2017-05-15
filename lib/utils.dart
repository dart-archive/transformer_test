// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Collection of utilities which are useful for creating unit tests for
/// Barback transformers.
library transformer_test;

import 'dart:async' show Future;
import 'dart:io' show Platform;

import 'package:code_transformers/resolver.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'src/test_harness.dart';

export 'src/test_harness.dart' show StringFormatter;

/// Defines a test which invokes [applyTransformers].
testPhases(String testName, List<List> phases,
    Map<String, String> inputs, Map<String, String> results,
    {List messages: const [],
    StringFormatter formatter: StringFormatter.noTrailingWhitespace,
    skip,
    tags,
    bool expectBarbackErrors: false}) {
  test(
      testName,
      () => applyTransformers(phases,
          inputs: inputs,
          results: results,
          messages: messages,
          formatter: formatter,
          expectBarbackErrors: expectBarbackErrors),
      skip: skip,
      tags: tags);
}

/// Updates the provided transformers with [inputs] as asset inputs then
/// validates that [results] were generated.
///
/// The keys for inputs and results are 'package_name|lib/file.dart'.
/// Only files which are specified in results are validated.
///
/// If [messages] is non-null then this will validate that only the specified
/// messages were generated, ignoring info messages.
Future applyTransformers(List<List> phases,
    {Map<String, String> inputs: const {},
    Map<String, String> results: const {},
    List messages: const [],
    StringFormatter formatter: StringFormatter.noTrailingWhitespace,
    bool expectBarbackErrors: false}) {
  var helper = new TestHelper(phases, inputs, messages,
      formatter: formatter, expectBarbackErrors: expectBarbackErrors)..run();
  return helper.checkAll(results).then((_) => helper.tearDown());
}

/// Variant of [dartSdkDirectory] which includes additional cases only
/// typically encountered in Dart's testing environment.
String get testingDartSdkDirectory {
  var sdkDir = dartSdkDirectory;
  if (sdkDir == null) {
    // If we cannot find the SDK dir, then assume this is being run from Dart's
    // source directory and this script is the main script.
    var segments = path.split(path.fromUri(Platform.script));
    var index = segments.indexOf('pkg');
    expect(index, greaterThan(0),
        reason: 'testingDartSdkDirectory is only supported in pkg/ tests');
    sdkDir = path.joinAll(segments.sublist(0, index)..add('sdk'));
  }
  return sdkDir;
}

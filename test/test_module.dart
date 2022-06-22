import 'package:constructor/src/core/modules/constructor_module.dart';
import 'package:flutter/material.dart';

class TestModule extends ConstructorModule {
  final String testValue;

  TestModule(this.testValue);

  static const int testNumberResult = 34;

  @override
  dynamic handleMethods(String method, args) {
    switch (method) {
      case 'testPrint':
        print('test print');
        break;
      case 'testNumber':
        return testNumberResult;
    }
  }

  @override
  String get name => 'test_module';

  @override
  dynamic getArgument(String argumentName) {
    switch (argumentName) {
      case 'name':
        return name;
      case 'testValue':
        return testValue;
      default:
        throw UnsupportedError('field $argumentName not found');
    }
  }
}

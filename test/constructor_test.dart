import 'package:flutter_test/flutter_test.dart';
import 'package:constructor/constructor.dart';

import 'second_test_module.dart';
import 'test_module.dart';

const expiredValue = 'test_expired_value';

void main() {
  group('Test modules', () {
    test('Init modules', initModules);
    test('Register module', registerModule);
    group('Modules validate', modulesValidate);
    test('Invoke method', invokeMethod);
    test('Get value from module', getValueFromModule);
    test('Remove modules', removeModules);
  });
}

void initModules() {
  Modules.add(DefaultModule());
  expect(Modules.has('default'), true);
}

void registerModule() {
  Modules.add(TestModule(expiredValue));
  expect(Modules.has('test_module'), true);
}

void modulesValidate() {
  test('Success case', (){
    final valid = Modules.validate(['test_module'], null);
    expect(valid, ModulesValidationResult.valid);
  });
  test('Error case', (){
    final valid = Modules.validate(['second_test_module'], null);
    expect(valid, ModulesValidationResult.invalid);
  });
  test('Only important case', (){
    final valid = Modules.validate(['test_module'], ['second_test_module']);
    expect(valid, ModulesValidationResult.onlyImportant);
  });
}

void invokeMethod() {
  Modules.invokeMethod('test_module.testPrint');
  final number = Modules.invokeMethod('test_module.testNumber');
  expect(number, TestModule.testNumberResult);
}

void getValueFromModule() {
  Modules.add(SecondTestModule());
  final testValue = Modules.invokeMethod(
      'second_test_module.getTestValue',
    dependentArguments: ['test_module.testValue']
  );
  expect(testValue, expiredValue);
}

void removeModules() {
  Modules.remove('test_module');
  Modules.remove('second_test_module');

  final removedFirst = !Modules.has('test_module');
  final removedSecond = !Modules.has('second_test_module');

  expect((removedFirst && removedSecond), true);
}
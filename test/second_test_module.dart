import 'package:constructor/constructor.dart';

class SecondTestModule extends ConstructorModule {
  @override
  getArgument(String argumentName) {}

  @override
  handleMethods(String method, args) {
    switch(method) {
      case 'getTestValue':
        final value = args['test_module.testValue'];
        return value;
      default:
        throw UnimplementedError();
    }
  }

  @override
  String get name => 'second_test_module';

}
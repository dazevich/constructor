import 'package:constructor/src/core/modules/constructor_module.dart';

class DefaultModule extends ConstructorModule {
  @override
  String get name => 'default';

  @override
  handleMethods(String method, args) {
    switch(method) {
      case 'printTime':
        print(args);
        break;
      default:
        throw UnimplementedError('$method not found in [$name]');
    }
  }

  @override
  dynamic getArgument(String argumentName) {
    switch(argumentName) {
      case 'name':
        return name;
      default:
        throw UnsupportedError('this field $argumentName not found');
    }
  }
}
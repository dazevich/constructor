import 'package:constructor/constructor.dart';

abstract class ConstructorModule {
  abstract final String name;
  dynamic handleMethods(String method, dynamic args);
  dynamic getArgument(String argumentName);
}
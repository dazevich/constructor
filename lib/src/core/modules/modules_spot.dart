import 'package:constructor/constructor.dart';
import 'package:logger/logger.dart';
import 'constructor_module.dart';

enum ModulesValidationResult {
  valid,
  onlyImportant,
  invalid,
}

class Modules {
  static bool _isInit = false;

  static void _init() {
    _isInit = true;
    Logger(printer: PrettyPrinter(methodCount: 0)).i(
        'Welcome to constructor. For more information see https://google.com'
    );
  }

  static final _logger = Logger(
      level: Level.debug,
      printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true));

  static void _info(dynamic message) => _logger.d('[Modules] $message');

  static void _error(dynamic message) => _logger.e('[Modules] $message');

  static void _warning(dynamic message) => _logger.w('[Modules] $message');

  static final Map<String, ConstructorModule> _modules = {};

  static ModulesValidationResult validate(
      List<String> importantModules, List<String>? optionalModules) {
    bool allOptional = true;
    for (final module in importantModules) {
      if (!_modules.containsKey(module)) {
        _error('Module $module not registered');
        return ModulesValidationResult.invalid;
      }
    }
    if (optionalModules != null) {
      for (final module in optionalModules) {
        if (!_modules.containsKey(module)) {
          _warning('Module $module not registered');
          return ModulesValidationResult.onlyImportant;
        }
      }
    }
    return ModulesValidationResult.valid;
  }

  static void add(ConstructorModule module) {
    if (module is DefaultModule) {
      _init();
      _modules[module.name] = module;
    } else {
      if (!_isInit) {
        throw Exception('Default module not init');
      }
      _info('register ${module.name}');
      _modules[module.name] = module;
    }
  }

  static void remove(String moduleName) {
    if (!_isInit) {
      throw Exception('Default module not init');
    }
    _warning('remove $moduleName');
    _modules.remove(moduleName);
  }

  static bool has(String name) => _modules[name] != null;

  static dynamic invokeMethod(String method,
      {dynamic arguments, List<String>? dependentArguments}) {
    if (!_isInit) {
      throw Exception('Default module not init');
    }
    final callRequest = method.split('.');
    if (callRequest.isEmpty || callRequest.length > 2) {
      throw Exception('bad method');
    }
    late final ConstructorModule module;
    late final String methodName;
    Map<String, dynamic> methodArguments = {};
    if (callRequest.length == 2) {
      if (!has(callRequest.first)) {
        throw Exception('module ${callRequest.first} not fount');
      }
      module = _modules[callRequest.first]!;
      methodName = callRequest.last;
    } else {
      module = _modules['default']!;
      methodName = callRequest.first;
    }
    if (arguments != null) {
      methodArguments['arguments'] = arguments;
    }
    if (dependentArguments != null) {
      for (final argument in dependentArguments) {
        final module = argument.split(".").first;
        final field = argument.split(".").last;
        if (!has(module)) {
          throw Exception('module ${callRequest.first} not fount');
        }
        methodArguments[argument] = _modules[module]!.getArgument(field);
      }
    }
    _info('[${module.name}] $methodName($methodArguments)');
    return module.handleMethods(methodName, methodArguments);
  }
}

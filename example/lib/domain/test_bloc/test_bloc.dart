import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:constructor/constructor.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> with ConstructorModule{
  TestBloc() : super(const TestState(0)) {
    on<TestEvent>((event, emit) {
      emit(state.copy(event.term));
    });

    Modules.add(this);
  }

  @override
  handleMethods(String method, args) {
    switch(method) {
      case 'increment':
        add(const TestEvent(1));
        break;
      case 'decrement':
        add(const TestEvent(-1));
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  String get name => 'test_bloc';

  @override
  dynamic getArgument(String argumentName) {
    // TODO: implement getArguments
    throw UnimplementedError();
  }
}

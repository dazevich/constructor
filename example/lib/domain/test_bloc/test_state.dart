part of 'test_bloc.dart';

@immutable
class TestState {
  final int count;
  const TestState(this.count);

  TestState copy(int term) => TestState(count + term);
}

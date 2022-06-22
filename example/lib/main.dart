import 'package:example/domain/test_bloc/test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:constructor/constructor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // init modules
  Modules.add(DefaultModule());

  runApp(MaterialApp(
      home: BlocProvider(
    create: (context) => TestBloc(),
    lazy: false,
    child: const App(),
  )));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<TestBloc, TestState>(builder: (context, state) {
              return Text(state.count.toString());
            }),
            ElevatedButton(
                onPressed: () => Modules.invokeMethod('test_bloc.increment'),
                child: const Text('call method increment')),
            ElevatedButton(
                onPressed: () => Modules.invokeMethod('test_bloc.decrement'),
                child: const Text('call method decrement')),
            ElevatedButton(
                onPressed: () => Modules.invokeMethod('printTime',
                    dependentArguments: ['test_bloc.count']),
                child: const Text('call method printTime')),
          ],
        ),
      ),
    );
  }
}

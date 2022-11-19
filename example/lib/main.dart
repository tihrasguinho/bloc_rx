import 'dart:developer';

import 'package:bloc_rx/bloc_rx.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Events

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}

// BLOC

class CounterBloc extends BlocRX<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventsToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield state + 1;
    } else if (event is DecrementEvent) {
      yield state - 1;
    } else if (event is ResetEvent) {
      yield 0;
    }
  }
}

class Contador extends BlocRX<CounterEvent, int> {
  Contador() : super(0);

  @override
  Stream<int> mapEventsToState(CounterEvent event) async* {}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = CounterBloc();

  @override
  void initState() {
    super.initState();
    // bloc.add(ResetEvent());
    bloc.stream.listen((event) {});
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Building screen...');

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocOBS<int>(
              bloc: bloc,
              builder: (context, state) {
                return Text(
                  '$state',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(IncrementEvent()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

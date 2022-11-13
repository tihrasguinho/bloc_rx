import 'package:bloc_rx/bloc_rx.dart';
import 'package:flutter_test/flutter_test.dart';

// Events

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}

// BLoC

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

// Test

void main() {
  late CounterBloc bloc;

  setUp(() {
    bloc = CounterBloc();
  });

  test('Expect returns 1 and 0 respectively', () async* {
    expectLater(bloc.stream, emitsInOrder([1, 0]));

    bloc.add(IncrementEvent());
    bloc.add(ResetEvent());
  });

  tearDown(() {
    bloc.dispose();
  });
}

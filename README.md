Uma simples implementação do Bloc com rxdart!

Utilização:

 - Criar os eventos

```dart
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}
```

 - Criar o BLoC (como estado pode ser criada uma classe abstrata igual o exemplo dos eventos ou pode ser utilizado tipos primitivos, neste exemplo estou utilizando o Int como estado)

```dart
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
```

 - E para escutar os eventos na view, basta utilizar o widget BlocOBS com a possibilidade de tipar o tipo de estado que se espera!

```dart
BlocOBS<int>(
  bloc: bloc,
  builder: (context, state, child) {
    return Text('$state');
  },
),
```

Fim!

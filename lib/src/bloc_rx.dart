// ignore_for_file: depend_on_referenced_packages

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// [E] Events and [S] States
abstract class BlocRX<E extends Object?, S extends Object?> {
  late BehaviorSubject<E> _controller;

  late S _state;

  /// Current state of BLoC!
  S get state => _state;

  /// Stream that provides the output of BLoC!
  Stream<S> get stream => _controller.stream
      .debounceTime(const Duration(milliseconds: 500))
      .switchMap(mapEventsToState);

  BlocRX(S initialState) {
    _state = initialState;
    _controller = BehaviorSubject<E>();

    // Listen to new states and store it
    stream.listen((newState) => _state = newState);
  }

  /// Switch each event to a state!
  @protected
  @internal
  Stream<S> mapEventsToState(E event);

  /// Add events to BLoC!
  void add(E event) => _controller.sink.add(event);

  /// Close the current BLoC controller!
  void dispose() {
    _controller.close();
  }
}

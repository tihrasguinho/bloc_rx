import 'package:flutter/widgets.dart';

import 'bloc_rx.dart';

// BLOC BUILDER

typedef BlocBuilder<S> = Widget Function(BuildContext context, S state, Widget? child);

// IMPLEMENTATION

class BlocOBS<S> extends BlocOBSWidget {
  const BlocOBS({
    Key? key,
    required BlocRX bloc,
    required this.builder,
    this.child,
  }) : super(key: key, bloc: bloc);

  final BlocBuilder<S> builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) => builder(context, bloc.state as S, child);
}

// INTERFACE

abstract class BlocOBSWidget extends StatefulWidget {
  const BlocOBSWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final BlocRX bloc;

  @protected
  Widget build(BuildContext context);

  @override
  State<StatefulWidget> createState() => _BlocOBSWidget();
}

class _BlocOBSWidget extends State<BlocOBSWidget> {
  void _handleChanges() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.bloc.stream.listen((_) => _handleChanges());
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}

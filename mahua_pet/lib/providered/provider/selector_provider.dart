import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorProvider<A extends ChangeNotifier, S> extends StatefulWidget {

  final A model;
  final Widget child;
  final bool autoDispose;
  final Function(A model) onModelReady;
  final ValueWidgetBuilder<S> builder;
  final S Function(BuildContext, A) selector;

  SelectorProvider({
    Key key,
    @required this.model,
    @required this.builder,
    this.selector,
    this.child,
    this.onModelReady,
    this.autoDispose,
  }): super(key: key);

  @override
  _SelectorProviderState<A> createState() => _SelectorProviderState<A>();
}

class _SelectorProviderState<A extends ChangeNotifier> extends State<SelectorProvider<A, A>> {

  A model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);

    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<A>.value(
      value: model,
      child: Selector<A, A>(
        builder: widget.builder, 
        selector: widget.selector,
        child: widget.child,
      ),
    );
  }
}


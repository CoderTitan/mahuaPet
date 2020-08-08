
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerProvider<T extends ChangeNotifier> extends StatefulWidget {

  final T model;
  final Widget child;
  final bool autoDispose;
  final ValueWidgetBuilder<T> builder;
  final Function(T model) onModelReady;

  ConsumerProvider({
    Key key,
    @required this.model,
    @required this.builder,
    this.child,
    this.onModelReady,
    this.autoDispose = true,
  }) : super(key: key);

  @override
  _ConsumerProviderState<T> createState() => _ConsumerProviderState<T>();
}

class _ConsumerProviderState<T extends ChangeNotifier> extends State<ConsumerProvider<T>> {

  T model;

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
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}


class ConsumerProvider2<A extends ChangeNotifier, B extends ChangeNotifier> extends StatefulWidget {

  final A model1;
  final B model2;
  final Widget child;
  final bool autoDispose;
  final Function(A model1, B model2) onModelReady;
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;

  ConsumerProvider2({
    Key key,
    @required this.model1,
    @required this.model2,
    @required this.builder,
    this.child,
    this.autoDispose = true,
    this.onModelReady,
  }): super(key: key);

  @override
  _ConsumerProviderState2<A, B> createState() => _ConsumerProviderState2<A, B>();
}

class _ConsumerProviderState2<A extends ChangeNotifier, B extends ChangeNotifier> extends State<ConsumerProvider2<A, B>> {

  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);

    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      child: Consumer2(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
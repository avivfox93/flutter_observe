
import 'package:flutter/material.dart';

import 'observable.dart';

class ObservableBuilder<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final Observable<T> observable;
  const ObservableBuilder({
    Key key,
    @required this.builder,
    @required this.observable,
  }) : super(key: key);

  @override
  _ObservableBuilderState<T> createState() => _ObservableBuilderState();
}

class _ObservableBuilderState<T> extends State<ObservableBuilder<T>>{
  @override
  Widget build(BuildContext context) => widget.builder(context,widget.observable.value);

  void callback(T value){
    if(mounted)
      setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.observable.subscribe(callback);
  }

  @override
  void dispose(){
    widget.observable.unsubscribe(callback);
    super.dispose();
  }

  @override
  void didUpdateWidget(ObservableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.observable != widget.observable) {
      oldWidget.observable.unsubscribe(callback);
      widget.observable.subscribe(callback);
    }
  }
}
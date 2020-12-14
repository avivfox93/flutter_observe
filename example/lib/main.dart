import 'package:flutter/material.dart';
import 'package:flutter_observe/flutter_observable.dart';

var observable = Observable.value(0);
var listObservable = Observable.value(List<int>());
void main() {
  runApp(MyApp());

  Future(() async {
    for (;;) {
      await Future.delayed(Duration(seconds: 1));
      if (listObservable.value.length >= 10) {
        listObservable.value.clear();
      }
      observable.value = ((observable.value + 1) % 100);
      listObservable.value.add(observable.value);
      listObservable.notify();
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: AppBar(
            title: ObservableBuilder<int>(
              builder: (context, value) {
                return Text(value.toString());
              },
              observable: observable,
            ),
          ),
          backgroundColor: Colors.blue[50],
          body: ObservableBuilder<List<int>>(
            builder: (context, value) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Center(child: Text(value[index].toString()));
                },
                itemCount: value.length,
              );
            },
            observable: listObservable,
          )),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_observe/flutter_observable.dart';

void main() {
  test('adds one to input values', () {
    final observable = Observable.value(-1);
    expect(observable.value, -1);
    observable.value = 25;
    expect(observable.value, 25);
  });
}

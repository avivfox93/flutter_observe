
class Observable<T> {
  T _value;
  Observable.value(this._value);

  final List<Function(T)> _subscribers = [];
  T get value => _value;
  set value(T val){
    _value = val;
    notify();
  }

  void subscribe(Function(T) callback) => _subscribers.add(callback);

  void unsubscribe(Function(T) callback) => _subscribers.remove(callback);

  void notify(){
    _subscribers.forEach((element) => element(_value));
  }
}
import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends InheritedWidget {
  const BlocProvider({
    required Key key,
    required this.child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;
  @override
  final Widget child;

  static T of<T extends BlocBase>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>();
    return provider!.bloc; // Safe access using null-safety operator (!)
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget is BlocProvider<T> && oldWidget.bloc != bloc;
  }

  Widget build(BuildContext context) {
    return child;
  }
}

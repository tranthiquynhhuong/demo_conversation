import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Consum<T extends ChangeNotifier> extends StatelessWidget {
  final T value;
  final Widget Function(BuildContext, T) builder;

  const Consum({Key key, @required this.value, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: value,
      child: Consumer<T>(
        builder: (_, info, __) => builder(_, info),
      ),
    );
  }
}

class Consum2<T extends ChangeNotifier, U extends ChangeNotifier> extends StatelessWidget {
  final T value1;
  final U value2;
  final Widget Function(BuildContext, T, U) builder;

  const Consum2({Key key, @required this.value1, @required this.value2, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: value1,
      child: ChangeNotifierProvider.value(
        value: value2,
        child: Consumer2<T, U>(
          builder: (_, v1, v2, __) => builder(_, v1, v2),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class TTStatefulWidget extends StatefulWidget {
  bool get isMobile => Platform.isIOS || Platform.isAndroid;
}

abstract class TTState<V extends ChangeNotifier, T extends StatefulWidget> extends State<T> with StateMixin<V, T> {
  @override
  Widget build(BuildContext context) {
    final model = getModel(context);
    return buildWithModel(context, model);
  }

  Widget buildWithModel(BuildContext context, V model);
}

class TTChangeNotifier<T extends StatefulWidget> extends ChangeNotifier with ModelMixin<T> {}

mixin StateMixin<V extends ChangeNotifier, T extends StatefulWidget> on State<T> {
  V get model => Provider.of<V>(context, listen: false);
  T get view => widget;

  MediaQueryData get device => MediaQuery.of(context);

  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  V getModel(BuildContext contex) => context.watch<V>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model is ModelMixin) {
        (model as ModelMixin)._buildContext = () => context;
        (model as ModelMixin)._buildWidget = () => widget;
        (model as ModelMixin).onReady();
      }
      didInitState();
    });
    super.initState();
  }

  void didInitState() {}
}

mixin ModelMixin<T extends StatefulWidget> on ChangeNotifier {
  BuildContext Function() _buildContext;
  T Function() _buildWidget;

  BuildContext get context => _buildContext?.call();
  T get view => _buildWidget?.call();

  MediaQueryData get device => () {
        final context = this.context;
        assert(context != null);
        return MediaQuery.of(context);
      }();

  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  void runOnUI(Function(BuildContext) onCallback, {VoidCallback onError}) {
    final ctx = context;
    if (ctx == null) {
      onError?.call();
      return;
    }
    onCallback?.call(ctx);
  }

  void onReady() {}

  @override
  void dispose() {
    _buildContext = null;
    super.dispose();
  }
}

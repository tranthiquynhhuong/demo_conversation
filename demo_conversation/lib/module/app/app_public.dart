library app;

import 'package:demo_conversation/module/splash/splash_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';

part 'app_view.dart';
part 'app_model.dart';
part 'app_state.dart';

ChangeNotifierProvider<_AppModel> createApp() {
  return ChangeNotifierProvider<_AppModel>(
    create: (_) => _AppModel(),
    child: _AppView(),
  );
}

library splash;

import 'package:demo_conversation/module/module.dart';
import 'package:demo_conversation/res/res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';

part 'splash_view.dart';
part 'splash_model.dart';
part 'splash_state.dart';

ChangeNotifierProvider<_SplashModel> createSplash() {
  return ChangeNotifierProvider<_SplashModel>(
    create: (_) => _SplashModel(),
    child: _SplashView(),
  );
}

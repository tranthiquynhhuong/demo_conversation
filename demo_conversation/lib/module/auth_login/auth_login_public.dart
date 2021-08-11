library auth_login;

import 'package:demo_conversation/module/module.dart';
import 'package:demo_conversation/res/res.dart';
import 'package:demo_conversation/service/service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';
import 'package:demo_conversation/utils/utils.dart';

part 'auth_login_view.dart';
part 'auth_login_model.dart';
part 'auth_login_state.dart';

ChangeNotifierProvider<_AuthLoginModel> createAuthLogin() {
  return ChangeNotifierProvider<_AuthLoginModel>(
    create: (_) => _AuthLoginModel(),
    child: _AuthLoginView(),
  );
}

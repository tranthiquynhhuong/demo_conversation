library main_home_conversation;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:demo_conversation/model/model.dart';
import 'package:demo_conversation/module/module.dart';
import 'package:demo_conversation/res/color.p.dart';
import 'package:demo_conversation/res/style.p.dart';
import 'package:demo_conversation/service/service.dart';
import 'package:demo_conversation/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';
import 'package:demo_conversation/utils/utils.dart';

part 'main_home_conversation_view.dart';
part 'main_home_conversation_model.dart';
part 'main_home_conversation_state.dart';

ChangeNotifierProvider<_MainHomeConversationModel> createMainHomeConversation() {
  return ChangeNotifierProvider<_MainHomeConversationModel>(
    create: (_) => _MainHomeConversationModel(),
    child: _MainHomeConversationView(),
  );
}

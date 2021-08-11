library task;

import 'package:flutter/material.dart';
import 'package:demo_conversation/res/color.p.dart';
import 'package:demo_conversation/res/style.p.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';

part 'task_view.dart';
part 'task_model.dart';
part 'task_state.dart';

ChangeNotifierProvider<_TaskModel> createTask() {
  return ChangeNotifierProvider<_TaskModel>(
    create: (_) => _TaskModel(),
    child: _TaskView(),
  );
}

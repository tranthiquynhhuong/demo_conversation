library list_test;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';

part 'list_test_view.dart';
part 'list_test_model.dart';
part 'list_test_state.dart';

ChangeNotifierProvider<_ListTestModel> createListTest() {
  return ChangeNotifierProvider<_ListTestModel>(
    create: (_) => _ListTestModel(),
    child: _ListTestView(),
  );
}

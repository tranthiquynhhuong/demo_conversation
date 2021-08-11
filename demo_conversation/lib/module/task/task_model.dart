part of task;

class _TaskModel extends TTChangeNotifier<_TaskView> {
  double getWidthOfPercentBar({double percent, double maxWidth}) {
    return (percent * maxWidth) / 100;
  }

  void goBack() {
    // Navigator.of(context).pop();
    print('goBack');
  }
}

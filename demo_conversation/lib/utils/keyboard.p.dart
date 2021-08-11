part of utils;

void dismissKeyboard(BuildContext context) {
  final f = FocusScope.of(context);
  f.unfocus();
}

part of app;

class _AppViewState extends TTState<_AppModel, _AppView> {
  @override
  Widget buildWithModel(BuildContext context, _AppModel model) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        splashColor: Colors.grey.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.2),
      ),
      home: createSplash(),
    );
  }
}

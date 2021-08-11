part of splash;

class _SplashViewState extends TTState<_SplashModel, _SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => createAuthLogin()));
    });
  }

  @override
  Widget buildWithModel(BuildContext context, _SplashModel model) {
    return GestureDetector(
      onTap: () {
        final scope = FocusScope.of(context);
        scope.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Container(
            child: Image.asset(Id.wishlist),
          ),
        ),
      ),
    );
  }
}

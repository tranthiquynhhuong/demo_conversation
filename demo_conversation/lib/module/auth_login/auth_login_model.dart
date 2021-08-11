part of auth_login;

class _AuthLoginModel extends TTChangeNotifier<_AuthLoginView> {
  static const String PASSWORD_VALIDATE_STR = r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,32}$';
  RegExp pwdValidator = new RegExp(PASSWORD_VALIDATE_STR);

  TextEditingController emailTxtController;
  TextEditingController passwordTxtController;

  bool isEmailValid = false;
  bool isPasswordValid = false;

  _AuthLoginModel() {
    emailTxtController = TextEditingController();
    passwordTxtController = TextEditingController();
  }

  void dispose() {
    emailTxtController?.dispose();
    passwordTxtController?.dispose();
    super.dispose();
  }

  void onPasswordChange(String str) {
    isPasswordValid = pwdValidator.hasMatch(str);
    notifyListeners();
  }

  void onEmailChange(String str) {
    isEmailValid = EmailValidator.validate(str);
    notifyListeners();
  }

  bool normalLogin() {
    return true;
  }

  void onSignInClick() async {
    if (normalLogin()) {
      dismissKeyboard(context);
      final isOk = await userSrv.login();
      if (isOk) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => createMainHomeConversation()));
      }
    } else {
      print("onSignInClick: sign in fail");
    }
  }
}

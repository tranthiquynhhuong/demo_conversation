part of auth_login;

class _AuthLoginViewState extends TTState<_AuthLoginModel, _AuthLoginView> {
  @override
  Widget buildWithModel(BuildContext context, _AuthLoginModel model) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Cl.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Cl.white,
      ),
    );
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        backgroundColor: Cl.white,
        body: SafeArea(
          child: SingleChildScrollView(
            primary: true,
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                TextFieldAuthen(
                  hintText: "email@example.com",
                  controller: model.emailTxtController,
                  isValid: model.isEmailValid,
                  label: "Email address",
                  onChange: model.onEmailChange,
                ),
                SizedBox(height: 41),
                TextFieldAuthen(
                  helperText:
                      "Password is 8 characters or more, including lowercase letters, uppercase letters and numbers",
                  hintText: "123456aA",
                  isValid: model.isPasswordValid,
                  controller: model.passwordTxtController,
                  label: "Password",
                  isObscure: true,
                  onChange: model.onPasswordChange,
                ),
                SizedBox(height: 31),
                SignInBtn(
                  onPressed: (model.isEmailValid && model.isPasswordValid) ? model.onSignInClick : null,
                  title: 'Start your conversation',
                ),
                SizedBox(height: 23),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

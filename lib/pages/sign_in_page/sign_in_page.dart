import 'package:app_ui/app_ui.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 65),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    child: Image.asset(
                      ImageConstant.logoClub,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                      height: 230,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Entre na sua conta',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 20),
                const CustomTextField(hint: 'Email'),
                const SizedBox(height: 25),
                const CustomTextField(hint: 'Senha'),
                const SizedBox(height: 45),
                CustomButton(
                  textLabel: 'Entrar',
                  height: 50,
                  onPressed: onTapLogin,
                ),
                const SizedBox(height: 28),
                _buildSignUp(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Section Widget
  Widget _buildSignUp(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: context.colors.onSecondary, fontSize: 15),
        children: <TextSpan>[
          const TextSpan(text: 'Não tem uma conta? '),
          TextSpan(
            text: 'Cadastre-se',
            style: TextStyle(
              color: context.colors.tertiary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTapSignUp,
          ),
        ],
      ),
    );
  }

  /// Navigates to the home screen when login is performed.
  onTapLogin() {
    context.push(AppRouter.homeScreen);
  }

  /// Navigates to the Sign Up screen when login is performed.
  onTapSignUp() {
    context.push(AppRouter.signUpScreen);
  }
}

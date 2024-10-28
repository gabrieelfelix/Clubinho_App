import 'package:app_ui/app_ui.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Hero(
                      tag: ImageConstant.logoClub,
                      child: SizedBox(
                        child: Image.asset(
                          ImageConstant.logoClub,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          height: 230,
                        ),
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
                  const CustomTextField(hint: 'Nome Completo'),
                  const SizedBox(height: 25),
                  const CustomTextField(hint: 'Email'),
                  const SizedBox(height: 25),
                  const CustomTextField(hint: 'Senha'),
                  const SizedBox(height: 25),
                  const CustomTextField(hint: 'Digite a senha novamente'),
                  const SizedBox(height: 25),
                  const CustomTextField.suffixIcon(
                      hint: 'Telefone', suffixIcon: Icon(Icons.phone)),
                  const SizedBox(height: 45),
                  CustomButton(
                    textLabel: 'Cadastrar',
                    height: 50,
                    onPressed: () => onTapCodeVerification(context),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the code verification screen when login is performed.
  onTapCodeVerification(BuildContext context) {
    context.push(AppRouter.codeVerification);
  }
}

import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/sign_in_page/bloc/authentication_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authRepository: getIt<IAuthenticationRepository>(),
      ),
      child: const SignInPageView(),
    );
  }
}

class SignInPageView extends StatefulWidget {
  const SignInPageView({super.key});

  @override
  State<SignInPageView> createState() => _SignInPageViewState();
}

class _SignInPageViewState extends State<SignInPageView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthenticationBloc>();
    return BlocListener<AuthenticationBloc, IAuthenticationState>(
      listener: (context, state) {
        if (state is SignInProcess) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login realizado com sucesso'),
            ),
          );
          setState(
            () {
              isLoading = false;
              onTapLogin();
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 65),
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
                    CustomTextField(
                      hint: 'Email',
                      textEditingController: _emailController,
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      hint: 'Senha',
                      textEditingController: _passwordController,
                    ),
                    const SizedBox(height: 45),
                    isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                    const SizedBox(height: 25),
                    CustomButton(
                      textLabel: 'Entrar',
                      height: 50,
                      onPressed: () => bloc.add(
                        SignInRequired(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _buildSignUp(context),
                  ],
                ),
              ),
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
    context.go(AppRouter.homeScreen);
  }

  /// Navigates to the Sign Up screen when login is performed.
  onTapSignUp() {
    context.push(AppRouter.signUpScreen);
  }
}

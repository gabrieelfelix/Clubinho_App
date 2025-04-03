import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/sign_in_page/bloc/authentication_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// theme ( fontes, cores, widgets ) ver no idp
// responsividade
// bem estruturado ( ver ethos layout )
// validações
//loading OK
// verificar se tem trim em algum luguar de todos os textfield
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authRepository: getIt<IAuthenticationRepository>(),
      ),
      child: SignInPageView(),
    );
  }
}

class SignInPageView extends StatelessWidget {
  SignInPageView({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _handlerListener,
      builder: _handlerBuilder,
    );
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(
    BuildContext context,
    AuthenticationState state,
  ) {
    final bloc = context.read<AuthenticationBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 65),
              child: Form(
                key: _formKey,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 22,
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ganhe corações para Jesus desde a infância!',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField.email(
                      hint: 'Email',
                      textInputAction: TextInputAction.next,
                      textEditingController: _emailController,
                      validator: (value) =>
                          state.email.validator(value ?? '')?.text(),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField.password(
                      obscure: state.obscure,
                      textInputAction: TextInputAction.send,
                      validator: (value) =>
                          state.password.validator(value ?? '')?.text(),
                      suffixIcon: IconButton(
                        onPressed: () => bloc.add(ChangeObscureRequired()),
                        icon: Icon(
                          state.obscure!
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                        ),
                        color: context.theme.colorScheme.primary,
                      ),
                      hint: 'Senha',
                      textEditingController: _passwordController,
                      onSubmitted: (st) => st.isNotEmpty
                          ? bloc.add(
                              SignInRequired(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            )
                          : {},
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: _buildTextHiperLink(
                        context: context,
                        text: 'Esqueceu a senha?',
                        textLink: 'Clique aqui',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: 60),
                    CustomButton(
                      label: 'Entrar',
                      isLoading: state.isProgress,
                      height: 50,
                      onPressed: () {
                        _formKey.currentState!.validate()
                            ? bloc.add(
                                SignInRequired(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              )
                            : null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: _buildTextHiperLink(
                        context: context,
                        text: 'Não tem uma conta? ',
                        textLink: 'Cadastre-se',
                        onTap: () => onTapSignUp(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, AuthenticationState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    }
    if (state.isSuccess) {
      showCustomSnackBar(context, state.message!);
      onTapLogin(context);
    }
  }

  ///Section Widget
  Widget _buildTextHiperLink({
    required BuildContext context,
    required String text,
    required String textLink,
    required GestureTapCallback onTap,
  }) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: context.colors.onSecondary, fontSize: 15),
        children: <TextSpan>[
          TextSpan(
            text: ' $text',
          ),
          TextSpan(
            text: ' $textLink',
            style: TextStyle(
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }

  /// Navigates to the home screen when login is performed.
  onTapLogin(BuildContext context) {
    context.go(AppRouter.homeScreen);
  }

  /// Navigates to the Sign Up screen when login is performed.
  void onTapSignUp(BuildContext context) {
    context.push(AppRouter.signUpScreen);
  }
}

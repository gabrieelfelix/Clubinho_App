import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpBloc(authRepository: getIt<IAuthenticationRepository>()),
      child: SignUpPageView(),
    );
  }
}

class SignUpPageView extends StatelessWidget {
  SignUpPageView({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordRepeatController =
      TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: _handlerListener,
      builder: _handlerBuilder,
    );
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(
    BuildContext context,
    SignUpState state,
  ) {
    final bloc = context.read<SignUpBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cadastrar-se',
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
                      'Ensine o caminho e eles nunca se desviarão!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hint: 'Nome Completo',
                    textEditingController: _nameController,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    hint: 'Email',
                    textEditingController: _emailController,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField.suffixIcon(
                    hint: 'Senha',
                    obscure: state.obscure!,
                    textEditingController: _passwordController,
                    suffixIcon: IconButton(
                      onPressed: () => bloc
                          .add(const ChangeObscureRequired(firstObscure: true)),
                      icon: Icon(
                        state.obscure!
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                      ),
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField.suffixIcon(
                    hint: 'Digite a senha novamente',
                    obscure: state.secondObscure!,
                    textEditingController: _passwordRepeatController,
                    suffixIcon: IconButton(
                      onPressed: () => bloc.add(const ChangeObscureRequired()),
                      icon: Icon(
                        state.secondObscure!
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                      ),
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField.suffixIcon(
                    textEditingController: _phoneController,
                    hint: 'Telefone',
                    suffixIcon: Icon(
                      Icons.phone,
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    label: 'Cadastrar',
                    isLoading: state.isLoading,
                    height: 50,
                    onPressed: () {
                      bloc.add(
                        SignUpRequired(
                          phone: _phoneController.text,
                          email: _emailController.text,
                          username: _nameController.text,
                          password: _passwordRepeatController.text,
                        ),
                      );
                    },
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

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, SignUpState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    }
    if (state.isSuccess) {
      showCustomSnackBar(context, state.message!);
    }
    if (state.isSuccess) {
      _clearFields();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void _clearFields() {
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
    _passwordRepeatController.clear();
    _nameController.clear();
  }
}

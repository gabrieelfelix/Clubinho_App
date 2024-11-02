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
      child: const SignUpPageView(),
    );
  }
}

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({super.key});

  @override
  State<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordRepeatController =
      TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return BlocListener<SignUpBloc, ISignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
        if (state is SignUpProcess) {
          setState(() {
            isLoading = true;
          });
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
                        'Crie uma conta',
                        style: TextStyle(fontSize: 22),
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
                    CustomTextField(
                      hint: 'Senha',
                      textEditingController: _passwordController,
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      hint: 'Digite a senha novamente',
                      textEditingController: _passwordRepeatController,
                    ),
                    const SizedBox(height: 25),
                    CustomTextField.suffixIcon(
                      textEditingController: _phoneController,
                      hint: 'Telefone',
                      suffixIcon: const Icon(Icons.phone),
                    ),
                    const SizedBox(height: 45),
                    isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                    const SizedBox(height: 25),
                    CustomButton(
                      textLabel: 'Cadastrar',
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
                        // onTapCodeVerification(context);
                      },
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

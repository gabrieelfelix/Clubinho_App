import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// quando digito primeiro o segundo campo de senha quando digito
// a senha dps disso ele não atualiza so se apertar no o olho
// mas ele atualiza quando digito um acrater a mais

// dps q o cadastrar diz q ta com erro nada muda, ele não valida dnv
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

// ignore: must_be_immutable
class SignUpPageView extends StatelessWidget {
  SignUpPageView({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordRepeatController =
      TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 65),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        style: context.text.headlineMedium!.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ensine o caminho e eles nunca se desviarão!',
                        style: context.text.bodyMedium!
                            .copyWith(color: context.colors.surface),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Nome Completo',
                      textInputAction: TextInputAction.next,
                      textEditingController: _nameController,
                      autofillHints: const [AutofillHints.name],
                      validator: (vl) =>
                          state.fullName.validator(vl ?? '')?.text(),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField.email(
                      hint: 'Email',
                      textInputAction: TextInputAction.next,
                      textEditingController: _emailController,
                      validator: (vl) =>
                          state.email.validator(vl ?? '')?.text(),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField.password(
                      hint: 'Senha',
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.next,
                      obscure: state.obscure!,
                      textEditingController: _passwordController,
                      validator: (vl) =>
                          state.password.validator(vl ?? '')?.text(),
                      suffixIcon: IconButton(
                        onPressed: () => bloc.add(
                            const ChangeObscureRequired(firstObscure: true)),
                        icon: Icon(
                          state.obscure!
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                        ),
                        color: context.colors.primary,
                      ),
                      onChanged: (vl) {
                        bloc.add(
                          ChangePasswordAndConfirmPass(
                            password: vl,
                            confirmPassword: state.confirmedPassword.value,
                          ),
                        );
                      },
                    ),
                    _buildFeedbackValidator(
                      context,
                      state,
                      state.lowercase!,
                      'Letra minúscula',
                    ),
                    _buildFeedbackValidator(
                      context,
                      state,
                      state.uppercase!,
                      'Letra maiúscula',
                    ),
                    _buildFeedbackValidator(
                      context,
                      state,
                      state.atLeast8!,
                      'Pelo menos 8 caracteres',
                    ),
                    const SizedBox(height: 25),
                    CustomTextField.password(
                      hint: 'Digite a senha novamente',
                      key: ValueKey(state.confirmedPassword.password),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      obscure: state.secondObscure!,
                      textEditingController: _passwordRepeatController,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            bloc.add(const ChangeObscureRequired()),
                        icon: Icon(
                          state.secondObscure!
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: context.colors.primary,
                        ),
                      ),
                      validator: (vl) =>
                          state.confirmedPassword.validator(vl ?? '')?.text(),
                      onChanged: (vl) {
                        bloc.add(
                          ChangeConfirmPassRequired(
                            password: state.password.value,
                            confirmPassword: vl,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomTextField.suffixIcon(
                      textEditingController: _phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.send,
                      validator: (vl) =>
                          state.phone.validator(vl ?? '')?.text(),
                      autofillHints: const [AutofillHints.telephoneNumber],
                      inputFormatters: [MaskFormatter.phoneMaskFormatter],
                      hint: 'Telefone',
                      suffixIcon: Icon(
                        Icons.phone,
                        color: context.colors.primary,
                      ),
                      onSubmitted: (st) {
                        if (st.isNotEmpty) {
                          if (_formKey.currentState!.validate()) {
                            bloc.add(
                              SignUpRequired(
                                phone: _phoneController.text,
                                email: _emailController.text,
                                username: _nameController.text,
                                password: _passwordRepeatController.text,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      label: 'Cadastrar',
                      isLoading: state.isLoading,
                      height: 50,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bloc.add(
                            SignUpRequired(
                              phone: _phoneController.text,
                              email: _emailController.text,
                              username: _nameController.text,
                              password: _passwordRepeatController.text,
                            ),
                          );
                        }
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

  /// Widget Section
  Widget _buildFeedbackValidator(
    BuildContext context,
    SignUpState state,
    bool validator,
    String desc,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Row(
        children: [
          validator
              ? Icon(
                  Icons.check_circle_outline,
                  color: context.colors.primary,
                )
              : state.password.value.isEmpty
                  ? Icon(
                      Icons.check_circle_outline,
                      color: context.colors.surface,
                    )
                  : Icon(
                      Icons.check_circle_outline,
                      color: context.colors.error,
                    ),
          Text(
            ' $desc',
            style: context.text.bodyMedium!.copyWith(
              color: validator
                  ? context.colors.primary
                  : state.password.value.isEmpty
                      ? context.colors.surface
                      : context.colors.error,
            ),
          ),
        ],
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, SignUpState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
      _clearFields();
      //   context.read<SignUpBloc>().add(const ResetSignUpForm());
      //  _formKey.currentState!.reset();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    if (state.isSuccess) {
      showCustomSnackBar(context, state.message!);
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

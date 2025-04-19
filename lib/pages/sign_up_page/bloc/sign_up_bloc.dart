// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'sign_up_bloc_event.dart';
part 'sign_up_bloc_state.dart';

class SignUpBloc extends Bloc<ISignUpEvent, SignUpState> {
  final IAuthenticationRepository _authRepository;

  SignUpBloc({required IAuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState.initial()) {
    on<SignUpRequired>(_onSignUpRequired);
    on<ChangeObscureRequired>(_onChangeObscureRequired);
    on<ChangeConfirmPassRequired>(_onChangeConfirmPassRequired);
    on<ChangePasswordAndConfirmPass>(_onChangePasswordAndConfirmPass);
    on<ResetSignUpForm>(_onResetSignUpForm);
  }

  Future<void> _onResetSignUpForm(
      ResetSignUpForm event, Emitter<SignUpState> emit) async {
    emit(const SignUpState.initial());
  }

  Future<void> _onSignUpRequired(
      SignUpRequired event, Emitter<SignUpState> emit) async {
    final bool isObscure = state.obscure!;
    final bool isSecondObscure = state.secondObscure!;
    if (state.isLoading) return;

    emit(
      const SignUpState.loading().copyWith(
        obscure: isObscure,
        secondObscure: isSecondObscure,
      ),
    );

    final response = await _authRepository.signUp(
      email: event.email,
      name: event.username,
      phone: event.phone,
      password: event.password,
    );

    response.when(
      (success) => emit(
        SignUpState.success(message: success).copyWith(
          obscure: isObscure,
          secondObscure: isSecondObscure,
        ),
      ),
      (failure) => emit(
        SignUpState.failure(message: failure.message).copyWith(
          obscure: isObscure,
          secondObscure: isSecondObscure,
        ),
      ),
    );
  }

  Future<void> _onChangeObscureRequired(
      ChangeObscureRequired event, Emitter<SignUpState> emit) async {
    final currentState = state.state;
    if (event.firstObscure) {
      emit(
        state.copyWith(
          obscure: !state.obscure!,
          secondObscure: state.secondObscure!,
          state: state.isLoading ? currentState : FormzSubmissionStatus.initial,
        ),
      );
    } else {
      emit(
        state.copyWith(
          obscure: state.obscure!,
          secondObscure: !state.secondObscure!,
          state: state.isLoading ? currentState : FormzSubmissionStatus.initial,
        ),
      );
    }
  }

  Future<void> _onChangeConfirmPassRequired(
    ChangeConfirmPassRequired event,
    Emitter<SignUpState> emit,
  ) async {
    final currentState = state.state;

    final confirmedPassword = ConfirmedPassword.dirty(
      password: event.password,
      value: event.confirmPassword,
    );

    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        password: Password.dirty(event.password),
        state: currentState,
      ),
    );
  }

  // Future<void> _onChangePassRequired(
  //   ChangePassRequired event,
  //   Emitter<SignUpState> emit,
  // ) async {
  //   final currentState = state.state;

  //   final newPassword = Password.dirty(event.password);
  //   final confirmedPassword = ConfirmedPassword.dirty(
  //     password: newPassword.value,
  //     value: state.confirmedPassword.value,
  //   );

  //   final passValue = newPassword.value;

  //   final hasUppercase = RegExp(r'[A-Z]').hasMatch(passValue);
  //   final hasLowercase = RegExp(r'[a-z]').hasMatch(passValue);
  //   final hasMinLength = passValue.length >= 8;

  //   emit(
  //     state.copyWith(
  //       password: newPassword,
  //       confirmedPassword: confirmedPassword,
  //       atLeast8: hasMinLength,
  //       lowercase: hasLowercase,
  //       uppercase: hasUppercase,
  //       state: currentState,
  //     ),
  //   );
  // }

  Future<void> _onChangePasswordAndConfirmPass(
    ChangePasswordAndConfirmPass event,
    Emitter<SignUpState> emit,
  ) async {
    final currentState = state.state;
    final confirmedPassword = ConfirmedPassword.dirty(
      password: event.password,
      value: event.confirmPassword,
    );
    final newPassword = Password.dirty(event.password);

    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        password: newPassword,
        atLeast8: RegExp(r'.{8,}').hasMatch(event.password),
        lowercase: RegExp(r'[a-z]').hasMatch(event.password),
        uppercase: RegExp(r'[A-Z]').hasMatch(event.password),
        state: currentState,
      ),
    );
  }
}

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
  }

  Future<void> _onSignUpRequired(
      SignUpRequired event, Emitter<SignUpState> emit) async {
    final bool isObscure = state.obscure!;
    final bool isSecondObscure = state.secondObscure!;
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
      emit(state.copyWith(
        obscure: !state.obscure!,
        secondObscure: state.secondObscure!,
        state: state.isLoading ? currentState : FormzSubmissionStatus.initial,
      ));
    } else {
      emit(state.copyWith(
        obscure: state.obscure!,
        secondObscure: !state.secondObscure!,
        state: state.isLoading ? currentState : FormzSubmissionStatus.initial,
      ));
    }
  }

  Future<void> _onChangeConfirmPassRequired(
      ChangeConfirmPassRequired event, Emitter<SignUpState> emit) async {
    final currentState = state.state;
    final confirmPass = ConfirmedPassword.dirty(
      password: event.password,
      value: event.confirmPassword,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmPass,
        password: Password.dirty(event.password),
        state: state.isLoading ? currentState : FormzSubmissionStatus.initial,
      ),
    );
  }
}

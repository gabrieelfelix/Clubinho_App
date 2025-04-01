import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_bloc_event.dart';
part 'sign_up_bloc_state.dart';

class SignUpBloc extends Bloc<ISignUpEvent, SignUpState> {
  final IAuthenticationRepository _authRepository;

  SignUpBloc({required IAuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState.obscure(obscure: true, secondObscure: true)) {
    on<SignUpRequired>(_onSignUpRequired);
    on<ChangeObscureRequired>(_onChangeObscureRequired);
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
    if (event.firstObscure) {
      emit(SignUpState.obscure(
          obscure: !state.obscure!, secondObscure: state.secondObscure!));
    } else {
      emit(SignUpState.obscure(
          obscure: state.obscure!, secondObscure: !state.secondObscure!));
    }
  }
}

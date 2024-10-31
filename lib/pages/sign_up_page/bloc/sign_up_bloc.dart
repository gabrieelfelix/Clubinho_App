import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_bloc_event.dart';
part 'sign_up_bloc_state.dart';

class SignUpBloc extends Bloc<ISignUpEvent, ISignUpState> {
  final IAuthenticationRepository _authRepository;

  SignUpBloc({required IAuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>(_onSignUpRequired);
  }

  Future<void> _onSignUpRequired(
      SignUpRequired event, Emitter<ISignUpState> emit) async {
    emit(SignUpProcess());

    final response = await _authRepository.signUp(
      email: event.email,
      name: event.username,
      phone: event.phone,
      password: event.password,
    );

    response.when(
      (success) => emit(
        SignUpSuccess(message: success),
      ),
      (failure) => emit(
        SignUpFailure(message: failure.message),
      ),
    );
  }
}

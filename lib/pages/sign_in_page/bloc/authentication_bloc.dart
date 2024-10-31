import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<IAuthenticationEvent, IAuthenticationState> {
  final IAuthenticationRepository _authRepository;

  AuthenticationBloc({required IAuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(SignInInitial()) {
    on<SignInRequired>(_onSignInRequired);

    on<SignOutRequired>(_onSignOutRequired);
  }

  Future<void> _onSignOutRequired(
      SignOutRequired event, Emitter<IAuthenticationState> emit) async {
    _authRepository.logOut();
    emit(LogOut());
  }

  Future<void> _onSignInRequired(
      SignInRequired event, Emitter<IAuthenticationState> emit) async {
    emit(SignInProcess());

    final response = await _authRepository.signIn(
      email: event.email,
      password: event.password,
    );

    response.when(
      (success) => emit(
        SignInSuccess(authUserModel: success),
      ),
      (failure) => emit(
        SignInFailure(message: failure.message),
      ),
    );
  }
}

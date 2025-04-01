import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<IAuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _authRepository;

  AuthenticationBloc({required IAuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthenticationState.obscure(obscure: true)) {
    on<SignInRequired>(_onSignInRequired);
    on<SignOutRequired>(_onSignOutRequired);
    on<ChangeObscureRequired>(_onChangeObscureRequired);
  }

  Future<void> _onSignOutRequired(
      SignOutRequired event, Emitter<AuthenticationState> emit) async {
    _authRepository.logOut();
    emit(const AuthenticationState.logOUt());
  }

  Future<void> _onChangeObscureRequired(
      ChangeObscureRequired event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationState.obscure(obscure: !state.obscure!));
  }

  Future<void> _onSignInRequired(
      SignInRequired event, Emitter<AuthenticationState> emit) async {
    final bool isObscure = state.obscure!;
    emit(const AuthenticationState.loading().copyWith(obscure: isObscure));

    final response = await _authRepository.signIn(
      email: event.email,
      password: event.password,
    );

    response.when(
      (success) => emit(
        AuthenticationState.success(message: success)
            .copyWith(obscure: isObscure),
      ),
      (failure) => emit(
        AuthenticationState.failure(message: failure.message)
            .copyWith(obscure: isObscure),
      ),
    );
  }
}

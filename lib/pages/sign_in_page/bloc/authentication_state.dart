part of 'authentication_bloc.dart';

enum AuthenticationStateStatus {
  initial,
  loading,
  success,
  failure,
  logOut,
  obscure,
}

class AuthenticationState extends Equatable {
  final AuthenticationStateStatus state;
  final bool? obscure;
  final String? message;

  const AuthenticationState._({
    this.state = AuthenticationStateStatus.loading,
    this.obscure,
    this.message,
  });

  const AuthenticationState.initial()
      : this._(state: AuthenticationStateStatus.initial);

  const AuthenticationState.failure({required String message})
      : this._(state: AuthenticationStateStatus.failure, message: message);

  const AuthenticationState.success({required String message})
      : this._(state: AuthenticationStateStatus.success, message: message);

  const AuthenticationState.obscure({required bool obscure})
      : this._(state: AuthenticationStateStatus.obscure, obscure: obscure);

  const AuthenticationState.logOUt()
      : this._(state: AuthenticationStateStatus.logOut);

  const AuthenticationState.loading() : this._();

  AuthenticationState copyWith({
    AuthenticationStateStatus? state,
    bool? obscure,
    String? message,
  }) {
    return AuthenticationState._(
      state: state ?? this.state,
      obscure: obscure ?? this.obscure,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, obscure, message];
}

extension HomePageStateExtensions on AuthenticationState {
  bool get isInitial => state == AuthenticationStateStatus.initial;
  bool get isLoading => state == AuthenticationStateStatus.loading;
  bool get isLogOut => state == AuthenticationStateStatus.logOut;
  bool get isObscure => state == AuthenticationStateStatus.obscure;
  bool get isFailure => state == AuthenticationStateStatus.failure;
  bool get isSuccess => state == AuthenticationStateStatus.success;
}

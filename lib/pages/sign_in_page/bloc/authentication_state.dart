part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final FormzSubmissionStatus state;
  final bool? obscure;
  final String? message;
  final Email email;
  final Password password;

  const AuthenticationState._({
    this.state = FormzSubmissionStatus.inProgress,
    this.obscure,
    this.message,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  const AuthenticationState.initial()
      : this._(state: FormzSubmissionStatus.initial, obscure: true);

  const AuthenticationState.failure({required String message})
      : this._(state: FormzSubmissionStatus.failure, message: message);

  const AuthenticationState.success({required String message})
      : this._(state: FormzSubmissionStatus.success, message: message);

  const AuthenticationState.logOUt()
      : this._(state: FormzSubmissionStatus.canceled);

  const AuthenticationState.loading() : this._();

  AuthenticationState copyWith({
    FormzSubmissionStatus? state,
    bool? obscure,
    String? message,
    Email? email,
    Password? password,
  }) {
    return AuthenticationState._(
      state: state ?? this.state,
      obscure: obscure ?? this.obscure,
      message: message ?? this.message,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        state,
        obscure,
        message,
        password,
        email,
      ];
}

extension HomePageStateExtensions on AuthenticationState {
  bool get isInitial => state == FormzSubmissionStatus.initial;
  bool get isFailure => state == FormzSubmissionStatus.failure;
  bool get isProgress => state == FormzSubmissionStatus.inProgress;
  bool get isSuccess => state == FormzSubmissionStatus.success;
}

part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final FormzSubmissionStatus state;
  final bool? obscure;
  final bool? secondObscure;
  final String? message;
  final Email email;
  final Password password;
  final FullName fullName;
  final ConfirmedPassword confirmedPassword;

  const SignUpState._({
    this.state = FormzSubmissionStatus.inProgress,
    this.obscure,
    this.secondObscure,
    this.message,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.fullName = const FullName.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
  });

  const SignUpState.initial()
      : this._(
          state: FormzSubmissionStatus.initial,
          obscure: true,
          secondObscure: true,
        );

  const SignUpState.failure({required String message})
      : this._(state: FormzSubmissionStatus.failure, message: message);

  const SignUpState.success({required String message})
      : this._(state: FormzSubmissionStatus.success, message: message);

  const SignUpState.loading() : this._();
  // const SignUpState.obscure(
  //     {required bool obscure, required bool secondObscure})
  //     : this._(
  //         state: FormzSubmissionStatus.obscure,
  //         obscure: obscure,
  //         secondObscure: secondObscure,
  //       );

  SignUpState copyWith({
    FormzSubmissionStatus? state,
    bool? obscure,
    bool? secondObscure,
    String? message,
    Email? email,
    Password? password,
    FullName? fullName,
    ConfirmedPassword? confirmedPassword,
  }) {
    return SignUpState._(
      state: state ?? this.state,
      obscure: obscure ?? this.obscure,
      secondObscure: secondObscure ?? this.secondObscure,
      message: message ?? this.message,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
    );
  }

  @override
  List<Object?> get props => [
        state,
        obscure,
        secondObscure,
        message,
        confirmedPassword,
        password,
        email,
        fullName,
      ];
}

extension HomePageStateExtensions on SignUpState {
  bool get isInitial => state == FormzSubmissionStatus.initial;
  bool get isLoading => state == FormzSubmissionStatus.inProgress;
  bool get isFailure => state == FormzSubmissionStatus.failure;
  bool get isSuccess => state == FormzSubmissionStatus.success;
}

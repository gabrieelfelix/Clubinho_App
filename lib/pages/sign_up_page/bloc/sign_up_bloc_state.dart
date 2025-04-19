part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final FormzSubmissionStatus state;
  final bool? obscure;
  final bool? secondObscure;
  final bool? lowercase;
  final bool? uppercase;
  final bool? atLeast8;
  final String? message;
  final Email email;
  final Password password;
  final FullName fullName;
  final Phone phone;
  final ConfirmedPassword confirmedPassword;

  const SignUpState._({
    this.state = FormzSubmissionStatus.inProgress,
    this.obscure,
    this.secondObscure,
    this.message,
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.fullName = const FullName.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.atLeast8 = false,
    this.lowercase = false,
    this.uppercase = false,
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

  SignUpState copyWith({
    FormzSubmissionStatus? state,
    bool? obscure,
    bool? secondObscure,
    String? message,
    Email? email,
    Password? password,
    FullName? fullName,
    ConfirmedPassword? confirmedPassword,
    Phone? phone,
    bool? uppercase,
    bool? lowercase,
    bool? atLeast8,
    bool? valid,
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
      phone: phone ?? this.phone,
      atLeast8: atLeast8 ?? this.atLeast8,
      lowercase: lowercase ?? this.lowercase,
      uppercase: uppercase ?? this.uppercase,
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
        phone,
        password,
        atLeast8,
        lowercase,
        uppercase,
      ];
}

extension HomePageStateExtensions on SignUpState {
  bool get isInitial => state == FormzSubmissionStatus.initial;
  bool get isLoading => state == FormzSubmissionStatus.inProgress;
  bool get isFailure => state == FormzSubmissionStatus.failure;
  bool get isSuccess => state == FormzSubmissionStatus.success;
}

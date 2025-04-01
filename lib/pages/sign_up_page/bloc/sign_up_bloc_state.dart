part of 'sign_up_bloc.dart';

enum SignUpStateStatus {
  initial,
  loading,
  success,
  failure,
  obscure,
}

class SignUpState extends Equatable {
  final SignUpStateStatus state;
  final bool? obscure;
  final bool? secondObscure;
  final String? message;

  const SignUpState._({
    this.state = SignUpStateStatus.loading,
    this.obscure,
    this.secondObscure,
    this.message,
  });

  const SignUpState.initial() : this._(state: SignUpStateStatus.initial);

  const SignUpState.failure({required String message})
      : this._(state: SignUpStateStatus.failure, message: message);

  const SignUpState.success({required String message})
      : this._(state: SignUpStateStatus.success, message: message);

  const SignUpState.obscure(
      {required bool obscure, required bool secondObscure})
      : this._(
          state: SignUpStateStatus.obscure,
          obscure: obscure,
          secondObscure: secondObscure,
        );

  const SignUpState.loading() : this._();

  SignUpState copyWith({
    SignUpStateStatus? state,
    bool? obscure,
    bool? secondObscure,
    String? message,
  }) {
    return SignUpState._(
      state: state ?? this.state,
      obscure: obscure ?? this.obscure,
      secondObscure: secondObscure ?? this.secondObscure,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, obscure, secondObscure, message];
}

extension HomePageStateExtensions on SignUpState {
  bool get isInitial => state == SignUpStateStatus.initial;
  bool get isLoading => state == SignUpStateStatus.loading;
  bool get isObscure => state == SignUpStateStatus.obscure;
  bool get isFailure => state == SignUpStateStatus.failure;
  bool get isSuccess => state == SignUpStateStatus.success;
}

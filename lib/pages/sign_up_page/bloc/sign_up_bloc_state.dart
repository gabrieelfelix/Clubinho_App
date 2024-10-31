part of 'sign_up_bloc.dart';

abstract class ISignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends ISignUpState {}

final class SignUpSuccess extends ISignUpState {
  final AuthUserModel authUserModel;

  SignUpSuccess({required this.authUserModel});
}

final class SignUpFailure extends ISignUpState {
  final String message;

  SignUpFailure({required this.message});
}

final class SignUpProcess extends ISignUpState {}
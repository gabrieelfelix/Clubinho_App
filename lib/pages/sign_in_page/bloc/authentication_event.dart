part of 'authentication_bloc.dart';

abstract class IAuthenticationEvent extends Equatable {
  const IAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends IAuthenticationEvent {
  final String email;
  final String password;

  const SignInRequired({
    required this.email,
    required this.password,
  });
}

class SignOutRequired extends IAuthenticationEvent {}

class ChangeObscureRequired extends IAuthenticationEvent {}

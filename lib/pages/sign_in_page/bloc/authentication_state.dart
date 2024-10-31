part of 'authentication_bloc.dart';

abstract class IAuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInInitial extends IAuthenticationState {}

final class SignInSuccess extends IAuthenticationState {
  final AuthUserModel authUserModel;

  SignInSuccess({required this.authUserModel});
}

final class SignInFailure extends IAuthenticationState {
  final String message;

  SignInFailure({required this.message});
}

final class SignInProcess extends IAuthenticationState {}

final class LogOut extends IAuthenticationState {}
